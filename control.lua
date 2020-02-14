--============================================================================--
-- SandSim / control.lua
--============================================================================--

--------------------------------------------------------------------------------
-- ball functions
--------------------------------------------------------------------------------

function createBall(x, y, r, m, e)
	local ball = {}

	ball.x = x
	ball.y = y
	ball.vx = 0
	ball.vy = 0
	ball.r = r
	ball.m = m
	ball.e = e

	local pos = #world.objects + 1
	world.objects[pos] = ball

	print("+ ball"..pos)

end

function removeBall(a)
	print("- ball"..a)
	world.objects[a] = nill

end

--------------------------------------------------------------------------------
-- reset simulation
--------------------------------------------------------------------------------

function reset()
	for nameA, A in pairs(world.objects) do
		removeBall(nameA)

	end

	for n = 0, 500, 1 do
		local size = math.random(1, 10)
		createBall(
			math.random(20, world.x - 20),
			math.random(20, world.y - 20),
			size,size ^ 2,
			0.9
		)

	end

end

--------------------------------------------------------------------------------
-- input
--------------------------------------------------------------------------------

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

		if system.input.mouseState == true then


		else
			for nameA, A in pairs(world.objects) do
				if isPointInCircle(x, y, A) then
					system.input.currentBall = A
					system.input.mouseState = true

				end

			end

		end

	else
		if system.input.currentBall ~= nil then
			system.input.currentBall.vx =
				(system.input.currentBall.x - x) * system.input.pullSpeed
			system.input.currentBall.vy =
				(system.input.currentBall.y - y) * system.input.pullSpeed
		end

		system.input.mouseState = false
		system.input.currentBall = nil

	end

end

function keyboardinput()
	if love.keyboard.isDown("r") then
		reset()

	end

	if
		love.keyboard.isDown("q") and
		love.timer.getTime() - system.input.qTime > 0.2 and
		world.updateSpeed > -4
	then
		world.updateSpeed = world.updateSpeed - 1
		system.input.qTime = love.timer.getTime()

	end

	if
		love.keyboard.isDown("e") and
		love.timer.getTime() - system.input.eTime > 0.2 and
		world.updateSpeed < 4
	then
		world.updateSpeed = world.updateSpeed + 1
		system.input.eTime = love.timer.getTime()

	end

end