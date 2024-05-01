"""
    SYSTEM

NMEA sentences include a Talker Identifier (ID) after the “\$” sign. The talker ID is a two-character prefix that identifies the type of the transmitting unit. 

Standard Systems are:
- GA	European Global Navigation System (Galileo
- GB	BeiDou Navigation Satellite System (BDS)
- GI	Navigation Indian Constellatiozn (NavIC)
- GL	Globalnaya Navigazionnaya Sputnikovaya Sistema (GLONASS)
- GN	Global Navigation Satellite System (GNSS)
- GP	Global Positioning System (GPS)
- GQ	Quasi-Zenith Satellite System (QZSS)

There are aditional IDs for non-standard sources.
"""
@enumx SYSTEM::UInt8 begin
    "Combination of multiple satellite systems (NMEA 1083)"
    COMBINED 
    "Global Positioning System receiver (USA)"
    GPS 
    "European Global Navigation System (Galileo)"
    Galileo 
    "GLONASS Globalnaya Navigazionnaya Sputnikovaya Sistema (Russia)"
    GLONASS 
    "QZSS regional GPS augmentation system (Japan)"
    QZSS 
    "BeiDou Navigation Satellite System (China)"
    BeiDou 
    "NavIC Navigation Indian Constellation, IRNSS (India)"
    NavIC
    "Proprietary (Vendor specific)"
    PROPRIETARY 
    "Alarm Indicator, (AIS?)"
    ALARM 
    "Auto Pilot (pypilot?)"
    AutoPilot 
    "Digital Selective Calling (DSC)"
    DSC 
    "Electronic Chart Display & Information System (ECDIS)"
    ECDIS 
    "Heading/Compass"
    COMPASS 
    "Gyro, north seeking"
    GYRO 
    "Integrated Instrumentation"
    Integrated
    "Integrated Navigation"
    IntegratedNav 
    "Loran-C receiver (obsolete)"
    Lorian 
    "Depth Sounder"
    DepthSounder 
    "Skytraq"
    Skytraq 
    "Turn Indicator"
    TurnIndicator 
    "Transducer"
    Transducer 
    "Weather Instrument"
    Weather
    "Unknown Talker ID"
    UNKNOWN
end

@enumx FixMode::UInt8 begin
    "Fix mode is unknown"
    Unknown
    "Forced to operate in 2D or 3D mode"
    Manual
    "Allowed to automatically switch 2D/3D"
    Automatic
end

@enumx FixQuality::UInt8 begin
    "Fix value is unknown"
    Unknown
    "This indicates that a fix is not available or has not been determined by the GPS receiver. It typically happens when the receiver hasn't acquired enough satellite signals to calculate a position fix."
    NotAvailable
    "This indicates that the GPS receiver has calculated a position fix using signals from satellites in two dimensions, meaning it has determined latitude and longitude coordinates but not altitude."
    TwoDimension
    "This indicates that the GPS receiver has calculated a position fix using signals from satellites in three dimensions, meaning it has determined latitude, longitude, and altitude coordinates."
    ThreeDimension
end


"""
    NMEAPacket
    NMEAPacket{<:AbstractNMEAMessage}

wrapping type of all nmea messages. contains information from the string header.
The satelite system used, the time the string was parsed and if the checksum matches the message hash.
and of course the NMEA string for the data.
"""
struct NMEAPacket{T <: AbstractNMEAMessage} <: AbstractNMEAPacket
    system::SYSTEM.T
    timestamp::DateTime
    # type::Type
    # message::String
    message::T
    valid::Bool

    NMEAPacket{T}(message::T; system::SYSTEM.T=SYSTEM.UNKNOWN, timestamp::DateTime=now(UTC), valid::Bool=false) where {T<:AbstractNMEAMessage} = new(system, timestamp, message, valid)
end
# (packet::NMEAPacket)() = packet.header(packet.message)

"""
    UnkNMEAMessage

Empty type for invalid or unknown nmea strings.
"""
struct UnkNMEAMessage <: AbstractNMEAMessage end

