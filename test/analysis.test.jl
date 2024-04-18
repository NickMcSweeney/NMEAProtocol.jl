using SnoopCompile, JET, Cthulhu
using JET

@testset verbose=true "code analysis" begin
    @testset verbose=true "parsing" begin
        @testset "_to_system" begin
            snoop = @snoopi_deep NMEAProtocol._to_system(rand(["AI","AP","BD","CD","EC","GA","GB","GI","GL","GN","GP","GQ","HC","HE","II","IN","LC","PQ","QZ","SD","ST","TI","YX","WI"]))
            report = report_callees(inference_triggers(snoop))
            @test report == []
        end
        @testset "_to_type" begin
            snoop = @snoopi_deep NMEAProtocol._to_type(rand(["GGA","GSA","DTM","GBS","GLL","GSV","GST","RMC","VTG","ZDA"]))
            report = report_callees(inference_triggers(snoop))
            @test report == []
        end
        @testset "_to_int" begin
            snoop = @snoopi_deep NMEAProtocol._to_int(string(rand(Int16)))
            report = report_callees(inference_triggers(snoop))
            @test report == []
        end
        @testset "_to_float" begin
            snoop = @snoopi_deep NMEAProtocol._to_float(string(rand(Float16)*rand(Int16)))
            report = report_callees(inference_triggers(snoop))
            @test report == []
        end
        @testset "_to_decimal_deg" begin
            snoop = @snoopi_deep NMEAProtocol._to_decimal_deg("$(rand(1000:99999)).$(rand(1000:99999999))", string(rand(["N", "S", "E", "W"])))
            report = report_callees(inference_triggers(snoop))
            @test report == []
        end
        @testset "_to_time" begin
            snoop = @snoopi_deep NMEAProtocol._to_time("$(lpad(rand(0:1:23),2,"0"))$(lpad(rand(0:1:59),2,"0"))$(rand(0:1:59)).$(rand(0:1:999))")
            report = report_callees(inference_triggers(snoop))
            @test report == []
        end
        @testset "_to_distance" begin
            snoop = @snoopi_deep NMEAProtocol._to_distance("$(rand(Float16))", string(rand(["K", "M", "F", "N"])))
            report = report_callees(inference_triggers(snoop))
            @test report == []
        end
        @testset "_to_speed" begin
            snoop = @snoopi_deep NMEAProtocol._to_speed("$(rand(Float16))", string(rand(["K", "M", "N"])))
            report = report_callees(inference_triggers(snoop))
            @test report == []
        end
    end

    @testset verbose=true "types" begin
        @test true
    end
end

