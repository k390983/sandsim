function isColliding(a, b)
	if distance(a, b) > (a.r + b.r) ^ 2 then
		return false
	else
		return true
	end

end

function distance(a, b)
	return (a.x - b.x) ^ 2 + (a.y - b.y) ^ 2

end
