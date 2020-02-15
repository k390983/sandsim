--============================================================================--
-- SandSim / draw.lua
--============================================================================--

--------------------------------------------------------------------------------
-- draw balls, walls, etc...
--------------------------------------------------------------------------------

function drawWorld()
	for name, object in pairs(world.objects) do
		if object == system.input.currentBall then
			love.graphics.setColor(1, 0, 0)
			love.graphics.circle("line", object.x, object.y, object.r)

		else
			love.graphics.setColor(object.c)
			love.graphics.circle("fill", object.x, object.y, object.r)

		end

	end

end

--------------------------------------------------------------------------------
-- draw ui
--------------------------------------------------------------------------------

function drawUI()
	-- fps

	love.graphics.setColor(0, 1, 0)
	love.graphics.print(system.fps, system.window.x - 30, 10)

	-- other

	if system.input.mode == 4 and system.input.currentBall ~= nil then
		love.graphics.setColor(1, 0, 0)

		love.graphics.line(
			love.mouse.getX(),
			love.mouse.getY(),
			system.input.currentBall.x,
			system.input.currentBall.y
		)

	end

	if system.input.mode == 5 and system.input.holdTime ~= nil then
		love.graphics.setColor(1, 0, 0, 0.3)

		love.graphics.circle(
			"fill",
			love.mouse.getX(),
			love.mouse.getY(),
			system.input.holdTime * 100
		)

	end

	-- bottom UI

	love.graphics.setColor(0.3, 0.3, 0.3)
	love.graphics.rectangle(
		"fill",
		0,
		system.window.y - 64,
		system.window.x,
		64
	)

	love.graphics.setColor(0.05, 0.05, 0.05)
	love.graphics.print(
		"[1]: create, [2]: destroy, [3]: move, "..
		"[4]: apply force (single), [5]: apply force (area)",
		0 + 4,
		system.window.y - 64 + 4
	)

	if system.input.mode == 1 then
		love.graphics.print("CREATE", 0 + 4, system.window.y - 64 + 16 + 4)

	elseif system.input.mode == 2 then
		love.graphics.print("DESTROY", 0 + 4, system.window.y - 64 + 16 + 4)

	elseif system.input.mode == 3 then
		love.graphics.print("MOVE", 0 + 4, system.window.y - 64 + 16 + 4)

	elseif system.input.mode == 4 then
		love.graphics.print("FORCE: SINGLE", 0 + 4, system.window.y - 64 + 16 + 4)

	elseif system.input.mode == 5 then
		love.graphics.print("FORCE: AREA", 0 + 4, system.window.y - 64 + 16 + 4)

	end

end

--------------------------------------------------------------------------------
-- print debug to console
--------------------------------------------------------------------------------

function printDebug()
	print("fps:"..system.fps.." update speed: 1/"..2 ^ world.updateSpeed)

end