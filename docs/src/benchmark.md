# Benchmark Report for */home/grath/Workspace/NMEAProtocol.jl*

## Job Properties
* Time of benchmark: 25 Apr 2024 - 18:43
* Package commit: dirty
* Julia commit: bd47ec
* Julia command flags: None
* Environment variables: None

## Results
Below is a table of this job's results, obtained by running the benchmarks.
The values listed in the `ID` column have the structure `[parent_group, child_group, ..., key]`, and can be used to
index into the BaseBenchmarks suite to retrieve the corresponding benchmarks.
The percentages accompanying time and memory values in the below table are noise tolerances. The "true"
time/memory value for a given benchmark is expected to fall within this percentage of the reported value.
An empty cell means that the value was zero.

| ID                                                 | time            | GC time | memory         | allocations |
|----------------------------------------------------|----------------:|--------:|---------------:|------------:|
| `["parsing", "private", "_hash_msg"]`              | 216.000 ns (5%) |         |                |             |
| `["parsing", "private", "_to_decimal_deg"]`        | 313.000 ns (5%) |         |                |             |
| `["parsing", "private", "_to_distance"]`           |  83.000 ns (5%) |         |                |             |
| `["parsing", "private", "_to_float"]`              | 148.000 ns (5%) |         |                |             |
| `["parsing", "private", "_to_int"]`                |  83.000 ns (5%) |         |                |             |
| `["parsing", "private", "_to_speed"]`              |  82.000 ns (5%) |         |                |             |
| `["parsing", "private", "_to_system"]`             |  73.000 ns (5%) |         |                |             |
| `["parsing", "private", "_to_time"]`               | 160.000 ns (5%) |         |                |             |
| `["parsing", "private", "_to_type"]`               |  66.000 ns (5%) |         |                |             |
| `["parsing", "public", "parse{NMEAPacket{GGA}}"]`  |   1.854 μs (5%) |         | 392 bytes (1%) |           9 |
| `["parsing", "public", "parse{NMEAPacket{GSA}}"]`  |   1.827 μs (5%) |         | 392 bytes (1%) |           9 |
| `["parsing", "public", "parse{NMEAPacket} (GGA)"]` |   1.863 μs (5%) |         | 392 bytes (1%) |           9 |
| `["parsing", "public", "parse{NMEAPacket} (GSA)"]` |   1.785 μs (5%) |         | 392 bytes (1%) |           9 |

## Benchmark Group List
Here's a list of all the benchmark groups executed by this job:

- `["parsing", "private"]`
- `["parsing", "public"]`

## Julia versioninfo
```
Julia Version 1.10.2
Commit bd47eca2c8a (2024-03-01 10:14 UTC)
Build Info:
  Official https://julialang.org/ release
Platform Info:
  OS: Linux (x86_64-linux-gnu)
      "Arch Linux"
  uname: Linux 6.8.2-arch2-1 #1 SMP PREEMPT_DYNAMIC Thu, 28 Mar 2024 17:06:35 +0000 x86_64 unknown
  CPU: Intel(R) Core(TM) i5-3570 CPU @ 3.40GHz: 
              speed         user         nice          sys         idle          irq
       #1  3584 MHz      18252 s         65 s       4548 s     153731 s        758 s
       #2  3262 MHz      18463 s         36 s       3017 s     155569 s        362 s
       #3  3450 MHz      17946 s         40 s       4373 s     152345 s       2009 s
       #4  3666 MHz      18429 s         63 s       4417 s     153183 s       1145 s
  Memory: 23.363494873046875 GB (15624.2578125 MB free)
  Uptime: 18235.35 sec
  Load Avg:  1.68  1.23  1.26
  WORD_SIZE: 64
  LIBM: libopenlibm
  LLVM: libLLVM-15.0.7 (ORCJIT, ivybridge)
Threads: 4 default, 0 interactive, 2 GC (on 4 virtual cores)
```