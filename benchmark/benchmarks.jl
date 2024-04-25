using NMEAProtocol
using BenchmarkTools

SUITE = BenchmarkGroup()
SUITE["parsing"] = BenchmarkGroup(["private", "public"])
# SUITE["parse"]["private"] = BenchmarkGroup(["_to_system", "_to_type", "_to_int", "_to_float", "_to_decimal_deg", "_to_time", "_to_distance", "_to_speed", "_hash_msg"])

# benchmarks

SUITE["parsing"]["private"]["_to_system"] = @benchmarkable NMEAProtocol._to_system(str) setup = (str = rand(["AI","AP","BD","CD","EC","GA","GB","GI","GL","GN","GP","GQ","HC","HE","II","IN","LC","PQ","QZ","SD","ST","TI","YX","WI"]))
SUITE["parsing"]["private"]["_to_type"] = @benchmarkable NMEAProtocol._to_type(str) setup = (str = rand(["GGA","GSA","DTM","GBS","GLL","GSV","GST","RMC","VTG","ZDA"]))
SUITE["parsing"]["private"]["_to_int"] = @benchmarkable NMEAProtocol._to_int(str) setup = (str = string(rand(Int)))
SUITE["parsing"]["private"]["_to_float"] = @benchmarkable NMEAProtocol._to_float(str) setup = (str = string(rand(Float64)))
SUITE["parsing"]["private"]["_to_decimal_deg"] = @benchmarkable NMEAProtocol._to_decimal_deg(data[1], data[2]) setup=(data=("$(rand(1000:99999)).$(rand(1000:99999999))", string(rand(["N", "S", "E", "W"]))))
SUITE["parsing"]["private"]["_to_time"] = @benchmarkable NMEAProtocol._to_time(ts) setup=(ts="$(lpad(rand(0:1:23),2,"0"))$(lpad(rand(0:1:59),2,"0"))$(rand(0:1:59)).$(rand(0:1:999))")
SUITE["parsing"]["private"]["_to_distance"] = @benchmarkable NMEAProtocol._to_distance(data[1], data[2]) setup=(data=("$(rand(Float16))", string(rand(["K", "M", "F", "N"]))))
SUITE["parsing"]["private"]["_to_speed"] = @benchmarkable NMEAProtocol._to_speed(data[1], data[2]) setup=(data=("$(rand(Float16))", string(rand(["K", "M", "N"]))))
SUITE["parsing"]["private"]["_hash_msg"] = @benchmarkable NMEAProtocol._hash_msg(raw"$GPGGA,135020.000,5540.2676,N,01231.2830,E,2,10,0.8,24.7,M,41.5,M,3.8,0000*4E")

SUITE["parsing"]["public"]["parse{NMEAPacket} (GGA)"] = @benchmarkable NMEAProtocol.parse(NMEAPacket, raw"$GPGGA,135020.000,5540.2676,N,01231.2830,E,2,10,0.8,24.7,M,41.5,M,3.8,0000*4E")
SUITE["parsing"]["public"]["parse{NMEAPacket} (GSA)"] = @benchmarkable NMEAProtocol.parse(NMEAPacket, raw"$GPGSA,A,3,03,06,32,11,19,14,01,22,18,28,,,1.8,0.8,1.6*3F")
SUITE["parsing"]["public"]["parse{NMEAPacket{GGA}}"] = @benchmarkable NMEAProtocol.parse(NMEAPacket, raw"$GPGGA,135020.000,5540.2676,N,01231.2830,E,2,10,0.8,24.7,M,41.5,M,3.8,0000*4E")
SUITE["parsing"]["public"]["parse{NMEAPacket{GSA}}"] = @benchmarkable NMEAProtocol.parse(NMEAPacket, raw"$GPGSA,A,3,03,06,32,11,19,14,01,22,18,28,,,1.8,0.8,1.6*3F")