HELPER = require("helpers")

TILE = { value = 0, isMerging = false }
TILE.__index = TILE

function TILE:new(value, isMerging)
	local o = {
		value = value,
		isMerging = isMerging or false,
		offsetY = 0,
		targetOffsetY = 0,
	}

	setmetatable(o, self)
	return o
end

function TILE:update(dt)
	local speed = 850

	if self.offsetY < self.targetOffsetY then
		self.offsetY = math.min(self.offsetY + speed * dt, self.targetOffsetY)
	elseif self.offsetY > self.targetOffsetY then
		self.offsetY = math.max(self.offsetY - speed * dt, self.targetOffsetY)
	end
end

function TILE:draw(x, y, cellSize)
	y = y + self.offsetY

	love.graphics.setColor(HELPER.hexToRGB("#ffffff"))
	love.graphics.rectangle("fill", x, y, cellSize, cellSize)

	love.graphics.setColor(HELPER.hexToRGB("#20202a"))
	love.graphics.print(tostring(self.value), x, y)
end

return TILE
