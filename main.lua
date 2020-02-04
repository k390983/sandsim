
-- https://gamedevelopment.tutsplus.com/tutorials/how-to-create-a-custom-2d-physics-engine-the-basics-and-impulse-resolution--gamedev-6331

require "maths"
require "physics"

function love.load()
	world = {}
		world.circle1 = {}
			world.circle1.x = 100
			world.circle1.y = 100
			world.circle1.vx = 0
			world.circle1.vy = 0
			world.circle1.r = 20
			world.circle1.m = 100

		world.circle2 = {}
			world.circle2.x = 200
			world.circle2.y = 200
			world.circle2.vx = 0
			world.circle2.vy = 0
			world.circle2.r = 20
			world.circle2.m = 100


end


function love.update(dt)
	print(isColliding(world.circle1, world.circle2))
	update(world, dt)

end


function love.draw()
	for name, object in pairs(world) do
		love.graphics.circle("line", object.x, object.y, object.r)

	end

end