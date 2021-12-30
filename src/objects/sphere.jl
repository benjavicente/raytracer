struct Sphere <: SceneObject
    "Position"
    p::Vector{Float64}
    "Radius"
    r::Float64
    "Material"
    material::Material
end

normal(p::Vector{Float64}, s::Sphere) = normalize(p - s.p)

function intersection(ray::Ray, sphere::Sphere; ϵ=1e-3)::Union{Miss, Intersection}
    a = ray.direction ⋅ ray.direction
    b = 2.0*(ray.direction ⋅ (ray.origin - sphere.p))
    c = (ray.origin - sphere.p) ⋅ (ray.origin - sphere.p) - sphere.r^2
    d = b^2 - 4*a*c
    if d <= 0
        Miss()
    else
        t1 = (-b - √d)/2a
        if t1 > ϵ
            return Intersection(sphere, t1, ray.origin + t1 * ray.direction)
        end
        t2 = (-b + √d)/2a
        if t2 > ϵ
            return Intersection(sphere, t2, ray.origin + t2 * ray.direction)
        end
        Miss()
    end
end

function interact(ray::Ray, hit::Intersection{Sphere}, n::Int)
    hit.object.material.diffuse_color
end
