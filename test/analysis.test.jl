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
        @testset "_hash_msg" begin
            snoop = @snoopi_deep NMEAProtocol._hash_msg(raw"$GPGSA,A,3,03,06,32,11,19,14,01,22,18,28,,,1.8,0.8,1.6*3F")
            report = report_callees(inference_triggers(snoop))
            @test report == []
        end
    end

    @testset verbose=true "types" begin
        nmea_msgs = [
            raw"$GPGGA,134735.000,5540.3232,N,01231.2946,E,1,10,0.8,23.6,M,41.5,M,,0000*69",
            raw"$GPGSA,A,3,03,22,06,19,11,14,32,01,28,18,,,1.8,0.8,1.6*3F",
            raw"$GPRMC,134735.000,A,5540.3232,N,01231.2946,E,1.97,88.98,041112,,,A*5C",
            raw"$GPVTG,88.98,T,,M,1.97,N,3.6,K,A*36",
            raw"$GLGSV,3,3,09,72,07,273,,0*44",
            raw"$GNRMC,094810.000,A,5547.94084,N,03730.27293,E,0.25,50.34,260420,,,A,V*31",
            raw"$GNVTG,50.34,T,,M,0.25,N,0.46,K,A*14",
            raw"$GNZDA,094810.000,26,04,2020,00,00*4C",
            raw"$GNGLL,5547.94084,N,03730.27293,E,094810.000,A,A*4B",
        ]
        @testset "parse" begin
            for msg in nmea_msgs
                snoop = @snoopi_deep NMEAProtocol.parse(NMEAPacket, msg)
                report = report_callees(inference_triggers(snoop))
                @test report == []
            end
        end
        @testset "parse with sub-type" begin
            snoop = @snoopi_deep NMEAProtocol.parse(NMEAPacket{GGA}, raw"$GPGGA,134735.000,5540.3232,N,01231.2946,E,1,10,0.8,23.6,M,41.5,M,,0000*69")
            report = report_callees(inference_triggers(snoop))
            @test report == []
        end
    end
end

