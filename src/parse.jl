const TalkerID = Dict{String,SYSTEM.T}(
    "AI" => SYSTEM.ALARM,
    "AP" => SYSTEM.AutoPilot,
    "BD" => SYSTEM.BeiDou,
    "CD" => SYSTEM.DSC,
    "EC" => SYSTEM.ECDIS,
    "GA" => SYSTEM.Galileo,
    "GB" => SYSTEM.BeiDou,
    "GI" => SYSTEM.NavIC,
    "GL" => SYSTEM.GLONASS,
    "GN" => SYSTEM.COMBINED,
    "GP" => SYSTEM.GPS,
    "GQ" => SYSTEM.QZSS,
    "HC" => SYSTEM.COMPASS,
    "HE" => SYSTEM.GYRO,
    "II" => SYSTEM.Integrated,
    "IN" => SYSTEM.IntegratedNav,
    "LC" => SYSTEM.Lorian,
    "PQ" => SYSTEM.QZSS,
    "QZ" => SYSTEM.QZSS,
    "SD" => SYSTEM.DepthSounder,
    "ST" => SYSTEM.Skytraq,
    "TI" => SYSTEM.TurnIndicator,
    "YX" => SYSTEM.Transducer,
    "WI" => SYSTEM.Weather,
)

const MessageType = Dict{String, Type{<:AbstractNMEAMessage}}(
    "GGA" => GGA,
    "GSA" => GSA,
    "DTM" => DTM,
    "GBS" => GBS,
    "GLL" => GLL,
    "GSV" => GSV,
    "GST" => GST,
    "RMC" => RMC,
    "VTG" => VTG,
    "ZDA" => ZDA,
)

"""
    _to_system(id)
lookup the system being used based on the 2 character talker id
"""
_to_system(id::AbstractString)::SYSTEM.T = get(TalkerID, id, SYSTEM.UNKNOWN)

"""
    _to_type(format)
lookup the type of nmea string based on the 3 character message format identifier
"""
_to_type(format::AbstractString)::Type{<:AbstractNMEAMessage} = get(MessageType, format, UnkNMEAMessage)

"""
    _to_int(item)
Converts a string representing an integer to a Int, if parse fails it defaults to 0.
"""
_to_int(item::AbstractString)::Int = something(Parsers.tryparse(Int, item), 0)
_to_int(::Nothing)::Int = 0

"""
_to_float(item)
Converts a string representing an float to a Float64, if parse fails it defaults to 0.0.
"""
_to_float(item::AbstractString)::Float64 = something(Parsers.tryparse(Float64, item), 0.0)
_to_float(::Nothing)::Float64 = 0.0

"""
_to_decimal_deg(dms, hemi)

Converts a string representing longitude or latitude in degrees and minutes (DDDMM.mmm [N|S|E|W]) to decimal degrees (±DD.ddd).
if either arguments are nothing returns 0.0
"""
function _to_decimal_deg(dms::AbstractString, hemi::AbstractString)::Float64
    if dms === "" || hemi === "" || !occursin(".", dms) || sizeof(dms) < 6
        throw(ArgumentError("Incorrect string format. possibly missing decimal index or string is empty"))
    end

    decimalindex = findfirst('.', dms)
    degrees = something(Parsers.tryparse(Float64,view(dms, 1:decimalindex-3)), 0.0)
    minutes = something(Parsers.tryparse(Float64,view(dms, decimalindex-2:sizeof(dms))), 0.0)
    dec_degrees = degrees + (minutes / 60.0)

    if (hemi === "S" || hemi === "W")
        dec_degrees *= -1.0
    elseif (hemi === "N" || hemi === "E")
        dec_degrees *= 1.0
    else
        dec_degrees *= 0.0
    end

    dec_degrees
end # function _dms_to_dd
_to_decimal_deg(::Nothing, ::Nothing) = 0.0
_to_decimal_deg(::AbstractString, ::Nothing) = 0.0
_to_decimal_deg(::Nothing, ::AbstractString) = 0.0