"""
    GGA(msg)

## NMEA-0183 message: GGA

Time, position, and fix related data.

| Field | Character | Description | Example Value |
|-------|-----------|-------------|---------------|
| \$ | Char | Each NMEA message starts with “\$“ | \$ |
| TalkerID | String, 2 characters | The talker ID. GP: For GPS GL: For GLONASS GA: For Galileo GB: For BeiDou GI: For NAVIC (IRNSS) GQ: For QZSS GN: For multi-constellation mode | GN |
| Timestamp | hhmmss.sss | UTC time of GNSS sample: hh: hours (Fixed two digits) mm: minutes (Fixed two digits) ss: seconds (Fixed two digits) .ss: decimal fraction of seconds | 062735.00 |
| Lat | DDMM.MMMMM | Latitude as degrees: DD: Degrees (Fixed two digits) MM: Minutes (Fixed two digits) .MMMMMM: Decimal fraction of minutes | 3150.788156 |
| N/S | N or S | Latitude direction: N = North S = South | N |
| Long | DDDMM.MMMMM | Longitude as degrees: DDD: Degree (Fixed three digits) MM: Minutes (Fixed two digits) .MMMMMM: Decimal fraction of minutes | 11711.922383 |
| E/W | E or W | Longitude direction: E = East W = West | E |
| GPSQual | Decimal, 1 digit | 0 = Fix not available or invalid 1 = GPS, SPS Mode, fix valid 2 = Differential GPS, SPS Mode, fix valid 6 = Estimated (dead reckoning) mo | 1 |
| Sats | Decimal, 2 digits | Number of satellites in use. | 12 |
| HDOP | x.x | Horizontal dilution of precision. | 2.0 |
| Alt | x.x | Height above mean sea level. | 90.0 |
| AltVal | M | Reference unit for altitude: M = meter | M |
| GeoSep | x.x | Geoidal separation measures in meters. | Null |
| Geoval | M | Reference unit for geoidal separation: M = meters | M |
| DGPSAge | x.x | Age of differential corrections, sec | Null |
| DGPSRef | xxxx | Differential reference station ID | Null |
| * | | End character of data field | * |
| Checksum | <CR><LF> | Hexadecimal checksum | 55 |

### Format

        \$<TalkerID>GGA,<Timestamp>,<Lat>,<N/S>,<Long>,<E/W>,<GPSQual>,<Sats>,<HDOP>,<Alt>,<AltVal>,<GeoSep>,<GeoVal>,<DGPSAge>,<DGPSRef>*<checksum>

### Example

        \$GPGGA,172814.0,3723.46587704,N,12202.26957864,W,2,6,1.2,18.893,M,-25.669,M,2.0 0031*4F
"""
struct GGA <: AbstractNMEAMessage
    time::Time
    latitude::Float64 # decimal degrees
    longitude::Float64 # decimal degrees
    fix_quality::Int
    num_sats::Int
    HDOP::Float64
    altitude::Float64 # MSL in meters
    geoidal_seperation::Float64 # meters
    age_of_differential::Float64 # seconds since last SC104
    diff_reference_id::Int # differential reference station id

    function GGA(nmeastring::AbstractString)
        ((_, timestamp, lat, lat_dir, lon, lon_dir, qos, sats, hdop, alt, alt_unit, geoidal_seperation, seperation_unit, diff_age, diff_ref_id)) = eachsplit(nmeastring, ",", keepempty=true)
        new(
            _to_time(timestamp),
            _to_decimal_deg(lat, lat_dir),
            _to_decimal_deg(lon, lon_dir),
            _to_int(qos),
            _to_int(sats),
            _to_float(hdop),
            _to_distance(alt, alt_unit),
            _to_distance(geoidal_seperation, seperation_unit),
            _to_float(diff_age),
            _to_int(diff_ref_id),
        )
    end
end

"""
    GSA(msg)

## NMEA-0183 message: GSA

GPS DOP and Active Satellites.

| Field | Character | Description | Example Value |
|-------|-----------|-------------|---------------|
| \$ | Char | Each NMEA message starts with “\$“ | \$ |
| TalkerID | String, 2 characters | The talker ID. GP: For GPS GL: For GLONASS GA: For Galileo GB: For BeiDou GI: For NAVIC (IRNSS) GQ: For QZSS GN: For multi-constellation mode | GN |
| Mode 1 | M or A | M = Manual, A = Automatic | A |
| Mode 2: Fix Type | Char | 1 = Fix not available, 2 = 2D, 3 = 3D | 3 |
| PRN Number | Integer | Satellite PRN number (01 to 32 for GPS, 33 to 64 for SBAS, 64+ for GLONASS) | 21 |
| PDOP | Float | Position Dilution of Precision (0.5 to 99.9) | 1.2 |
| HDOP | Float | Horizontal Dilution of Precision (0.5 to 99.9) | 0.7 |
| VDOP | Float | Vertical Dilution of Precision (0.5 to 99.9) | 1.0 |
| * | | End character of data field | * |
| Checksum | <CR><LF> | Hexadecimal checksum | 55 |

### Format

        \$<TalkerID>GSA<Mode 1>,<Mode 2>,<PRN1>,<PRN2>,...<PDOP>,<HDOP>,<VDOP>*<checksum>

### Example

        \$GNGSA,A,3,21,5,29,25,12,10,26,2,,,,,1.2,0.7,1.0*27
"""
struct SatId
    sat01::Union{Int, Nothing}
    sat02::Union{Int, Nothing}
    sat03::Union{Int, Nothing}
    sat04::Union{Int, Nothing}
    sat05::Union{Int, Nothing}
    sat06::Union{Int, Nothing}
    sat07::Union{Int, Nothing}
    sat08::Union{Int, Nothing}
    sat09::Union{Int, Nothing}
    sat10::Union{Int, Nothing}
    sat11::Union{Int, Nothing}
    sat12::Union{Int, Nothing}
    SatId(s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12) = new(tryparse(Int,s1),tryparse(Int,s2),tryparse(Int,s3),tryparse(Int,s4),tryparse(Int,s5),tryparse(Int,s6),tryparse(Int,s7),tryparse(Int,s8),tryparse(Int,s9),tryparse(Int,s10),tryparse(Int,s11),tryparse(Int,s12))
