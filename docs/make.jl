using Documenter, SingularityAppBuilder

makedocs(;
    modules=[SingularityAppBuilder],
    format=Documenter.HTML(),
    pages=[
        "Home" => "index.md",
    ],
    repo="https://github.com/SebastianM-C/SingularityAppBuilder.jl/blob/{commit}{path}#L{line}",
    sitename="SingularityAppBuilder.jl",
    authors="Sebastian Micluța-Câmpeanu <m.c.sebastian95@gmail.com>",
    assets=String[],
)
