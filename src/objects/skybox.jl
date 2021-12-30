begin
    struct SkyBox <: SceneObject
        color::Function
    end
    intersection(ray::Ray, skybox::SkyBox) = Intersection(skybox, Inf, ray.direction * Inf)
end

SkyBox() = SkyBox(direction -> RGB( (direction ./ 2maximum(abs.(direction)) .+ 0.5 ) ... ))

function SkyBox(hdr::Symbol)
    file = joinpath(@__DIR__, "..", "hdri", string(hdr) * ".hdr")
    if !isfile(file)
        @error "$file does not exists"
    end
    data = load(file)
    mapping = function (d)
        u = 0.5 + atan(d[1], d[3]) / 2π
        v = 0.5 - atan(d[2]) / π
        data[round.(Int, size(data) .* (1 - v, 1 - u), RoundUp)...]
    end
    SkyBox(mapping)
end

function interact(ray::Ray, hit::Intersection{SkyBox}, n::Int)
    hit.object.color(ray.direction)
end
