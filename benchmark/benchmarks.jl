using NMEAProtocol
using BenchmarkTools

SUITE = BenchmarkGroup()
SUITE["parse"] = BenchmarkGroup(["_to_system", "_to_int", "_to_float", "_to_decimal_deg"])

# benchmarks

SUITE["parse"]["_to_system"] = @benchmarkable NMEAProtocol._to_system(str) setup = (str = rand(["AI","AP","BD","CD","EC","GA","GB","GI","GL","GN","GP","GQ","HC","HE","II","IN","LC","PQ","QZ","SD","ST","TI","YX","WI"]))
SUITE["parse"]["_to_type"] = @benchmarkable NMEAProtocol._to_type(str) setup = (str = rand(["GGA","GSA","DTM","GBS","GLL","GSV","GST","RMC","VTG","ZDA"]))
SUITE["parse"]["_to_int"] = @benchmarkable NMEAProtocol._to_int(str) setup = (str = string(rand(Int)))
SUITE["parse"]["_to_float"] = @benchmarkable NMEAProtocol._to_float(str) setup = (str = string(rand(Float64)))
SUITE["parse"]["_to_decimal_deg"] = @benchmarkable NMEAProtocol._to_decimal_deg(data[1], data[2]) setup=(data=("$(rand(1000:99999)).$(rand(1000:99999999))", string(rand(["N", "S", "E", "W"]))))
SUITE["parse"]["_to_time"] = @benchmarkable NMEAProtocol._to_time(ts) setup=(ts="$(lpad(rand(0:1:23),2,"0"))$(lpad(rand(0:1:59),2,"0"))$(rand(0:1:59)).$(rand(0:1:999))")
SUITE["parse"]["_to_distance"] = @benchmarkable NMEAProtocol._to_distance(data[1], data[2]) setup=(data=("$(rand(Float16))", string(rand(["K", "M", "F", "N"]))))
SUITE["parse"]["_to_speed"] = @benchmarkable NMEAProtocol._to_speed(data[1], data[2]) setup=(data=("$(rand(Float16))", string(rand(["K", "M", "N"]))))