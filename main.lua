
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

	--[[for i = 1, world.x / 20 do
		for j = 1, world.y / 20 do
			createBall(
				i * 20,
				j * 20,
				math.random(-30, 30),
				math.random(-30, 30),
				math.random(5, 15),
				100,
				1
			)

		end

	end]]

	--createBall(100, 100, 300, 0, 20, 200, 1)
	--createBall(200, 100, 0, 0, 20, 100, 1)

	-- player --

	--[[world.objects.circleC = {}
	world.objects.circleC.x = 0
	world.objects.circleC.y = 0
	world.objects.circleC.vx = 0
	world.objects.circleC.vy = 0
	world.objects.circleC.m = 100
	world.objects.circleC.r = 80
	world.objects.circleC.e = 1]]

end


function love.update(dt)
	os.execute("clear")
	print("fps:"..(1 / dt))
	update(dt)

	--[[local mX, mY = love.mouse.getPosition()
	world.objects.circleC.x = mX
	world.objects.circleC.y = mY]]

	if love.keyboard.isDown("space") then
		createBall(
			math.random(0, world.x),
			math.random(0, world.y),
			math.random(-70, 70),
			math.random(-70, 70),
			math.random(5, 15),
			math.random(50, 500),
			1
		)

	end

end


function love.draw()
	for name, object in pairs(world.objects) do
		love.graphics.circle("line", object.x, object.y, object.r)

	end

end