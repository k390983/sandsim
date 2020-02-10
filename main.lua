
require "maths"
require "physics"
require "control"
local socket = require "socket"

function love.load()
	world = {}

	world.x = 680
	world.y = 680

	world.drag = 0.99
	world.gravity = 100
	world.minSpeed = 1
	world.maxSpeed = 5000
	world.updateSpeed = 2

	love.window.setMode(world.x, world.y)

	world.objects = {}
	world.walls = {}

	reset()

	mouseState = false
	qTime = love.timer.getTime()
	eTime = love.timer.getTime()

	pullSpeed = 10
	currentBall = nil

end


function love.update(dt)
	os.execute("clear")
	print("ups:"..(1 / dt).." update speed: 1/"..2 ^ world.updateSpeed)

	mouseInput()
	keyboardinput()

	dt = dt * 1 / 2 ^ world.updateSpeed

	update(dt)

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


end

function sleep(sec)
	socket.sleep(sec)

end
