using SnoopCompile, JET, Cthulhu
using JET

@testset verbose=true "code analysis" begin
    @testset verbose=true "parsing" begin
        @testset "_to_system" begin
            snoop = @snoopi_deep NMEAProtocol._to_system("GN")
            report = report_callees(inference_triggers(snoop))
            @test report == []
        end
    end

    @testset verbose=true "types" begin
        @test true
    end
end

