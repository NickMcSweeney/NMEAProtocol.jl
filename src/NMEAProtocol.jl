module NMEAProtocol

"""
## ZERO allocation string splitting

@benchmark ((a,b,c)) = eachsplit("a,b,c", ",", limit=3, keepempty=true)
BenchmarkTools.Trial: 10000 samples with 825 evaluations.
 Range (min … max):  148.692 ns … 215.915 ns  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):     153.200 ns               ┊ GC (median):    0.00%
 Time  (mean ± σ):   155.621 ns ±   8.861 ns  ┊ GC (mean ± σ):  0.00% ± 0.00%

  ▇▂   ▇█▃   ▁▂ ▂▁▁▁▁▁▂       ▂▂    ▃▁  ▁                       ▂
  ███▃▅████▅▇██▆███████▇▇▇▇▆▅▄███▆▆▆██▇▇██▇▅▅▇▆▆▅▆▆▆▅▆▅▅▄▄▃▅▆▆▅ █
  149 ns        Histogram: log(frequency) by time        193 ns <

 Memory estimate: 0 bytes, allocs estimate: 0.
 ---
 
 ## versus standard splitting

@benchmark items = split("a,b,c", ",", limit=3, keepempty=true)
BenchmarkTools.Trial: 10000 samples with 501 evaluations.
 Range (min … max):  222.104 ns …   4.361 μs  ┊ GC (min … max): 0.00% … 91.29%
 Time  (median):     227.823 ns               ┊ GC (median):    0.00%
 Time  (mean ± σ):   249.957 ns ± 181.290 ns  ┊ GC (mean ± σ):  3.72% ±  4.83%

  ▇█▅▅▄▂▃▃▅▃▂▃▃▁▂▂  ▁▂▁     ▁▂▁                                 ▂
  ███████████████████████▇▇██████▇███▆▆▆▅▆▆▆▅▆▆▆▅▄▄▄▂▅▄▃▄▅▅▅▃▅▄ █
  222 ns        Histogram: log(frequency) by time        371 ns <

 Memory estimate: 272 bytes, allocs estimate: 2.

 ---
 julia> @benchmark begin
    itr = eachsplit("1,0.32,4.4", ",")
    (a,state) = iterate(itr)
    (b,state) = iterate(itr,state)
    (c,state) = iterate(itr,state)
    str = MyStruct(a,b,c)
end
BenchmarkTools.Trial: 10000 samples with 205 evaluations.
Range (min … max):  374.322 ns … 677.922 ns  ┊ GC (min … max): 0.00% … 0.00%
Time  (median):     384.990 ns               ┊ GC (median):    0.00%
Time  (mean ± σ):   390.692 ns ±  28.773 ns  ┊ GC (mean ± σ):  0.00% ± 0.00%

▇   █▁   ▂▁      ▁▂   ▁            ▁▂   ▁                     ▂
█▃▅▅██▆▆▄██▆▅▅▃▃▁███████▇▆▆▅▅▅▆▃▁▁▄██▅▆▆██▆▆▆▇█▇▆▅▅▄▄▅▇▆▆▆▆▅▆ █
374 ns        Histogram: log(frequency) by time        516 ns <

Memory estimate: 0 bytes, allocs estimate: 0.

"""

using Dates
using EnumX
using Parsers

export AbstractNMEAPacket, AbstractNMEAMessage
export SYSTEM
export NMEAPacket
export UnkNMEAMessage
export GGA, GSA, DTM, GBS, GLL, GSV, GST, RMC, VTG, ZDA

abstract type AbstractNMEAPacket end
abstract type AbstractNMEAMessage end

include("types.jl")
include("parse.jl")

end
