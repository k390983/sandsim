function update(dt)
	for nameA, A in pairs(world.objects) do
		-- clamp speed --
		if math.abs(A.vx) < world.minSpeed then A.vx = 0 end
		if math.abs(A.vy) < world.minSpeed then A.vy = 0 end

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

		-- external forces --

		A.vx = A.vx * world.drag
		A.vy = A.vy * world.drag

		-- position --

		A.x = A.x + A.vx * dt
		A.y = A.y + A.vy * dt

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

		-- collision --

		for nameB, B in pairs(world.objects) do
			if nameB ~= nameA then
				if isColliding(A, B) then
					--print(nameA.." collided with "..nameB)

					local distance = math.sqrt(getDistance(A, B))

					-- static --

					local overlap = distance - A.r - B.r

					A.x = A.x - overlap / 2 * (A.x - B.x) / distance
					A.y = A.y - overlap / 2 * (A.y - B.y) / distance
					B.x = B.x - overlap / 2 * (B.x - A.x) / distance
					B.y = B.y - overlap / 2 * (B.y - A.y) / distance

					-- dynamic --

					local n = {}
					n.x = (B.x - A.x) / distance
					n.y = (B.y - A.y) / distance

					local t = {}
					t.x = -n.y
					t.y = n.x

					local dp = {}
					dp.tanA = A.vx * t.x + A.vy * t.y
					dp.tanB = B.vx * t.x + B.vy * t.y
					dp.normA = A.vx * n.x + A.vy * n.y
					dp.normB = B.vx * n.x + B.vy * n.y

					local m = {}
					m.A = (dp.normA * (A.m - B.m) + 2 * B.m * dp.normB) / (A.m + B.m)
					m.B = (dp.normB * (B.m - A.m) + 2 * A.m * dp.normA) / (B.m + A.m)

					A.vx = t.x * dp.tanA + n.x * m.A
					A.vy = t.y * dp.tanA + n.y * m.A
					B.vx = t.x * dp.tanB + n.x * m.B
					B.vy = t.y * dp.tanB + n.y * m.B

				end

			end

		end

	end

end