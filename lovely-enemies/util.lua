Util = {}

-- tobool = { ["true"]=true, ["false"]=false }

function Util.lerp(a, b, k) --smooth transitions
	if a == b then
		return a
	else
		if math.abs(a-b) < 0.005 then return b else return a * (1-k) + b * k end
	end
end

function Util.clamp(val, min, max)
	return math.max(min, math.min(val, max));
end
	
function Util.rotate_point(x, y, angle, offset_x, offset_y) -- offset is added AFTER rotationn
	local x_rot = math.cos(angle) * x - math.sin(angle) * y + (offset_x or 0)
	local y_rot = math.sin(angle) * x + math.cos(angle) * y + (offset_y or 0)
	return x_rot, y_rot
end
