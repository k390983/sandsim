function update(dt)
	updatePositions(dt)
	--externalForces(dt)
	collisons(dt)

end

function externalForces(dt)
	for nameA, A in pairs(world.objects) do
		A.vx = A.vx * world.drag
		A.vy = A.vy * world.drag

	end

end

function updatePositions(dt)
	for nameA, A in pairs(world.objects) do

		-- screen edges --

		if A.x < 0 then 
			A.x = world.x
		end
		if A.x > world.x then
			A.x = 0
		end
		if A.y < 0 then
			A.y = world.y
		end
		if A.y > world.y then
			A.y = 0
		end

		-- clamp speed --
		
		--if math.abs(A.vx) < world.minSpeed then A.vx = 0 end
		--if math.abs(A.vy) < world.minSpeed then A.vy = 0 end

		if A.vx > 0 then
			if A.vx > world.maxSpeed then A.vx = world.maxSpeed end

		else
			if A.vx < -world.maxSpeed then A.vx = -world.maxSpeed end

		end

		if A.vy > 0 then
			if A.vy > world.maxSpeed then A.vy = world.maxSpeed end

		else
			if A.vy < -world.maxSpeed then A.vy = -world.maxSpeed end

		end

		-- position --

		A.x = A.x + A.vx * dt
		A.y = A.y + A.vy * dt

	end

end

function collisons(dt)
	for nameA, A in pairs(world.objects) do
		
		for nameB, B in pairs(world.objects) do
			if nameB ~= nameA then
				if isColliding(A, B) then

					-- static --

					local distance = math.sqrt(getDistance2(A, B))

					local overlap = (distance - A.r - B.r) / 2

					A.x = A.x - overlap * (A.x - B.x) / distance
					A.y = A.y - overlap * (A.y - B.y) / distance

					B.x = B.x + overlap * (A.x - B.x) / distance
					B.y = B.y + overlap * (A.y - B.y) / distance

					-- dynamic --

					local distance = A.r + B.r

					local nx = (B.x - A.x) / distance
					local ny = (B.y - A.y) / distance

					local kx = A.vx - B.vx
					local ky = A.vy - B.vy
					local p = 2 * (nx * kx + ny * ky) / (A.m + B.m)

					A.vx = A.vx - p * B.m * nx
					A.vy = A.vy - p * B.m * ny

					B.vx = B.vx + p * A.m * nx
					B.vy = B.vy + p * A.m * ny

				end

			end

		end

	end
	
end