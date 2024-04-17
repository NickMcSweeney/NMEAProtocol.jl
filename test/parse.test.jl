@testset verbose=true "_to_system" begin
    @testset "Eval string talker id: AI to system enum: ALARM" begin
        @test NMEAProtocol._to_system("AI") === NMEAProtocol.SYSTEM.ALARM
    end
    @testset "Eval string talker id: AP to system enum: AutoPilot" begin
        @test NMEAProtocol._to_system("AP") === NMEAProtocol.SYSTEM.AutoPilot
    end
    @testset "Eval string talker id: BD to system enum: BeiDou" begin
        @test NMEAProtocol._to_system("BD") === NMEAProtocol.SYSTEM.BeiDou
    end
    @testset "Eval string talker id: CD to system enum: DSC" begin
        @test NMEAProtocol._to_system("CD") === NMEAProtocol.SYSTEM.DSC
    end
    @testset "Eval string talker id: EC to system enum: ECDIS" begin
        @test NMEAProtocol._to_system("EC") === NMEAProtocol.SYSTEM.ECDIS
    end
    @testset "Eval string talker id: GA to system enum: Galileo" begin
        @test NMEAProtocol._to_system("GA") === NMEAProtocol.SYSTEM.Galileo
    end
    @testset "Eval string talker id: GB to system enum: BeiDou" begin
        @test NMEAProtocol._to_system("GB") === NMEAProtocol.SYSTEM.BeiDou
    end
    @testset "Eval string talker id: GI to system enum: NavIC" begin
        @test NMEAProtocol._to_system("GI") === NMEAProtocol.SYSTEM.NavIC
    end
    @testset "Eval string talker id: GL to system enum: GLONASS" begin
        @test NMEAProtocol._to_system("GL") === NMEAProtocol.SYSTEM.GLONASS
    end
    @testset "Eval string talker id: GN to system enum: COMBINED" begin
        @test NMEAProtocol._to_system("GN") === NMEAProtocol.SYSTEM.COMBINED
    end
    @testset "Eval string talker id: GP to system enum: GPS" begin
        @test NMEAProtocol._to_system("GP") === NMEAProtocol.SYSTEM.GPS
    end
    @testset "Eval string talker id: GQ to system enum: QZSS" begin
        @test NMEAProtocol._to_system("GQ") === NMEAProtocol.SYSTEM.QZSS
    end
    @testset "Eval string talker id: HC to system enum: COMPASS" begin
        @test NMEAProtocol._to_system("HC") === NMEAProtocol.SYSTEM.COMPASS
    end
    @testset "Eval string talker id: HE to system enum: GYRO" begin
        @test NMEAProtocol._to_system("HE") === NMEAProtocol.SYSTEM.GYRO
    end
    @testset "Eval string talker id: II to system enum: Integrated" begin
        @test NMEAProtocol._to_system("II") === NMEAProtocol.SYSTEM.Integrated
    end
    @testset "Eval string talker id: IN to system enum: IntegratedNav" begin
        @test NMEAProtocol._to_system("IN") === NMEAProtocol.SYSTEM.IntegratedNav
    end
    @testset "Eval string talker id: LC to system enum: Lorian" begin
        @test NMEAProtocol._to_system("LC") === NMEAProtocol.SYSTEM.Lorian
    end
    @testset "Eval string talker id: PQ to system enum: QZSS" begin
        @test NMEAProtocol._to_system("PQ") === NMEAProtocol.SYSTEM.QZSS
    end
    @testset "Eval string talker id: QZ to system enum: QZSS" begin
        @test NMEAProtocol._to_system("QZ") === NMEAProtocol.SYSTEM.QZSS
    end
    @testset "Eval string talker id: SD to system enum: DepthSounder" begin
        @test NMEAProtocol._to_system("SD") === NMEAProtocol.SYSTEM.DepthSounder
    end
    @testset "Eval string talker id: ST to system enum: Skytraq" begin
        @test NMEAProtocol._to_system("ST") === NMEAProtocol.SYSTEM.Skytraq
    end
    @testset "Eval string talker id: TI to system enum: TurnIndicator" begin
        @test NMEAProtocol._to_system("TI") === NMEAProtocol.SYSTEM.TurnIndicator
    end
    @testset "Eval string talker id: YX to system enum: Transducer" begin
        @test NMEAProtocol._to_system("YX") === NMEAProtocol.SYSTEM.Transducer
    end
    @testset "Eval string talker id: WI to system enum: Weather" begin
        @test NMEAProtocol._to_system("WI") === NMEAProtocol.SYSTEM.Weather
    end
end