using CSV, DataFrames, Plots

data = CSV.read("assets/data/phys_lab_week1.csv", DataFrame)

pendulum_length_arr = data.L .- 10.5
period_1_arr = data.t1
period_2_arr = data.t2
period_3_arr = data.t3
period_4_arr = data.t4
period_5_arr = data.t5
period_6_arr = data.t6

periods_arr = [
	period_1_arr,
	period_2_arr,
	period_3_arr,
	period_4_arr,
	period_5_arr,
	period_6_arr
]
flattened_periods_arr = vcat(
	period_1_arr,
	period_2_arr,
	period_3_arr,
	period_4_arr,
	period_5_arr,
	period_6_arr,
)
x_axis = range(20, maximum(pendulum_length_arr))
y_axis = range(20, maximum(flattened_periods_arr))
graph = plot(x_axis, 2π*sqrt.(x_axis/(9.8 * 100)), label="",xscale=:log10, yscale=:log10) # LOGARITHMIC AXIS
plot!(pendulum_length_arr, periods_arr, seriestype=:"scatter", label="",xscale=:log10, yscale=:log10) # LOGARITHMIC AXIS

# graph = plot(x_axis, 2π*sqrt.(x_axis/(9.8 * 100)), label="") # REGULAR AXIS
# plot!(pendulum_length_arr, periods_arr, seriestype=:"scatter", label="") # REGULAR AXIS

xlabel!("Pendulum length (in centimeters)")
ylabel!("Period times (in seconds)")

# savefig(graph, "pendulum_periods.png")
# savefig(graph, "pendulum_periods.pdf")

savefig(graph, "pendulum_periods_logarithmic.png")
savefig(graph, "pendulum_periods_logarithmic.pdf")