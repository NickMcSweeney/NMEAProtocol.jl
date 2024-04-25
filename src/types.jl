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

## Format

        \$<TalkerID>GGA,<Timestamp>,<Lat>,<N/S>,<Long>,<E/W>,<GPSQual>,<Sats>,<HDOP>,<Alt>,<AltVal>,<GeoSep>,<GeoVal>,<DGPSAge>,<DGPSRef>*<checksum><CR><LF>

## Example

        \$GPGGA,172814.0,3723.46587704,N,12202.26957864,W,2,6,1.2,18.893,M,-25.669,M,2.0 0031*4F
"""
struct GGA <: AbstractNMEAMessage
x
end

"""
    GSA

"""
struct GSA <: AbstractNMEAMessage
x
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