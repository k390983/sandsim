--============================================================================--
-- SandSim / maths.lua
--============================================================================--

--------------------------------------------------------------------------------
-- basic calculation functions
--------------------------------------------------------------------------------

function isColliding(a, b)
	if getDistance2(a, b) <= (a.r + b.r) ^ 2 then
		return true
	else
		return false
	end

end

function isWallColliding(b, w)
	local nx = math.max(w.x1, math.min(b.x, w.x2))
	local ny = math.max(w.y1, math.min(b.y, w.y2))

	local dx = b.x - nx
	local dy = b.y - ny

	if (dx ^ 2 + dy ^ 2) < (b.r ^ 2) then
		return nx, ny

	else
		return nil

	end	

end

function isPointInCircle(x, y, a)
	local d2 = (a.x - x) ^ 2 + (a.y - y) ^ 2
	
	if d2 < a.r ^ 2  then
		return true	
	else
		return false
	end

end

function getDistance2(a, b) return (a.x - b.x) ^ 2 + (a.y - b.y) ^ 2 end
