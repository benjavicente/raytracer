# Julia Ray-Tracer

A simple ray tracer implemented in Julia.

## Ray-Tracer "Framework"

### Scene objects

Scene objects are structs that subtypes from `SceneObject`.
Scene objects (`Object`) must have the following functions:

```julia
"Intersection with the object's surface"
function intersection(ray::Ray, object::Object)::Union{Miss, Intersection}
    ...
end
```

```julia
"Interaction of the ray to the surface"
function interact(ray::Ray, hit::Intersection{Object}, scene::Scene)::RGB
    ...
end
```

Interactions with the rest of the scene are handled **in `interact`**.
Some interactions that the object could have are:

- Refraction
- Reflection
- Ray teleportation
- Specular highlights

Some interactions may require another another ray trace.
So the function `ray_trace` is available to simulate another ray.

### Base objects

TODO

### Important types

#### Ray

A ray has an `origin` and a `direction`. This values are used to
calculate the intersection with objects. The directions also might be
used to calculate special properties with the materials of the
intercepted objects.

#### Miss and Intersection

Miss and intersections are the result of the `intersection` function.

A `Miss` is a singleton, a struct without attributes.

An `Intersection` contains the information of a intersection: the intercepted object, the distance, and the intercepted point.

#### Camera

The camera that will render the scene. The current attributes are:

- Position: A point where the image will start
- Direction: Where the camera is looking, relative to it's position
- Focal length: Distance from the screen to the "eye"
- Roll: Rotation in the direction axis
- Size: Image size in the scene
- Resolution: Image output size
- Down direction: Where down is for the camera (usually [0, 1, 0])

#### Scene

TODO

### Important functions

#### Render

```julia
render(scene::Scene, camera::Camera; max_steps=10)::Array{RGB, 2}
```

Renders the scene with the camera.


#### Ray step

```julia
ray_trace(ray::Ray, scene::Scene, step::Int)::RGB
```

Calculates the intersection with the closes object and calls
interact with the intercepted object.



---

## Special Thanks

This code is posible thanks to:

- http://math.hws.edu/graphicsbook/c4/s1.html
- https://github.com/avik-pal/RayTracer.jl

