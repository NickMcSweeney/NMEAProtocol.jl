using Aqua, NMEAProtocol

@testset verbose=true "Code quality test with Aqua" begin
    @testset verbose=true "Test ambiguitie" begin
        Aqua.test_ambiguities([NMEAProtocol, Base, Core])
    end
    @testset verbose=true "Test unbound arguments" begin
        Aqua.test_unbound_args(NMEAProtocol)
    end
    @testset verbose=true "Test exports" begin
        Aqua.test_undefined_exports(NMEAProtocol)
    end
    @testset verbose=true "Test project extras" begin
        Aqua.test_project_extras(NMEAProtocol)
    end
    @testset verbose=true "Test stale dependancies" begin
        Aqua.test_stale_deps(NMEAProtocol; ignore = [:Aqua])
    end
    # @testset verbose=true "Test dependancy compatability" begin
    #     Aqua.test_deps_compat(NMEAProtocol)
    # end
end