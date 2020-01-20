module XYZFile

using AtomBase

function read(io::IOStream, properties::Array{T, 1}) where T<:AbstractProperties
    allAtoms = Array{Atoms, 1}(undef, 0)
    while (line = readline(io)) != ""
        atoms = Atoms()
        number = parse(Int64, split(line)[1])

        line = readline(io)
        words = split(line)
        for prop in properties
            reProp = Regex(prop.name*"=.*")
            matchProp(w) = !(match(reProp, w) === nothing)
            if (ind = findfirst(matchProp.(words))) !== nothing
                val = parse(eltype(prop), split(words[ind], "=")[2])
                prop(val)
                addProperty!(atoms, deepcopy(prop))
            end
        end

        for i in 1:number
            line = readline(io)
            words = split(line)
            atom = Atom(String(words[1]), [parse(Float64,words[2]), parse(Float64,words[3]), parse(Float64,words[4])])
            addAtom!(atoms, atom)
        end

        push!(allAtoms, atoms)
    end

    return allAtoms
end

function read(file::String, properties::Array{T, 1}) where T<:AbstractProperties
    io = open(file, "r")
    structures = read(io, properties)
    close(io)
    return structures
end

function read(io::IOStream)
    properties = Array{Properties, 1}(undef, 0)
    read(io, properties)
end

function read(file::String)
    properties = Array{Properties, 1}(undef, 0)
    read(file, properties)
end

function read(io::IOStream, propertiesString::Array{String, 1})
    properties = Array{Properties, 1}(undef, 0)
    for propString in propertiesString
        prop = Properties{Float64}(propString, 0.0)
        push!(properties, prop)
    end

    read(io, properties)
end

function read(file::String, propertiesString::Array{String, 1})
    properties = Array{Properties, 1}(undef, 0)
    for propString in propertiesString
        prop = Properties{Float64}(propString, 0.0)
        push!(properties, prop)
    end

    io = open(file, "r")
    structures = read(io, properties)
    close(io)
    return structures
end

function write(io::IOStream, allAtoms::Array{Atoms, 1})
    for atoms in allAtoms
        println(io, atoms.number)

        for prop in atoms.properties
            print(io, prop)
        end
        print(io, "\n")

        for atom in atoms.atom
            println(io, atom.symbol, "\t", atom.position[1], "\t", atom.position[2], "\t", atom.position[3])
        end
    end
    return nothing
end

function write(file::String, allAtoms::Array{Atoms, 1})
    io = open(file, "w")
    write(io, allAtoms)
    close(io)
    return nothing
end

function write(io::IOStream, atoms::Atoms)
    write(io, [atoms, ])
end

function write(file::String, atoms::Atoms)
    write(file, [atoms,])
end

end