using CSV, DataFrames, Plots

data = CSV.read("week_1/assets/data/phys_lab_week1.csv", DataFrame)

pendulum_length_arr = data.L .- 10.5 # The minus 10.5 is 10.5cm of the bottle (length of bottle is ~21cm, center of mass is somewhere around the center of the bottle so 10.5cm)
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
flattened_periods_arr = vcat( # the reason i did this is because i wanted to get the maximum value of the periods for the y axis of the graphs. the vcat func flattens the matrix and returns a simple vector on which you can get the max out of
	period_1_arr,
	period_2_arr,
	period_3_arr,
	period_4_arr,
	period_5_arr,
	period_6_arr
)
x_axis = range(20, maximum(pendulum_length_arr))
y_axis = range(20, maximum(flattened_periods_arr))
gravity_log_graph = 2π*sqrt.(x_axis/(9.8 * 100)) # LOGARITHMIC AXIS
dots_log_graph = plot(pendulum_length_arr, periods_arr, seriestype=:"scatter", label="",xscale=:log10, yscale=:log10) # LOGARITHMIC AXIS
plot!(dots_log_graph, x_axis, gravity_log_graph, label="2π√(x/g)", xscale=:log10, yscale=:log10)

gravity_graph = 2π*sqrt.(x_axis/(9.8 * 100)) # REGULAR AXIS
dots_graph = plot(pendulum_length_arr, periods_arr, seriestype=:"scatter", label="") # REGULAR AXIS
plot!(dots_graph, x_axis, gravity_graph, label="2π√(x/g)")

combined_graph = plot(dots_graph, dots_log_graph, layout = (1, 2), size=(900,400), margin=5Plots.mm)

xlabel!("Pendulum length (cm)")
ylabel!("Period times (s)")

savefig(combined_graph, "week_1/results/pendulum_periods.png")
savefig(combined_graph, "week_1/results/pendulum_periods.pdf")