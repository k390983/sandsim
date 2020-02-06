
require "maths"
require "physics"
require "control"

function love.load()
	world = {}
	
	world.x = 480
	world.y = 480
	world.drag = 0.99
	world.minSpeed = 0.1
	world.maxSpeed = 5000

	love.window.setMode(world.x, world.y)

	world.objects = {}

	createBall(100, 100, 0, 0, 40, 200, 1)
	createBall(200, 100, 0, 0, 20, 50, 1)
	createBall(300, 100, 0, 0, 10, 10, 1)
	createBall(400, 100, 0, 0, 20, 50, 1)
	createBall(100, 200, 0, 0, 60, 600, 1)
	createBall(200, 300, 0, 0, 20, 50, 1)

	mouseState = false
	pullSpeed = 10
	currentBall = nil

end


function love.update(dt)
	os.execute("clear")
	print("fps:"..(1 / dt))
	-- ball1: pos(x, y) vel(vx, vy)
	for nameA, A in pairs(world.objects) do
		print("ball"..
			nameA..
			": pos("..
			math.floor(A.x)..
			", "..
			math.floor(A.y)..
			") vel("..
			math.floor(A.vx)..
			", "..
			math.floor(A.vy)..
			")")

	end
	update(dt)

	--[[local mX, mY = love.mouse.getPosition()
	world.objects.circleC.x = mX
	world.objects.circleC.y = mY]]

	mouseInput(dt)

end


function love.draw()
	love.graphics.setColor(1, 1, 1)

	for name, object in pairs(world.objects) do
		love.graphics.circle("line", object.x, object.y, object.r)

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