using XYZFiles
using Test

@testset "read" begin
    allAtoms = XYZFiles.read("test.xyz", ["energy",])

    io = open("test.xyz", "r")
    allAtoms1 = XYZFiles.read(io, ["energy",])
    close(io)

    io = open("test.xyz", "r")
    allAtoms2 = XYZFiles.read(io)
    close(io)

    allAtoms3 = XYZFiles.read("test.xyz")

    XYZFiles.write("test_output.xyz", allAtoms1)
    @test length(allAtoms) == 3
    @test length(allAtoms1[1]) == 8
    @test length(allAtoms2[2]) == 6
    @test length(allAtoms3[3]) == 4
end
