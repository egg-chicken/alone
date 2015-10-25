_ = require('underscore')
Array2D = require('utils/array2d')
Characters = require('./board/characters')
Items = require('./board/items')
Land = require('./board/land')
MaskedBoard = require('./masked_board')

module.exports = class Board
  WIDTH = 80
  HEIGHT = 30
  INITIAL_ENEMY_COUNT = 5
  INITIAL_ITEM_COUNT = 5

  @create: (hero = null)->
    land = Land.createRandom(WIDTH, HEIGHT)
    characters = new Characters()
    characters.createEnemies(land.getFreePositions(), INITIAL_ENEMY_COUNT)
    characters.createHero(land.getFreePositions(), hero)
    items = new Items()
    items.createItems(land.getFreePositions(), INITIAL_ITEM_COUNT)
    new Board(land, characters, items)

  @createHall: (width, height)->
    land = Land.createHall(width, height)
    characters = new Characters()
    items = new Items()
    new Board(land, characters, items)

  constructor: (@land, @characters, @items)->

  getHero:            -> @characters.getHero()
  getEnemies:         -> @characters.getEnemies()
  getCharacters:      -> @characters.getCharacters()
  get: (position)     -> @characters.getByPosition(position)
  getItem: (position) -> @items.getByPosition(position)
  getTile: (position) -> @land.getTile(position)
  isExit: (position)  -> @land.isExit(position)
  isRoom: (position)  -> @land.isRoom(position)
  isWall: (position)  -> @land.isWall(position)

  remove: (obj) ->
    @characters.remove(obj) || @items.remove(obj)

  createOne: (name) ->
    @characters.createOne(@land.getFreePositions(), name)

  put: (position, character) ->
    throw new Error("cannot put on the wall")  if @land.isWall(position)
    throw new Error("character is already exist ") if @get(position)
    character.setPosition(position)

  mask:(character) ->
    new MaskedBoard(@, character)

  to_s: ->
    display_table = new Array2D(WIDTH, HEIGHT)
    for p in display_table.pairs()
      symbol = @characters.getSymbol(p) || @items.getSymbol(p) || @land.getSymbol(p)
      display_table.set(p, symbol)
    display_table.to_s()