end
struct GSA <: AbstractNMEAMessage
    mode::FixMode.T
    fix_type::FixQuality.T
    sat_ids::SatId
    PDOP::Float64
    HDOP::Float64
    VDOP::Float64

    function GSA(nmeastring::AbstractString)
        ((_, modeone, modetwo, sat1, sat2, sat3, sat4, sat5, sat6, sat7, sat8, sat9, sat10, sat11, sat12, pdop, hdop, vdop)) = eachsplit(nmeastring, ",", keepempty=true)
        new(
            _to_mode(modeone),
            _to_fix(modetwo),
            SatId(sat1, sat2, sat3, sat4, sat5, sat6, sat7, sat8, sat9, sat10, sat11, sat12),
            _to_float(pdop),
            _to_float(hdop),
            _to_float(vdop),
        )
    end
end

"""
    DTM

"""
struct DTM <: AbstractNMEAMessage
x
end

"""
    GBS

"""
struct GBS <: AbstractNMEAMessage
x
end

"""
    GLL

"""
struct GLL <: AbstractNMEAMessage
x
end

"""
    GSV

"""
struct GSV <: AbstractNMEAMessage
x
end

"""
    GST

"""
struct GST <: AbstractNMEAMessage
x
end

"""
    RMC

"""
struct RMC <: AbstractNMEAMessage
x
end

"""
    VTG

"""
struct VTG <: AbstractNMEAMessage
x
end

"""
    ZDA

"""
struct ZDA <: AbstractNMEAMessage
x
end


# """
#     GGA()

# ### NMEA-0183 message: GGA

# #### Format

# `\$<TalkerID>GGA,<Timestamp>,<Lat>,<N/S>,<Long>,<E/W>,<GPSQual>,<Sats>,<HDOP>,<Alt>,<AltVal>,<GeoSep>,<GeoVal>,<DGPSAge>,<DGPSRef>*<checksum><CR><LF>`

# #### Overview
# Time, position, and fix related data
# An example of the GBS message string is:

# `\$GPGGA,172814.0,3723.46587704,N,12202.26957864,W,2,6,1.2,18.893,M,-25.669,M,2.0 0031*4F`

# NOTE – The data string exceeds the NMEA standard length.
# """
# struct GGA <: NMEAString
#     system::Any
#     time::Any
#     latitude::Float64 # decimal degrees
#     longitude::Float64 # decimal degrees
#     fix_quality::String
#     num_sats::Int
#     HDOP::Float64
#     altitude::Float64 # MSL in meters
#     geoidal_seperation::Float64 # meters
#     age_of_differential::Float64 # seconds since last SC104
#     diff_reference_id::Int # differential reference station id
#     valid::Bool

#     function GGA(
#         talkerid,
#         timestamp,
#         lat,
#         lat_dir,
#         lon,
#         lon_dir,
#         qos,
#         sats,
#         hdop,
#         alt,
#         alt_unit,
#         geoidal_seperation,
#         seperation_unit,
#         diff_age,
#         diff_ref_id,
#         valid,
#     )
#         new(
#             _to_system(talkerid),
#             _to_datetime(timestamp),
#             _to_decimal_deg(lat, lat_dir),
#             _to_decimal_deg(lon, lon_dir),
#             qos,
#             sats,
#             hdop,
#             _to_distance(alt, alt_unit),
#             _to_distance(geoidal_seperation, seperation_unit),
#             diff_age,
#             diff_ref_id,
#             valid,
#         )
#     end
# end