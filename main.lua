HELPER = require('helpers')
GRID = require('grid')
GAME = require('game')

function love.load()
  math.randomseed(os.time())

  GRID.initializeGrid()
  GRID.bufferTile()
end

love.graphics.setBackgroundColor(HELPER.hexToRGB('#20202a'))
function love.draw()
  GRID.draw()
end

function love.update(dt)
  GRID.update(dt)
  GAME.update(dt)
end

function love.keypressed(key, scancode, isrepeat)
  print("----------")
  HELPER.printTable(GRID.COLUMNS)
end
