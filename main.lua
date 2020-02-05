
require "maths"
require "physics"
require "control"

function love.load()
	world = {}
	
	world.x = 480
	world.y = 480
	world.drag = 0.99

	love.window.setMode(world.x, world.y)

	world.objects = {}

	createBall(100, 100, 0, 0, 40, 200, 1)
	createBall(200, 100, 0, 0, 20, 50, 1)

	mouseState = false

end


function love.update(dt)
	os.execute("clear")
	print("fps:"..(1 / dt))
	update(dt)

	--[[local mX, mY = love.mouse.getPosition()
	world.objects.circleC.x = mX
	world.objects.circleC.y = mY]]

	mouseInput(dt)

end


function love.draw()
	for name, object in pairs(world.objects) do
		love.graphics.circle("line", object.x, object.y, object.r)

	end

end