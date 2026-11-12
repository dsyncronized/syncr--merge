`GRID.COLUMNS[1] = {
    {value = 2, isMerging = false},
    {value = 3, isMerging = false},
    {value = 4, isMerging = false}
}`

    GRID.COLUMNS[1][1] is the bottommost tile.
    GRID.COLUMNS[1][2] is the tile above it.
    GRID.COLUMNS[1][3] is the topmost tile.

    table.insert() adds a tile to the top.
    table.remove(column, 1) removes the bottommost tile.
    #column gives you the number of tiles.
    #column >= 5 means the column is full (assuming five is the capacity).

TILE
 └── create(value)

GRID
 ├── initializeGrid()
 ├── spawnTile(column, value)
 ├── removeTile(column, index)
 └── checkMerges(column)

PLAYER
 ├── pickupTile(column)
 └── dropTile(column)

GAME
 ├── update()
 └── spawnTimer
