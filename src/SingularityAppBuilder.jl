module SingularityAppBuilder

using Pkg

export build_recipe, build_app

function header(bootstrap="docker", source="julia")
    return "Bootstrap: $bootstrap\nFrom: $source"
end

newline!(recipe) = recipe*"\n\n"

function environment(readonly, depot_path="/opt/julia")
    if readonly
        return "%environment\n\texport JULIA_DEPOT_PATH=:$depot_path"
    else
        return "%environment\n\texport JULIA_DEPOT_PATH=$depot_path"
    end
end

function post(project, depot_path, readonly)
    section = "%post\n"
    section * "\t# Julia packages\n\texport JULIA_DEPOT_PATH=/opt/julia\n\t"*
    "export PATH=/usr/local/julia/bin:\$PATH\n"
    section * post(project)
    if readonly
        # fix permissions
        section * "\t# Permissions\n\tchmod -R 645 $depot_path"
    end
    return section
end

function post(path::AbstractString)
    # TODO
    # return "julia -e 'using Pkg; pkg"activate $path; instantiate"'"
end

function post(packages::Pkg.Types.PackageSpec)
    # TODO
end

function build_recipe(project, path::AbstractString; bootstrap="docker", source="julia",
        readonly=true, depot_path="/opt/julia")
    recipe = header(bootstrap, source)
    newline!(recipe)
    recipe*environment(readonly, depot_path)
    newline!(recipe)

    return path
end

end # module
