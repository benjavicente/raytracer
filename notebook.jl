### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ 14725ad2-77b8-11eb-07d4-9b0c5b7aa5b0
begin
	using PlutoUI
	using LinearAlgebra
end

# ╔═╡ bd34abbe-77b4-11eb-374b-b56368c87c0a
md"# Ray Tracer"

# ╔═╡ 2b72ce6e-77b9-11eb-28f2-1ff21faccd28
html"""
<style>
pluto-output.rich_output[mime*="image"] div {
	display: flex;
	justify-content: center;
}
pluto-output.rich_output[mime*="image"] img {
	width: 480px;
}
</style>
<i>Style<i>
"""

# ╔═╡ e9444d24-77b0-11eb-0f41-e31de72fc03a
function ingredients(path::String)
	# this is from the Julia source code (evalfile in base/loading.jl)
	# but with the modification that it returns the module instead of the last object
	name = Symbol(basename(path))
	m = Module(name)
	Core.eval(m,
        Expr(:toplevel,
             :(eval(x) = $(Expr(:core, :eval))($name, x)),
             :(include(x) = $(Expr(:top, :include))($name, x)),
             :(include(mapexpr::Function, x) = $(Expr(:top, :include))(mapexpr, $name, x)),
             :(include($path))))
	m
end

# ╔═╡ c7da7bbe-77b4-11eb-0898-41ba0b139179
md"## SetUp"

# ╔═╡ cdf8a610-77b4-11eb-24ed-7f20fc02eee8
md"""
This noyebookd uses the module RayTraccer under `src/raytracer.jl`.

To reload the module, re-run the cell bellow.
"""

# ╔═╡ 19c4ee00-77b5-11eb-3ae1-cda412de9bd4
RayTracer = ingredients("src/raytracer.jl").RayTracer

# ╔═╡ 09344248-77b5-11eb-0f14-cf03fe1e8570
md"## Example"

# ╔═╡ 8f9429de-77b0-11eb-16d5-5536d0e75ac6
scene = RayTracer.Scene([
    RayTracer.SkyBox(:flower_road_1k),
    RayTracer.Sphere([5.0, 0, 0], 10, RayTracer.Material())
])

# ╔═╡ 1016b2a0-77b8-11eb-2d5b-51d2732bfd65
md"""
|  x  |  `---------------------------------------------------------------`  |
| --: | :-- |
| focal_lenght | $(@bind focal_lenght Slider(1:0.1:50, show_value=true, default=10))
| position | $(@bind px Slider(1:0.1:50)) $(@bind py Slider(1:0.1:50)) $(@bind pz Slider(1:0.1:50))
| direction | $(@bind dx Slider(-1:0.1:1, default=1)) $(@bind dy Slider(-1:0.1:1,default=0)) $(@bind dz Slider(-1:0.1:1,default=0))
| roll | $(@bind roll Slider(-2π:π/8:2π, default=0))
"""

# ╔═╡ 51a9af4a-77b0-11eb-10d3-0be25020d46d
camera = RayTracer.Camera(
    [px, py , pz], # position
    normalize([dx, dy, dz]), # direction
    float(focal_lenght),
    roll,             # roll
    (50.0, 50.0),     # size
    (300, 300),       # resolution
    [0.0 , 1.0, 0.0]  # down_direction
)

# ╔═╡ 8f94f000-77b0-11eb-0786-ed907956384e
image = RayTracer.render(scene, camera)

# ╔═╡ Cell order:
# ╟─bd34abbe-77b4-11eb-374b-b56368c87c0a
# ╠═14725ad2-77b8-11eb-07d4-9b0c5b7aa5b0
# ╟─2b72ce6e-77b9-11eb-28f2-1ff21faccd28
# ╟─e9444d24-77b0-11eb-0f41-e31de72fc03a
# ╟─c7da7bbe-77b4-11eb-0898-41ba0b139179
# ╟─cdf8a610-77b4-11eb-24ed-7f20fc02eee8
# ╠═19c4ee00-77b5-11eb-3ae1-cda412de9bd4
# ╟─09344248-77b5-11eb-0f14-cf03fe1e8570
# ╟─51a9af4a-77b0-11eb-10d3-0be25020d46d
# ╠═8f9429de-77b0-11eb-16d5-5536d0e75ac6
# ╠═1016b2a0-77b8-11eb-2d5b-51d2732bfd65
# ╠═8f94f000-77b0-11eb-0786-ed907956384e
