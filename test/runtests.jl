using XYZ
using Test

@testset "read" begin
    allAtoms = XYZ.read("test.xyz", ["energy",])

    io = open("test.xyz", "r")
    allAtoms1 = XYZ.read(io, ["energy",])
    close(io)

    io = open("test.xyz", "r")
    allAtoms2 = XYZ.read(io)
    close(io)

    allAtoms3 = XYZ.read("test.xyz")

    XYZ.write("test_output.xyz", allAtoms1)
    @test length(allAtoms) == 3
    @test length(allAtoms1[1]) == 8
    @test length(allAtoms2[2]) == 6
    @test length(allAtoms3[3]) == 4
end
