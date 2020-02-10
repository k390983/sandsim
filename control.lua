function createBall(x, y, r, m, e)
	local ball = {}

	ball.x = x
	ball.y = y
	ball.vx = 0
	ball.vy = 0
	ball.ax = 0
	ball.ay = 0
	ball.r = r
	ball.m = m
	ball.e = e

	local pos = #world.objects + 1
	world.objects[pos] = ball

	print("+ ball"..pos)

end

function createWall(x1, x2, y1, y2)
	local wall = {}

	wall.x1 = x1
	wall.x2 = x2
	wall.y1 = y1
	wall.y2 = y2

	local pos = #world.walls + 1
	world.walls[pos] = wall

	print("+ wall"..pos)

end

function removeBall(a)
	print("- ball"..a)
	world.objects[a] = nill

end

function removeWall(a)
	print("- wall"..a)
	world.walls[a] = nill

end

function reset()
	for nameA, A in pairs(world.objects) do
		removeBall(nameA)

	end
 

	for nameA, A in pairs(world.walls) do
		removeWall(nameA)

	end

	--[[wallWidth = 10

	createWall(0, wallWidth, 0, world.y)
	createWall(0, world.x, 0, wallWidth)
	createWall(world.x - wallWidth, world.x, 0, world.y)
	createWall(0, world.x, world.y - wallWidth, world.y)[[]]

	--[[createBall(100, 100, 40, 200)
	createBall(200, 100, 20, 50)
	createBall(300, 100, 10, 10)
	createBall(400, 100, 20, 50)
	createBall(100, 300, 60, 600)
	createBall(200, 300, 20, 50)]]

	for n = 0, 1000, 1 do
		local size = math.random(1, 10)
		createBall(math.random(0, world.x), math.random(0, world.y), size, size ^ 2, 0.9)

	end

end

function mouseInput()
	local x = love.mouse.getX()
	local y = love.mouse.getY()

	if love.mouse.isDown(1) then
		for nameA, A in pairs(world.objects) do
			if isPointInCircle(x, y, A) then
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

	if love.keyboard.isDown("q") and love.timer.getTime() - qTime > 0.2 and world.updateSpeed > -4 then
		world.updateSpeed = world.updateSpeed - 1
		qTime = love.timer.getTime()

	end

	if love.keyboard.isDown("e") and love.timer.getTime() - eTime > 0.2 and world.updateSpeed < 4 then
		world.updateSpeed = world.updateSpeed + 1
		eTime = love.timer.getTime()

	end

end