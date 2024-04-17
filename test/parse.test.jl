using NMEAProtocol: _to_system
using NMEAProtocol: _to_float, _to_int
using NMEAProtocol: _to_decimal_deg, _to_time
using NMEAProtocol: _to_distance, _to_speed
using NMEAProtocol: SYSTEM

using Dates

@testset verbose = true "Private Methods" begin
    @testset "_to_system" begin
        @testset "Eval string talker id: AI to system enum: ALARM" begin
            @test _to_system("AI") === SYSTEM.ALARM
        end
        @testset "Eval string talker id: AP to system enum: AutoPilot" begin
            @test _to_system("AP") === SYSTEM.AutoPilot
        end
        @testset "Eval string talker id: BD to system enum: BeiDou" begin
            @test _to_system("BD") === SYSTEM.BeiDou
        end
        @testset "Eval string talker id: CD to system enum: DSC" begin
            @test _to_system("CD") === SYSTEM.DSC
        end
        @testset "Eval string talker id: EC to system enum: ECDIS" begin
            @test _to_system("EC") === SYSTEM.ECDIS
        end
        @testset "Eval string talker id: GA to system enum: Galileo" begin
            @test _to_system("GA") === SYSTEM.Galileo
        end
        @testset "Eval string talker id: GB to system enum: BeiDou" begin
            @test _to_system("GB") === SYSTEM.BeiDou
        end
        @testset "Eval string talker id: GI to system enum: NavIC" begin
            @test _to_system("GI") === SYSTEM.NavIC
        end
        @testset "Eval string talker id: GL to system enum: GLONASS" begin
            @test _to_system("GL") === SYSTEM.GLONASS
        end
        @testset "Eval string talker id: GN to system enum: COMBINED" begin
            @test _to_system("GN") === SYSTEM.COMBINED
        end
        @testset "Eval string talker id: GP to system enum: GPS" begin
            @test _to_system("GP") === SYSTEM.GPS
        end
        @testset "Eval string talker id: GQ to system enum: QZSS" begin
            @test _to_system("GQ") === SYSTEM.QZSS
        end
        @testset "Eval string talker id: HC to system enum: COMPASS" begin
            @test _to_system("HC") === SYSTEM.COMPASS
        end
        @testset "Eval string talker id: HE to system enum: GYRO" begin
            @test _to_system("HE") === SYSTEM.GYRO
        end
        @testset "Eval string talker id: II to system enum: Integrated" begin
            @test _to_system("II") === SYSTEM.Integrated
        end
        @testset "Eval string talker id: IN to system enum: IntegratedNav" begin
            @test _to_system("IN") === SYSTEM.IntegratedNav
        end
        @testset "Eval string talker id: LC to system enum: Lorian" begin
            @test _to_system("LC") === SYSTEM.Lorian
        end
        @testset "Eval string talker id: PQ to system enum: QZSS" begin
            @test _to_system("PQ") === SYSTEM.QZSS
        end
        @testset "Eval string talker id: QZ to system enum: QZSS" begin
            @test _to_system("QZ") === SYSTEM.QZSS
        end
        @testset "Eval string talker id: SD to system enum: DepthSounder" begin
            @test _to_system("SD") === SYSTEM.DepthSounder
        end
        @testset "Eval string talker id: ST to system enum: Skytraq" begin
            @test _to_system("ST") === SYSTEM.Skytraq
        end
        @testset "Eval string talker id: TI to system enum: TurnIndicator" begin
            @test _to_system("TI") === SYSTEM.TurnIndicator
        end
        @testset "Eval string talker id: YX to system enum: Transducer" begin
            @test _to_system("YX") === SYSTEM.Transducer
        end
        @testset "Eval string talker id: WI to system enum: Weather" begin
            @test _to_system("WI") === SYSTEM.Weather
        end
    end

    @testset "_to_int" begin
        @test _to_int("9") === 9
        @test _to_int(nothing) === 0
    end

    @testset "_to_float" begin
        @test _to_float("3.33") === 3.33
        @test _to_float(nothing) === 0.0
    end

    @testset "_to_decimal_deg" begin
        @testset "Coordinates in europe" begin
            @test _to_decimal_deg("5211.05", "N") ≈ 52.1841667
            @test _to_decimal_deg("00431.45", "E") ≈ 4.5241667
        end

        @testset "Coordinates in north america" begin
            @test _to_decimal_deg("4737.22988", "N") ≈ 47.620498
            @test _to_decimal_deg("12220.95812", "W") ≈ -122.349302
        end

        @testset "Coordinates in south america" begin
            @test _to_decimal_deg("2257.11532", "S") ≈ -22.951922
            @test _to_decimal_deg("4312.62676", "W") ≈ -43.210446
        end

        @testset "Coordinates in oceana" begin
            @test _to_decimal_deg("3351.43223", "S") ≈ -33.8572038
            @test _to_decimal_deg("15112.90708", "E") ≈ 151.215118
        end
        @testset "Invalid coordinate lookup" begin
            @test _to_decimal_deg(nothing, nothing) === 0.0
            @test _to_decimal_deg("3351.43223", nothing) === 0.0
            @test _to_decimal_deg(nothing, "E") === 0.0
            @test _to_decimal_deg("ddMM.mmm", "Q") === 0.0
        end

        @testset "exception case" begin
            @test_throws ArgumentError _to_decimal_deg("","")
            @test_throws ArgumentError _to_decimal_deg("000000000", "W")
            @test_throws ArgumentError _to_decimal_deg("", "S")
            @test_throws ArgumentError _to_decimal_deg("3351.43223", "")
            @test_throws ArgumentError _to_decimal_deg("4.5", "W")
        end
    end

    @testset "_to_time" begin
        @test _to_time("230000.000") === Time(23)
        @test _to_time("000001.030") === Time(Second(1), Millisecond(30))
        @test_throws ArgumentError _to_time("260000")
        @test_throws ArgumentError _to_time("000")
        @test_throws ArgumentError _to_time("0000000000000")
        @test second(_to_time(nothing)) == second(Time(now(UTC)))
    end

    @testset "_to_distance" begin
        # Test conversion from feet to meters
        @test _to_distance("10.0", "F") ≈ 3.048
        # Test conversion from miles to meteres
        @test _to_distance("3.12", "N") ≈ 5021.15328
        # Test conversion from kilometers to meters
        @test _to_distance("5.0", "K") === 5000.0
        # Test conversion from meters (no conversion needed)
        @test _to_distance("5000.0", "M") === 5000.0
        # Test for unsupported unit
        @test_throws ArgumentError _to_distance("10.0", "_")
    end

    @testset "_to_speed" begin
        @test _to_speed("19.4384449244", "N") ≈ 10.0
        @test _to_speed("36.0", "K") === 10.0
        @test _to_speed("10.0", "M") === 10.0
        @test_throws ArgumentError _to_speed("10.0", "X")
    end
end

@testset verbose = true "Public Methods" begin

end