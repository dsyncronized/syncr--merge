HELPER = require("helpers")
TILE = require("tile")

GRID = {
	COLUMNS = {},
	BUFFERED_TILE = nil,
}

function GRID.initializeGrid()
	for i = 1, 5 do
		GRID.COLUMNS[i] = {}
		GRID.spawnTile(i, math.random(1, 2))
		GRID.spawnTile(i, math.random(1, 2))
	end
end

function GRID.draw()
	local width, height = HELPER.getWindowDimensions()

	local cellSize = math.min(width, height) / 8
	local gridSize = cellSize * 5

	local x = (width - gridSize) / 2
	local y = (height - gridSize) / 2 + cellSize * 0.5

	GRID.gridDraw(x, y, cellSize)
	GRID.tilesDraw(x, y, cellSize)
	GRID.bufferDraw(x, y, cellSize)
end

function GRID.gridDraw(x, y, cellSize)
	for row = 1, 5 do
		for col = 1, 5 do
			if (row + col) % 2 == 0 then
				love.graphics.setColor(HELPER.hexToRGB("#273644"))
			else
				love.graphics.setColor(HELPER.hexToRGB("#46b3a2"))
			end

			love.graphics.rectangle("fill", x + cellSize * (row - 1), y + cellSize * (col - 1), cellSize, cellSize)
		end
	end
end

function GRID.tilesDraw(x, y, cellSize)
	for col = 1, 5 do
		local column = GRID.COLUMNS[col]

		for row, tile in ipairs(GRID.COLUMNS[col]) do
			local reversedRow = #column - row + 1

			tile:draw(x + cellSize * (col - 1), y + cellSize * (reversedRow - 1), cellSize)
		end
	end
end

function GRID.bufferDraw(x, y, cellSize)
	if not GRID.BUFFERED_TILE then
		return
	end
	local buffered = GRID.BUFFERED_TILE

	local previewSize = cellSize * 0.6
	local previewX = x + cellSize * (buffered.column - 1) + (cellSize - previewSize) / 2
	local previewY = y - cellSize * 1.2

	buffered.tile:draw(previewX, previewY, previewSize)
end

function GRID.spawnTile(column, value)
	local width, height = HELPER.getWindowDimensions()
	local cellSize = math.min(width, height) / 8

	local tiles = GRID.COLUMNS[column]

	for _, tile in ipairs(tiles) do
		tile.offsetY = tile.offsetY - cellSize
		tile.targetOffsetY = 0
	end

	local newTile = TILE:new(value)
	newTile.offsetY = -cellSize
	newTile.targetOffsetY = 0

	table.insert(tiles, newTile)
end

function GRID.getMaxTileValue()
	local maxValue = 0

	for col = 1, 5 do
		for _, tile in ipairs(GRID.COLUMNS[col]) do
			if tile.value > maxValue then
				maxValue = tile.value
			end
		end
	end

	return maxValue
end

function GRID.bufferTile()
	local availableColumns = {}

	for i = 1, 5 do
		if #GRID.COLUMNS[i] < 5 then
			table.insert(availableColumns, i)
		end
	end

	if #availableColumns > 0 then
		local column = availableColumns[math.random(#availableColumns)]
		local value = math.random(GRID.getMaxTileValue())

		GRID.BUFFERED_TILE = {
			column = column,
			tile = TILE:new(value),
		}
	else
		local column = math.random(5)
		local value = math.random(GRID.getMaxTileValue())

		GRID.BUFFERED_TILE = {
			column = column,
			tile = TILE:new(value),
		}
	end
end

function GRID.spawnBufferedTile()
	if not GRID.BUFFERED_TILE then
		return
	end

	local buffered = GRID.BUFFERED_TILE

	GRID.spawnTile(buffered.column, buffered.tile.value)

	GRID.BUFFERED_TILE = nil
	GRID.bufferTile()
end

function GRID.update(dt)
	for col = 1, 5 do
		for _, tile in ipairs(GRID.COLUMNS[col]) do
			tile:update(dt)
		end
	end
end

return GRID
