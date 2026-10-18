println("Launch speed (m/s): ")
speed_m_s = parse(Float64, readline())
println("Launch angle (deg): ")
angle_deg = parse(Float64, readline())
println("Wall distance (m): ")
wall_x_m = parse(Float64, readline())
println("Wall height (m): ")
wall_height_m = parse(Float64, readline())
println("Gravity (m/s^2): ")
gravity_m_s2 = parse(Float64, readline())


vx = speed_m_s * cosd(angle_deg)

if (!(speed_m_s > 0) || !isfinite(speed_m_s) || !(speed_m_s isa Real) || (speed_m_s isa Bool))
	throw(ArgumentError("Launch speed is negative"))
elseif (!(0 <= angle_deg < 90) || !isfinite(angle_deg) || !(angle_deg isa Real) || (angle_deg isa Bool))
	throw(ArgumentError("Angle is not between 0 and 90 degrees"))
elseif (!(vx > 0)  || !isfinite(vx) || !(vx isa Real) || (vx isa Bool))
	throw(ArgumentError("Horizontal speed is not good"))
elseif (!(wall_x_m >= 0) || !isfinite(wall_x_m) || !(wall_x_m isa Real) || (wall_x_m isa Bool))
	throw(ArgumentError("The distance to the wall is negative"))
elseif (!(wall_height_m >= 0) || !isfinite(wall_height_m) || !(wall_height_m isa Real) || (wall_height_m isa Bool))
	throw(ArgumentError("The wall height is negative"))
elseif (!(gravity_m_s2 > 0) || !isfinite(gravity_m_s2) || !(gravity_m_s2 isa Real) || (gravity_m_s2 isa Bool))
	throw(ArgumentError("Gravity is negative"))
end

time = wall_x_m / vx
height_at_wall = speed_m_s * sind(angle_deg) * time - 0.5 * gravity_m_s2 * time^2
vy = speed_m_s * sind(angle_deg) - gravity_m_s2 * time
vertical_state = ""
if (vy > 0)
	vertical_state = "rising"
else vertical_state = "falling"
end

clears = height_at_wall >= wall_height_m
if (height_at_wall < 0)
	println("Result: The projectile lands before the wall.")
elseif (clears)
	println("Height at wall: $(height_at_wall) m")
	println("Vertical motion: $(vertical_state)")
	println("Result: The projectile clears the wall.")
else 	
	println("Height at wall: $(height_at_wall) m")
	println("Vertical motion: $(vertical_state)")
	println("Result: The projectile hits the wall.")
end