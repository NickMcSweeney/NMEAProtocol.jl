using NMEAProtocol
using Documenter

DocMeta.setdocmeta!(NMEAProtocol, :DocTestSetup, :(using NMEAProtocol); recursive=true)

makedocs(;
    modules=[NMEAProtocol, NMEAProtocol.SYSTEM],
    authors="nick <nick@shindler.tech> and contributors",
    sitename="NMEAProtocol.jl",
    format=Documenter.HTML(;
        canonical="https://NickMcSweeney.github.io/NMEAProtocol.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "Benchmark" => "benchmark.md",
    ],
    warnonly = [:missing_docs]
)

deploydocs(;
    repo="github.com/NickMcSweeney/NMEAProtocol.jl",
    devbranch="main",
)
