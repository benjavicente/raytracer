struct Camera{T}
    # Variable
    "Image position"
    position::Vector{T}
    "Image directrion"
    direction::Vector{T}
    "Distance from the screen"
    focal_length::T
    "Roll (rotation)"
    roll::T
    # Fixed
    "Image size"
    size::Tuple{T,T}
    "Resolution"
    resolution::Tuple{Int,Int}
    "Where down is for the camera"
    down_direction::Vector{T}
end

function get_rays(cam::Camera)::Array{Ray, 2}
    # Pixel size
    pw, ph = cam.size ./ cam.resolution

    # Pixels center
    col_c, row_c = (cam.resolution .+ 1) ./ 2

    # Image coordinate sistem
    u = normalize(cam.direction × cam.down_direction)
    v = normalize(cam.direction × u)

    # Roll
    println(u, v)
    u, v = normalize(u * cos(cam.roll) - v * sin(cam.roll)), normalize(u * sin(cam.roll) +  v * cos(cam.roll))
    println(u, v)

    # Rays
    rays = Array{Ray}(undef, cam.resolution[2], cam.resolution[1])

    for row ∈ 1:cam.resolution[2], col ∈ 1:cam.resolution[1]
        # Pixel position relative to image position
        pixel_position = u * pw * (col - col_c) + v * ph * (row_c - row)

        # Ray direction
        ray_direction = normalize(pixel_position + (cam.focal_length * cam.direction))

        # Create the ray
        rays[row, col] = Ray(pixel_position + cam.position, ray_direction)
    end

    return rays
end
