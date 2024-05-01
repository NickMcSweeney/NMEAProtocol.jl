# Benchmark Report for */home/grath/Workspace/NMEAProtocol.jl*

## Job Properties
* Time of benchmark: 25 Apr 2024 - 23:16
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
| `["parsing", "private", "_hash_msg"]`              | 224.000 ns (5%) |         |                |             |
| `["parsing", "private", "_to_decimal_deg"]`        | 301.000 ns (5%) |         |                |             |
| `["parsing", "private", "_to_distance"]`           |  88.000 ns (5%) |         |                |             |
| `["parsing", "private", "_to_float"]`              | 120.000 ns (5%) |         |                |             |
| `["parsing", "private", "_to_int"]`                |  64.000 ns (5%) |         |                |             |
| `["parsing", "private", "_to_speed"]`              |  82.000 ns (5%) |         |                |             |
| `["parsing", "private", "_to_system"]`             |  59.000 ns (5%) |         |                |             |
| `["parsing", "private", "_to_time"]`               | 168.000 ns (5%) |         |                |             |
| `["parsing", "private", "_to_type"]`               |  87.000 ns (5%) |         |                |             |
| `["parsing", "public", "parse{NMEAPacket{GGA}}"]`  |   4.715 μs (5%) |         |  1.35 KiB (1%) |          23 |
| `["parsing", "public", "parse{NMEAPacket{GSA}}"]`  |   1.679 μs (5%) |         | 392 bytes (1%) |           9 |
| `["parsing", "public", "parse{NMEAPacket} (GGA)"]` |   4.732 μs (5%) |         |  1.35 KiB (1%) |          23 |
| `["parsing", "public", "parse{NMEAPacket} (GSA)"]` |   1.665 μs (5%) |         | 392 bytes (1%) |           9 |

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
       #1  3658 MHz      36501 s        174 s       8678 s     291165 s       1439 s
       #2  3661 MHz      35861 s         38 s       5801 s     295717 s        619 s
       #3  3643 MHz      35191 s         42 s       8214 s     289284 s       3787 s
       #4  3682 MHz      36139 s         94 s       8395 s     290982 s       2116 s
  Memory: 23.363494873046875 GB (13906.75 MB free)
  Uptime: 34643.13 sec
  Load Avg:  1.37  1.41  1.19
  WORD_SIZE: 64
  LIBM: libopenlibm
  LLVM: libLLVM-15.0.7 (ORCJIT, ivybridge)
Threads: 4 default, 0 interactive, 2 GC (on 4 virtual cores)
```