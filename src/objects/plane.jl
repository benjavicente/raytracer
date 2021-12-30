struct Plane <: SceneObject
    "Normal"
    norm::Vector{Float64}
    "Position"
    p::Vector{Float64}
end

function intersection(ray::Ray, plane::Plane; ϵ=1e-3)
    t = ((plane.p - ray.o) ⋅ plane.norm) / (ray.d ⋅ plane.norm)
    if t > ϵ
        Intersection(plane, t, ray.o + t * ray.d)
    else
        Miss()
    end
end

# TODO
function interact(ray::Ray, hit::Intersection{Plane}, n::Int)
    SplittedRay(
        (RaySource(hit.object.s.c), 0.5),
        (Ray(hit.point, reflect(ray.d, hit.object.norm),hit.object.s.c,ray.ior), 0.5)
    )
end
