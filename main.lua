--============================================================================--
-- SandSim / main.lua
--============================================================================--

--------------------------------------------------------------------------------
-- includes
--------------------------------------------------------------------------------

require "maths"
require "physics"
require "control"

--------------------------------------------------------------------------------
-- love2d functions
--------------------------------------------------------------------------------

function love.load()
	root = {}
		root.world = {}
			root.world.objects = {}
			root.world.x = 680
			root.world.y = 680
			root.world.globalDrag = 0.99
			root.world.gravity = 100
			root.world.updateSpeed = 2
		root.system = {}
			root.system.window = {}
				root.system.window.x = 680
				root.system.window.y = 680
			root.system.startTime = love.timer.getTime()
			root.system.fps = 0
			root.system.input = {}
				root.system.input.mouseState = false
				root.system.input.eTime = love.timer.getTime()
				root.system.input.qTime = love.timer.getTime()
				root.system.input.pullSpeed = 10
				root.system.input.currentBall = nil

	world = root.world
	system = root.system

	love.window.setMode(root.system.window.x, root.system.window.y)

	reset()

end


function love.update(dt)
	system.fps = love.timer.getFPS()

	mouseInput()
	keyboardinput()

	dt = dt * 1 / 2 ^ world.updateSpeed

	update(dt)

	os.execute("clear")
	print("fps:"..system.fps.." update speed: 1/"..2 ^ world.updateSpeed)

end

function love.draw()
	love.graphics.setColor(1, 1, 1)

	for name, object in pairs(world.objects) do
		love.graphics.circle("line", object.x, object.y, object.r)

	end

	love.graphics.setColor(1, 0, 0)
	if system.input.mouseState == true and system.input.currentBall ~= nil then
		love.graphics.line(
			love.mouse.getX(),
			love.mouse.getY(),
			system.input.currentBall.x,
			system.input.currentBall.y
		)

	end

	print("fps: "..love.timer.getFPS())

end