"""
_to_time(timestamp)

Converts a string in the format HHMMSS.sss to a Dates.Time object. 
If the argument is nothing the current time in UTC will be returned.
"""
function _to_time(timestamp::AbstractString)::Time
    if sizeof(timestamp) < 6 || 10 < sizeof(timestamp)
        throw(ArgumentError("Unable to parse date time. Expected HHMMSS.sss format."))
    end

    # something(Parsers.tryparse(Time, timestamp, Parsers.Options(dateformat="HHMMSS.sss")), Time(now(UTC)))
    Time(timestamp, dateformat"HHMMSS.sss")
end
_to_time(::Nothing)::Time = Time(now(UTC))

"""
_to_distance(dist, unit)

convert a distance in a given unit to a distance in meters
"""
function _to_distance(dist::Float64, unit::Char)::Float64
    if unit === 'F'
        # F feet
        return dist * 0.3048
    elseif unit === 'N'
        # N miles
        return dist * 1609.344
    elseif unit === 'K'
        # K kilometer
        return dist * 1000.0
    elseif unit === 'M'
        # M meter
        return dist
    else
        throw(ArgumentError("Position unit $unit is not supported"))
    end
end
_to_distance(dist::AbstractString, unit::AbstractString)::Float64 = _to_distance(_to_float(dist), only(unit))
_to_distance(::AbstractString, ::Nothing) = 0.0
_to_distance(::Nothing, ::AbstractString) = 0.0
_to_distance(::Nothing, ::Nothing) = 0.0

"""
_to_speed(velocity, unit)

convert a speed in a given unit to a velocity in meters/s
"""
function _to_speed(velocity::Float64, unit::Char)::Float64
    if unit == 'N'
        # N knots
        return velocity / 1.94384449244
    elseif unit == 'K'
        # K kilometer per hour
        return velocity / 3.6
    elseif unit == 'M'
        # M meters per second
        return velocity
    else
        throw(ArgumentError("Velocity unit $unit is not supported"))
    end
end
_to_speed(velocity::AbstractString, unit::AbstractString)::Float64 = _to_speed(_to_float(velocity), only(unit))
_to_speed(::AbstractString, ::Nothing) = 0.0
_to_speed(::Nothing, ::AbstractString) = 0.0
_to_speed(::Nothing, ::Nothing) = 0.0

function _to_mode(modestr::AbstractString)::FixMode.T
    if modestr === "A"
        FixMode.Automatic
    elseif modestr === "M"
        FixMode.Manual
    else
        FixMode.Unknown
    end
end

function _to_fix(fixstr::AbstractString)::FixQuality.T
    if fixstr === "1"
        FixQuality.NotAvailable
    elseif fixstr === "2"
        FixQuality.TwoDimension
    elseif fixstr === "3"
        FixQuality.ThreeDimension
    else
        FixQuality.Unknown
    end
end

_char_xor(a::Char,b::Char) = xor(UInt8(a), UInt8(b))
_char_xor(a::UInt8,b::Char) = xor(a, UInt8(b))
_char_xor(a::Char,b::UInt8) = xor(UInt8(a), b)

"""
    _hash_msg(message)

perform an xor hash of a string.
"""
_hash_msg(message::AbstractString)::UInt8 = foldl(_char_xor, chopprefix(message, "\$"))

"""
    NMEAProtocol.parse(::NMEAPacket, nmeastring)
    NMEAProtocol.parse(::NMEAPacket{AbstractNMEAMessage}, nmeastring)

parses a string into a NMEAPacket. specifying the sub-type of nmea string improves performance. 
But the type will be looked up if it is not specified.
"""
function parse(::Type{NMEAPacket}, nmeastring::AbstractString)::NMEAPacket{<:AbstractNMEAMessage}
    idx = findfirst(',', nmeastring)
    T = _to_type(view(nmeastring,idx-3:idx-1))
    parse(NMEAPacket{T}, nmeastring)
end
function parse(::Type{NMEAPacket{T}}, nmeastring::AbstractString)::NMEAPacket{T} where {T<:AbstractNMEAMessage}
    ((message,checksum)) = eachsplit(nmeastring, "*", limit=2, keepempty=true)
 
    NMEAPacket{T}(
        T(message),
        valid=(_hash_msg(message) === Base.parse(UInt8, "0x$checksum"))
    )
end