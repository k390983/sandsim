--============================================================================--
-- SandSim / control.lua
--============================================================================--

--------------------------------------------------------------------------------
-- main uptade function
--------------------------------------------------------------------------------

function update(dt)
	updatePositions(dt)
	externalForces(dt)
	updateChunks()
	collisons(dt)

end

--------------------------------------------------------------------------------
-- apply force
--------------------------------------------------------------------------------

function applyForce(target, fx, fy) -- N * s
	local x = fx / target.m
	local y = fy / target.m

	target.vx = target.vx + x
	target.vy = target.vy + y

end

--------------------------------------------------------------------------------
-- external forces (gravity, drag, shake, etc...)
--------------------------------------------------------------------------------

function externalForces(dt)
	for nameA, A in pairs(world.objects) do

		-- global drag --

		A.vx = A.vx * world.globalDrag
		A.vy = A.vy * world.globalDrag

		-- gravity --

		applyForce(A, 0, 10 * A.m)

		-- shake --

		applyForce(
			A,
			world.shake.x * math.random(-1, 1),
			world.shake.y * math.random(-1, 1)
		)

	end

end

--------------------------------------------------------------------------------
-- update ball posiitons
--------------------------------------------------------------------------------

function updatePositions(dt)
	for nameA, A in pairs(world.objects) do
		A.x = A.x + A.vx * dt
		A.y = A.y + A.vy * dt

	end

end

--------------------------------------------------------------------------------
-- ball / wall collisons
--------------------------------------------------------------------------------

function collisons(dt)
	for nameA, A in pairs(world.objects) do
		
		-- other objects --

		for nameB, B in pairs(world.objects) do
			if nameB ~= nameA then
				if isColliding(A, B) then

					-- static --

					local distance = math.sqrt(getDistance2(A, B))

					local overlap = (distance - A.r - B.r) / 2

					A.x = A.x - overlap * 1.1 * (A.x - B.x) / distance
					A.y = A.y - overlap * 1.1 * (A.y - B.y) / distance

					B.x = B.x + overlap * 1.1 * (A.x - B.x) / distance
					B.y = B.y + overlap * 1.1 * (A.y - B.y) / distance

					-- dynamic --

					distance = math.sqrt(getDistance2(A, B))
					local e = math.min(A.e, B.e)

					local nx = (B.x - A.x) / distance;
					local ny = (B.y - A.y) / distance;

					local tx = -ny;
					local ty = nx;

					local dpTan1 = A.vx * tx + A.vy * ty;
					local dpTan2 = B.vx * tx + B.vy * ty;

					local dpNorm1 = A.vx * nx + A.vy * ny;
					local dpNorm2 = B.vx * nx + B.vy * ny;

					local m1 =
						(dpNorm1 * (A.m - B.m) + 2 * B.m * dpNorm2) /
						(A.m + B.m);
					local m2 =
						(dpNorm2 * (B.m - A.m) + 2 * A.m * dpNorm1) /
						(A.m + B.m);

					A.vx = tx * dpTan1 + nx * m1 * e;
					A.vy = ty * dpTan1 + ny * m1 * e;
					B.vx = tx * dpTan2 + nx * m2 * e;
					B.vy = ty * dpTan2 + ny * m2 * e;

				end

			end

		end

		if A.x - A.r < 0 then
			A.x = A.x - (A.x - A.r)
			A.vx = - A.vx
		end
		if A.x + A.r > world.x then
			A.x = A.x + world.x - (A.x + A.r)
			A.vx = - A.vx
		end

		if A.y - A.r < 0 then
			A.y = A.y - (A.y - A.r)
			A.vy = - A.vy
		end
		if A.y + A.r > world.y then
			A.y = A.y + world.y - (A.y + A.r)
			A.vy = - A.vy
		end

	end
	
end