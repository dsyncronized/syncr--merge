GAME = {
  tickRate = .5,
}

function GAME.update(dt)
  GAME.tick(dt)
  GAME.checkLossState()
end


local tickTime = 0
function GAME.tick(dt)
  tickTime = tickTime + dt

  if tickTime >= GAME.tickRate then
    GRID.spawnBufferedTile()
    tickTime = 0
  end
end

function GAME.checkLossState()
  for i = 1, 5 do
    if #GRID.COLUMNS[i] >= 6 then
      if GRID.COLUMNS[i][#GRID.COLUMNS[i]].isMerging == false then
        print('death')
        love.event.quit('you died lmao')
      end
    end
  end
end

return GAME
