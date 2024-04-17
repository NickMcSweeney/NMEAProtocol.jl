using NMEAProtocol
using ReTest

module NMEATypesTests
    using ReTest, NMEAProtocol
    include("types.test.jl")
end

module NMEAParsingTests
    using ReTest, NMEAProtocol
    include("parse.test.jl")
end

module CodeQualityTests
    using ReTest, NMEAProtocol
    include("quality.test.jl")
end

module CodeAnalysisTests
    using ReTest, NMEAProtocol
    include("analysis.test.jl")
end

module BenchmarkTests
    using ReTest, NMEAProtocol
    include("benchmark.test.jl")
end

retest(NMEAProtocol, NMEATypesTests)
retest(NMEAProtocol, NMEAParsingTests)

retest(NMEAProtocol, CodeQualityTests)
retest(NMEAProtocol, CodeAnalysisTests)

retest(NMEAProtocol, BenchmarkTests)