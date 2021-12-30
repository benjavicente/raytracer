"Objects that rays can intercept"
abstract type SceneObject end

"A vector of objects makes a scene"
Scene = Vector{SceneObject}



struct Ray
    "Origin"
    origin::Vector{Float64}
    "Direction"
    direction::Vector{Float64}
    "Current index of refraction"
    ior::Float64
end
Ray(origin::Vector{Float64}, direction::Vector{Float64}) = Ray(origin, direction, 1.0)



begin
    "Ray miss"
    struct Miss end

    "Ray intersection with an object"
    struct Intersection{Object<:SceneObject}
        object::Object
        distance::Float64
        point::Vector{Float64}
    end

    Base.isless(a::Miss, b::Miss) = false
    Base.isless(a::Miss, b::Intersection) = false
    Base.isless(a::Intersection, b::Miss) = true
    Base.isless(a::Intersection, b::Intersection) = a.distance < b.distance
end

# TODO
begin
    struct Material
        "Diffuse color (Base color)"
        diffuse_color::RGB

        "Specular color (Shininess color)"
        # For specular highlights
        specular_color::RGB

        "Ambient color"
        # Light that does not come from a light source, geneally equal to diffuse color.
        ambient_color::RGB

        "Reflectivity coeficient"
        reflection::Float64

        "Transparency coeficient"
        transparency::Float64

        "Index of refraction, required with transparency"
        index_of_refeaction::Float64
    end
    function Material(;diffuse_color=RGB(0.9), specular_color=RGB(0.9), ambient_color=RGB(0.1), reflection=0.5, transparency=0.0, index_of_refeaction=1.0)
        Material(diffuse_color, specular_color, ambient_color, reflection, transparency, index_of_refeaction)
    end
end


