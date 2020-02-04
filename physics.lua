function update(world, dt)
	for name, object in pairs(world) do
		print(name.." x = "..object.x.." y = "..object.y)

		-- position --

		object.x = object.x + object.vx * dt
		object.y = object.y + object.vy * dt

		-- collision --

		for cName, cObject in pairs(world) do
			if isColliding(name, cName) then


			end

		end

	end

end