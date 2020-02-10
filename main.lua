
require "maths"
require "physics"
require "control"

function love.load()
	root = {}
		root.world = {}
			root.world.objects = {}
			root.world.x = 680
			root.world.y = 680
			root.world.globalDrag = 0.99
			root.world.gravity = 100
			root.world.upateSpeed = 2
		root.system = {}
			root.system.window = {}
				root.system.window.x = 680
				root.system.window.y = 680
			root.system.startTime = love.timer.getTime()
			root.system.fps = 0
			root.system.ups = 0
			root.system.input = {}
				root.system.input.mouseState = false
				root.system.input.eTime = love.timer.getTime()
				root.system.input.qTime = love.timer.getTime()
				root.system.input.pullSpeed = 10
				root.system.input.currentBall = nil

	objects = root.world.objects
	input = root.system.input

	love.window.setMode(root.system.window.x, root.system.window.y)

	reset()

end


function love.update(dt)
	local time0 = love.timer.getTime()

	mouseInput()
	keyboardinput()

	local time1 = love.timer.getTime()

	dt = dt * 1 / 2 ^ world.updateSpeed

	update(dt)

	local time2 = love.timer.getTime()

	os.execute("clear")
	print("ups:"..(1 / dt).." update speed: 1/"..2 ^ world.updateSpeed)

end

function love.draw()
	love.graphics.setColor(1, 1, 1)

	for name, object in pairs(world.objects) do
		love.graphics.circle("line", object.x, object.y, object.r)

	end

	for name, wall in pairs(world.walls) do
		love.graphics.rectangle("fill", wall.x1, wall.y1, wall.x2, wall.y2)

	end

	love.graphics.setColor(1, 0, 0)
	if mouseState == true and currentBall ~= nil then
		love.graphics.line(
			love.mouse.getX(),
			love.mouse.getY(),
			currentBall.x,
			currentBall.y
		)

	end

	print("fps: "..love.timer.getFPS())

end

function sleep(sec)
	socket.sleep(sec)

end
