function render(scene::Scene, camera::Camera; max_steps=10)::Array{RGB, 2}
    rays = get_rays(camera)
    # TODO: multi-prosesor/theading
    ray_step.(rays, [scene], [max_steps])
end

function ray_step(ray::Ray, scene::Scene, step::Int)
    closest_intersection =  minimum(intersection.([ray], scene))
    interact(ray, closest_intersection, step)
end
