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
	ball.chunk = nil

	local pos = #world.objects + 1
	world.objects[pos] = ball

	print("+ ball"..pos)

end

function newElement(template, x, y, vx, vy)
	local ball = {}

	ball.x = x
	ball.y = y
	ball.vx = 0
	ball.vy = 0
	ball.r = template.r
	ball.m = template.m
	ball.e = template.e
	ball.c = template.c

	local pos = #world.objects + 1
	world.objects[pos] = ball

	print("+ ball"..pos)

end

function removeBall(a)
	print("- ball"..a)
	world.objects[a] = nill

end

--------------------------------------------------------------------------------
-- chunk functions
--------------------------------------------------------------------------------

function generateCunks()
	for i = 0, world.y, 16 do
		for j = 0, world.x, 16 do
			local chunk = {}

			local pos = #world.chunks + 1
			world.chunks[pos] = chunk

			print("+ chunk"..pos)

		end

	end

end

function updateChunks()
	for nameC, C in world.chunks do
		world.chunks[nameC] = nil

	end

	for nameA, A in world.objects do
		local cX = math.floor(A.x / 16)
		local cY = math.floor(A.y / 16)
		local chunk = cY * (world.x / 16) + cX

		local pos = #world.chunks[chunk] + 1
		world.chunks[chunk][pos] = nameA

	end

end

--------------------------------------------------------------------------------
-- reset simulation
--------------------------------------------------------------------------------

function reset()
	for nameA, A in pairs(world.objects) do
		removeBall(nameA)

	end

	generateCunks()

	for n = 0, 1000, 1 do
		newElement(
			water,
			math.random(32, world.x - 32),
			math.random(32, world.y - 32),
			0,
			0
		)

	end

	for n = 0, 250, 1 do
		newElement(
			sand,
			math.random(32, world.x - 32),
			math.random(32, world.y - 32),
			0,
			0
		)

	end

end

--------------------------------------------------------------------------------
-- input
--------------------------------------------------------------------------------

function mouseInput(dt)
	local x = love.mouse.getX()
	local y = love.mouse.getY()

	if love.mouse.isDown(1) then
		if system.input.mode == 1 then

		elseif system.input.mode == 2 then

		elseif system.input.mode == 3 then
			if system.input.currentBall == nil then
				for nameA, A in pairs(world.objects) do
					if isPointInCircle(x, y, A) then
						system.input.currentBall = A

					end
						
				end

			else
				system.input.currentBall.vx = 0
				system.input.currentBall.vy = 0
				system.input.currentBall.x = x
				system.input.currentBall.y = y

			end

		elseif system.input.mode == 4 then
			if system.input.currentBall == nil then
				for nameA, A in pairs(world.objects) do
					if isPointInCircle(x, y, A) then
						system.input.currentBall = A

					end
						
				end

			end

		elseif system.input.mode == 5 then
			system.input.holdTime = system.input.holdTime + dt

		end

	else

		if system.input.mode == 1 then

		elseif system.input.mode == 2 then

		elseif system.input.mode == 3 then
			
		elseif system.input.mode == 4 then
			if system.input.currentBall ~= nil then
				system.input.currentBall.vx =
					(system.input.currentBall.x - x) * system.input.pullSpeed
				system.input.currentBall.vy =
					(system.input.currentBall.y - y) * system.input.pullSpeed
			end
			
		elseif system.input.mode == 5 then
			if system.input.holdTime ~= 0 then
				for nameA, A in pairs(world.objects) do
					if isPointInCircle(
						A.x,
						A.y,
						{x = x, y = y, r = system.input.holdTime * 100}
					) then
						applyForce(
							A,
							system.input.explosionForce * 
							(x - A.x) / (y - A.y),
							system.input.explosionForce * 
							(y - A.y) / (x - A.x)

						)

					end

				end

				system.input.holdTime = 0

			end

		end

		system.input.currentBall = nil

	end

	--[[if love.mouse.isDown(2) then

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

	end]]

end

function keyboardinput()

	-- reset

	if love.keyboard.isDown("r") then
		reset()

	end

	-- numbers

	if love.keyboard.isDown("1") then
		system.input.mode = 1

	elseif love.keyboard.isDown("2") then
		system.input.mode = 2

	elseif love.keyboard.isDown("3") then
		system.input.mode = 3

	elseif love.keyboard.isDown("4") then
		system.input.mode = 4

	elseif love.keyboard.isDown("5") then
		system.input.mode = 5

	end

	-- speed

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