using CSV, DataFrames, Plots

data = CSV.read("week_5/assets/data/measurements.csv", DataFrame)

h_s = data.h_s
d_r = data.d_r
d_s = data.d_s

error_distance = 0.05 # in cm
error_distance_squared = 2 .* d_r .* error_distance

plot(x -> (1.64*x), 0, h_s[end], label="")
plot!(x -> (1.95*x), 0, h_s[end], label="")
plot!(x -> (1.45*x), 0, h_s[end], label="")

p = plot!(h_s, d_s, seriestype=:scatter, 
	label="", 
	xerror=[0.05,0.05,0.05,0.05,0.05], 
	yerror=error_distance_squared, 
	msw=1.5, 
	ms=4,
	widen=false,
	xlabel = "\$h_s\$ (\$\\mathrm{mm}\$)",
	ylabel = "\$D^2\$ (\$\\mathrm{cm}^2\$)",
	xlims = (0, maximum(h_s) * 1.08),
	ylims = (0, maximum(d_s) * 1.08),
	dpi=1000
)

savefig(p, "week_5/results/graph_build.png")
savefig(p, "week_5/results/graph_build.pdf")