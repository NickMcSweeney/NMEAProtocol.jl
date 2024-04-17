using PkgBenchmark

pkgdir = normpath(joinpath(dirname(Base.locate_package(Base.identify_package("NMEAProtocol"))), ".."))

baseline_path = joinpath(pkgdir,"benchmark","baseline")
results_path = joinpath(pkgdir, "docs", "src", "benchmark.md")
judgement_path = joinpath(pkgdir, "benchmark", "judgement.md")

baseline = readresults(baseline_path)

results = benchmarkpkg(NMEAProtocol)
export_markdown(results_path, results, export_invariants=true)

judgement = judge(results, baseline)
export_markdown(judgement_path, judgement, export_invariants=true)

# PkgBenchmark.writeresults(baseline_path, results)

@testset verbose=true "benchmark" begin
    for (key,group) in judgement.benchmarkgroup
        @testset verbose=true "benchmarking $key suite" begin
            for (tkey, trial) in group
                @testset "$tkey trial" begin
                    @test trial.time !== :regression
                    @test trial.memory !== :regression
                end
            end
        end
    end
end