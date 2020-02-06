
require "maths"
require "physics"
require "control"

function love.load()
	world = {}
	
	world.x = 480
	world.y = 480
	world.drag = 0.99
	world.minSpeed = 1
	world.maxSpeed = 1000

	love.window.setMode(world.x, world.y)

	world.objects = {}

	reset()

	mouseState = false
	pullSpeed = 10
	currentBall = nil

end


function love.update(dt)
	os.execute("clear")
	print("fps:"..(1 / dt))
	
	local total = 0

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
			", e: "..
			math.floor(math.sqrt(A.vx ^ 2 + A.vy ^ 2) * A.m)..
			")"
		)

		total = total + math.sqrt(A.vx ^ 2 + A.vy ^ 2) * A.m

	end

	print("total e: "..math.floor(total))

	mouseInput()
	keyboardinput()

	update(dt)

	--[[local mX, mY = love.mouse.getPosition()
	world.objects.circleC.x = mX
	world.objects.circleC.y = mY]]

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