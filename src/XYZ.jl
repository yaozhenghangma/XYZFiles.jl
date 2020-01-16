module XYZ

using AtomBase

function read(io::IOStream, properties::Array{AbstractProperties, 1})
    allAtoms = Array{Atoms, 1}(undef, 0)
    while (line = readline(io)) != ""
        atoms = Atoms()
        number = parse(Int64, split(line, " ")[1])

        line = readline(io)
        words = split(line, " ")
        for prop in properties
            reProp = Regex(prop*"=.*")
            matchProp(w) = match(reProp, w) === nothing
            ind = findfirst(matchProp.(words))
            val = parse(eltype(prop), split(words[ind], "=")[2])
            prop(val)
            addProperty!(atoms, prop)
        end

        for i in 1:number
            line = readline(io)
            words = split(line, " ")
            atom = Atom(words[1], [parse(Float64,words[2]), parse(Float64,words[3]), parse(Float64,words[4])])
            addAtom!(atoms, atom)
        end

        push!(allAtoms, atoms)
    end

    return allAtoms
end

function read(file::String, properties::Array{AbstractProperties, 1})
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

end