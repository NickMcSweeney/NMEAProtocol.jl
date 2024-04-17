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

_to_system(id::AbstractString)::SYSTEM.T = get(TalkerID, id, SYSTEM.UNKNOWN)


# """
#     _to_int(item)
# Converts a string representing an integer to a Int, if parse fails it defaults to 0.
# """
# _to_int(item::AbstractString)::Int = something(tryparse(Int, item), 0)
# _to_int(::Nothing)::Int = 0
# _to_int(items::Vector{S}, idx::Int) where S <: AbstractString = _to_int(get(items, idx, nothing))

# """
# _to_float(item)
# Converts a string representing an float to a Float64, if parse fails it defaults to 0.0.
# """
# _to_float(item::AbstractString)::Float64 = something(tryparse(Float64, item), 0.0)
# _to_float(::Nothing)::Float64 = 0.0
# _to_float(items::Vector{S}, idx::Int) where S <: AbstractString = _to_float(get(items, idx, nothing))

# """
#     _dms_to_dd(dms, hemi)

# Converts a string representing degrees, minutes and seconds (DMS) to decimal degrees.

# # Arguments
# - `dms`: a substring representing degrees, minutes and seconds
# - `hemi`: a substring representing the hemisphere

# # Returns
# - `dec_degrees`: the decimal degree representation of the input DMS

# # Example
# ```julia
# dms = "4807.038"
# hemi = "N"
# dec_degrees = _dms_to_dd(dms, hemi)
# ```
# """
# function _dms_to_dd(dms::T, hemi::T)::Union{Float64, Nothing} where {T <: AbstractString}
#     if dms == "" || hemi == ""
#         throw(ArgumentError("Empty string cannot be parsed"))
#     end

#     if (dms[1:1] == "0")
#         dms = dms[2:end]
#     end

#     decimalindex = findfirst('.', dms)
#     if isnothing(decimalindex)
#         throw(ArgumentError("Missing decimal index"))
#     end
#     degrees = Base.parse(Float64, dms[1:decimalindex-3])
#     minutes = Base.parse(Float64, dms[decimalindex-2:end])
#     dec_degrees = degrees + (minutes / 60)

#     if (hemi == "S" || hemi == "W")
#         dec_degrees *= -1
#     end

#     dec_degrees
# end # function _dms_to_dd
# _dms_to_dd(::Nothing, ::Nothing) = 0.0
# _dms_to_dd(::Any, ::Nothing) = 0.0
# _dms_to_dd(::Nothing, ::Any) = 0.0
# _dms_to_dd(items::Vector{S}, idx::Int) where S <: AbstractString = _dms_to_dd(get(items, idx, nothing), get(items, idx+1, nothing))

# """
#     _hms_to_secs(hms)

# Converts a string representing hours, minutes and seconds (HMS) to seconds.

# # Arguments
# - `hms`: a substring representing hours, minutes and seconds

# # Returns
# - `seconds`: the number of seconds represented by the input HMS

# # Example
# ```julia
# hms = "123519"
# seconds = _hms_to_secs(hms)
# ```
# """
# function _hms_to_secs(hms::T)::Float64 where { T <: AbstractString }
#     if length(hms) < 6
#         throw(ArgumentError("Not enough characters to be a time value"))
#     end
#     hours = Base.parse(Float64, hms[1:2])
#     minutes = Base.parse(Float64, hms[3:4])
#     seconds = Base.parse(Float64, hms[5:end])
#     (hours * 3600) + (minutes * 60) + seconds
# end # function _hms_to_secs
# _hms_to_secs(::Nothing) = 0.0
# _hms_to_secs(items::Vector{S}, idx::Int) where S <: AbstractString = _hms_to_secs(get(items, idx, nothing))
