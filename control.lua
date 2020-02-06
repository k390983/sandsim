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
	local x = love.mouse.getX()
	local y = love.mouse.getY()

	if love.mouse.isDown(1) then
		for nameA, A in pairs(world.objects) do
			if isPointInCircle(x, y, A) then
				--A.vx = (x - A.x) / dt
				--A.vy = (y - A.y) / dt
				A.vx = 0
				A.vy = 0
				A.x = x
				A.y = y

			end

		end

	end

	if love.mouse.isDown(2) then

		if mouseState == true then


		else
			for nameA, A in pairs(world.objects) do
				if isPointInCircle(x, y, A) then
					currentBall = A
					mouseState = true

				end

			end

		end

	else
		if currentBall ~= nil then
			currentBall.vx = (currentBall.x - x) * pullSpeed --* (-1)
			currentBall.vy = (currentBall.y - y) * pullSpeed --* (-1)
		end

		mouseState = false
		currentBall = nil

	end

end