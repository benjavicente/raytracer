"Reflect a ay with a surface normal"
reflect(ℓ₁::Vector, n̂::Vector) = normalize(ℓ₁ - 2 * dot(ℓ₁, n̂) * n̂)

"Refract a ray in an object"
function refract(ℓ₁::Vector, n̂::Vector, old_ior, new_ior)::Vector
    r = old_ior / new_ior
    n̂_oriented = dot(ℓ₁, n̂) > 0 ? -n̂ : n̂
    c = - dot(ℓ₁, n̂_oriented)
    if abs(c) > 0.999
        ℓ₁
    else
        f = 1 - r^2 * (1 - c^2)
        if f < 0
            ℓ₁
        else
            normalize(r * ℓ₁ + (r*c - √f) * n̂_oriented)
        end
    end
end

