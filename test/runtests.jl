using XYZ
using Test

@testset "read" begin
    allAtoms = XYZ.read("test.xyz", ["energy",])
    @test length(allAtoms) == 3
    @test length(allAtoms[1]) == 8
    @test length(allAtoms[2]) == 6
    @test length(allAtoms[3]) == 4
end
