--============================================================================--
-- SandSim / main.lua
--============================================================================--

--------------------------------------------------------------------------------
-- includes
--------------------------------------------------------------------------------

require "maths"
require "physics"
require "control"
require "draw"
require "elements"

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
			root.world.shake = 1000
		root.system = {}
			root.system.window = {}
				root.system.window.x = root.world.x
				root.system.window.y = root.world.y + 64
			root.system.startTime = love.timer.getTime()
			root.system.fps = 0
			root.system.input = {}
				root.system.input.mode = 1
				root.system.input.eTime = love.timer.getTime()
				root.system.input.qTime = love.timer.getTime()
				root.system.input.pullSpeed = 10
				root.system.input.explosionForce = 10000
				root.system.input.holdTime = 0
				root.system.input.currentBall = nil

	world = root.world
	system = root.system

	love.window.setMode(root.system.window.x, root.system.window.y)

	reset()

end


function love.update(dt)
	system.fps = love.timer.getFPS()

	mouseInput(dt)
	keyboardinput()

	dt = dt * 1 / 2 ^ world.updateSpeed

	update(dt)

	os.execute("clear")

end

function love.draw()
	drawWorld()
	drawUI()
	printDebug()

end
