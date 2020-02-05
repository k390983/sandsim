function createBall(x, y, vx, vy, r, m, e)
	local ball = {}

	ball.x = x
	ball.y = y
	ball.vx = vx
	ball.vy = vy
	ball.r = r
	ball.m = m
	ball.e = e

	table.insert(world.objects, ball)

end