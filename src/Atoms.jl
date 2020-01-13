mutable struct Properties
    name::String 
    value

    Properties() = new(" ", 0.0)
    function Properties(name::String, val)
        new(name, val)
    end
end

mutable struct Atoms
    atom::Array{Atom, 1}
    number::Int64
    Properties::Array{Properties, 1}

    Atoms() = new(Array{Atom, 1}(undef, 0), 0, Array{Properties, 1}(undef, 0))
    function Atoms(atom::Array{Atom, 1}, num::Int64, prop::Array{Properties, 1})
        if num == length(Array)
            new(atom, num, prop)
        else
            throw(BoundsError(atom, num))
        end
    end

    function Atoms(atom::Array{Atom, 1}, prop::Array{Properties, 1})
        Atoms(atom, length(atom), prop)
    end

    function Atoms(atom::Array{Atom, 1})
        Atoms(atom, length(atom), Array{Properties, 1}(undef, 0))
    end

    function Atoms(atom::Atom, prop::Array{Properties, 1})
        Atoms([atom, ], 1, prop)
    end

    function Atoms(atom::Atom)
        Atoms([atom, ], 1, Array{Float64, 1}(undef, 0))
    end

    function Atoms(atom::Array{Atom, 1}, num::Int64, prop::Properties)
        if num == length(Array)
            new(atom, num, [prop, ])
        else
            throw(BoundsError(atom, num))
        end
    end

    function Atoms(atom::Array{Atom, 1}, prop::Properties)
        Atoms(atom, length(atom), [prop, ])
    end

    function Atoms(atom::Atom, prop::Properties)
        Atoms([atom, ], 1, [prop, ])
    end
end