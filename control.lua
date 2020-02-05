function createBall(x, y, vx, vy, r, m, e)
	local ball = {}

	ball.x = x
	ball.y = y
	ball.vx = vx
	ball.vy = vy
	ball.r = r
	ball.m = m
	ball.e = e

	table.insert(world.objects, ball)

end

function mouseInput(dt)
	if love.mouse.isDown(1) then
		local x = love.mouse.getX()
		local y = love.mouse.getY()

		for nameA, A in pairs(world.objects) do
			if isPointInCircle(x, y, A) then
				A.vx = (x - A.x) / dt
				A.vy = (y - A.y) / dt
				A.x = x
				A.y = y

			else
				if not mouseState then
					createBall(
						x,
						y,
						0,
						0,
						math.random(10, 30),
						math.random(50, 200),
						1
					)
					mouseState = true

				end

			end

		end

	else
		mouseState = false

	end

end