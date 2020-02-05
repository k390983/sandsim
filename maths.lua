function isColliding(a, b)
	if getDistance(a, b) < (a.r + b.r) ^ 2 then
		return true
	else
		return false
	end

end

function getDistance(a, b)
	return (a.x - b.x) ^ 2 + (a.y - b.y) ^ 2

end

function getCollisionDirection(a, b)
	

end