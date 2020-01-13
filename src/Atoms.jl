mutable struct Properity{T}
    name::String 
    value::T
end

mutable struct Atoms
    atom::Array{Atom, 1}
    number::Int64
    properity::Array{Properity, 1}
end