module RayTracer

using LinearAlgebra
using Images

# Order of inclusion is important
include("base_structs.jl")
include("camera.jl")
include("interactions.jl")
include("renderer.jl")

for obj_file ∈ readdir(joinpath(@__DIR__, "objects"); join=true)
    include(obj_file)
end

export Camera, render
end
