function createBall(x, y, vx, vy, r, m, e)
	local ball = {}

	ball.x = x
	ball.y = y
	ball.vx = vx
	ball.vy = vy
	ball.r = r
	ball.m = m
	ball.e = e

	local pos = #world.objects + 1
	world.objects[pos] = ball

	print("create ball"..pos)

end

function removeBall(a)
	print("remove ball"..a)
	world.objects[a] = nill

end

function reset()
	for nameA, A in pairs(world.objects) do
		removeBall(nameA)

	end

	createBall(100, 100, 0, 0, 40, 200, 1)
	createBall(200, 100, 0, 0, 20, 50, 1)
	createBall(300, 100, 0, 0, 10, 10, 1)
	createBall(400, 100, 0, 0, 20, 50, 1)
	createBall(100, 300, 0, 0, 60, 600, 1)
	createBall(200, 300, 0, 0, 20, 50, 1)

end

function mouseInput()
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
			currentBall.vx = (currentBall.x - x) * pullSpeed
			currentBall.vy = (currentBall.y - y) * pullSpeed
		end

		mouseState = false
		currentBall = nil

	end

end

function keyboardinput()
	if love.keyboard.isDown("r") then
		reset()

	end

end