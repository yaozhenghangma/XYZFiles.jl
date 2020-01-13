mutable struct Atom
    symbol::String
    position::Array{Float64, 1}

    Atom() = new(" ", [0.0, 0.0, 0.0])
    function Atom(sym::String, pos::Array{T, 1}) where T<:Real
        if length(pos) != 3
            throw(BoundsError(pos, length(pos)))
        else
            new(sym, Array{Float64, 1}(pos))
        end
    end
end