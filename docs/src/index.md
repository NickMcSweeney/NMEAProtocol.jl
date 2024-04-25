```@meta
CurrentModule = NMEAProtocol
```

# NMEAProtocol

Documentation for [NMEAProtocol](https://github.com/NickMcSweeney/NMEAProtocol.jl).

```@contents
Pages = ["index.md"]
```

## Public Methods

```@docs
parse
```

### NMEA Type Structs

```@docs
GGA
GSA
DTM
GBS
GLL
GSV
GST
RMC
VTG
ZDA
```

## Private Methods

## Types/Structs

```@docs
NMEAProtocol.SYSTEM
NMEAPacket
```

### Parsing

```@docs
NMEAProtocol._to_system
NMEAProtocol._to_type
NMEAProtocol._to_int
NMEAProtocol._to_float
NMEAProtocol._to_decimal_deg
NMEAProtocol._to_time
NMEAProtocol._to_distance
NMEAProtocol._to_speed
NMEAProtocol._hash_msg
```

```@index
```