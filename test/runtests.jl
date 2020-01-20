using XYZFile
using Test

@testset "read" begin
    allAtoms = XYZFile.read("test.xyz", ["energy",])

    io = open("test.xyz", "r")
    allAtoms1 = XYZFile.read(io, ["energy",])
    close(io)

    io = open("test.xyz", "r")
    allAtoms2 = XYZFile.read(io)
    close(io)

    allAtoms3 = XYZFile.read("test.xyz")

    XYZFile.write("test_output.xyz", allAtoms1)
    @test length(allAtoms) == 3
    @test length(allAtoms1[1]) == 8
    @test length(allAtoms2[2]) == 6
    @test length(allAtoms3[3]) == 4
end
