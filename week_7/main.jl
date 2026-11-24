using CSV, DataFrames, Plots

data = CSV.read("week_7/assets/data/measurements.csv", DataFrame)

h_b = data.h_b
d_r = data.d_r
h_s = 294.5 / 10 # in cm

g = 981 # in cm
M = 16.63/1000 # in kilos

e_k = d_r .^ 2 .* (((M) * g) / (4 * h_s)) # formula for kinetic energy from the tofes
U = h_b .* g * (M)
ratio_k_p = e_k ./ U

error_mass = 0.01 / 1000 # in grams
error_distance_D = 0.05 # in cm
error_distance_h_s = 0.05 # in cm
error_distance_h_b = 0.05 # in cm

error_energy_EK = []
error_energy_U = []
error_percentage_function = []

function calculate_errors()
	for i in 1:length(d_r)
		error_for_EK = sqrt(
			((g / (4 * h_s)) * d_r[i] ^ 2 * error_mass) ^ 2 + 
			(((M * g * d_r[i] ^ 2) / (4)) * (-1 / (h_s^2)) * error_distance_h_s) ^ 2 + 
			((M * g / (4 * h_s)) * 2 * d_r[i] * error_distance_D) ^ 2
		)
		error_for_U = sqrt(
			(g * h_b[i] * error_mass) ^ 2 + 
			(M * g * error_distance_h_b) ^ 2
		)
		push!(error_energy_EK, error_for_EK)
		push!(error_energy_U, error_for_U)	
	end

	for i in 1:length(d_r)
		error_for_percentage = sqrt(((1 / U[i]) * error_energy_EK[i])^2 + (e_k[i] * ((-1) / (U[i] ^ 2)))^2)
		push!(error_percentage_function, error_for_percentage)
	end
end

function make_ek_hb_graph()	
	e_k_graph = plot(h_b, e_k,
		title="\$E_k\$ as a function of \$h_b\$",
		label="",
		xerror=fill(error_distance_h_b, length(d_r)),
		yerror=error_energy_EK,
		msw=1.5,
		msc=:crimson,
		lw=0,
		lc=:transparent,
		widen=false,
		xlabel = "\$h_b (cm)\$",
		ylabel = "\$E_k (J)\$",
		xlims = (0, maximum(h_b) * 1.08),
		ylims = (0, maximum(e_k) * 1.08),
		yticks=([0, 20, 40, 60, 80, 100, 120], string.([0, 20, 40, 60, 80, 100, 120])),
		dpi=1000,
		margin=5Plots.mm
	)
	scatter!( #dots for E_k as function of h_b
			h_b, e_k,
			label="\$E_k\$",
			markersize = 1.5,
			markercolor = :crimson,
			markerstrokewidth = 0,
	)
	savefig(e_k_graph, "week_7/results/e_k_graph.png")
	savefig(e_k_graph, "week_7/results/e_k_graph.pdf")
end

function make_ratio_graph()
	ratio_graph = plot(U, ratio_k_p, 
		title="Ratio between \$E_k\$ and \$U\$",
		label="",
		xerror=error_energy_U,
		yerror=error_percentage_function,
		msw=1.5,
		msc=:crimson,
		lw=0,
		lc=:transparent,
		widen=false,
		xlabel = "\$U (J)\$",
		ylabel = "\$E_k/U (a.u)\$",
		xlims=(0,250),
		ylims = (0, 1),
		xticks=((0:50:300), string.((0:50:300))),
		yticks=((0:0.2:1), string.((0:0.2:1))),
		dpi=1000,
		margin=5Plots.mm
	)
	scatter!( #dots for E_K/U
			U, ratio_k_p,
			label="\$E_k/U\$",
			markersize = 1.5,
			markercolor = :crimson,
			markerstrokewidth = 0,
	)

	savefig(ratio_graph, "week_7/results/ratio_graph.png")
	savefig(ratio_graph, "week_7/results/ratio_graph.pdf")

end

calculate_errors() # MUST INVOKE BEFORE INVOKING MAKE GRAPH FUNCTIONS

make_ek_hb_graph()
make_ratio_graph()