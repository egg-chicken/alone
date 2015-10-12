_ = require('underscore')
Array2D = require('utils/array2d')
Characters = require('./board/characters')
Items = require('./board/items')
Land = require('./board/land')

module.exports = class Board
  WIDTH = 80
  HEIGHT = 30
  INITIAL_ENEMY_COUNT = 5

  constructor: ->
    @land = new Land(WIDTH, HEIGHT)
    @characters = new Characters()
    @characters.generateHero(@land.getFreePositions())
    @characters.generateEnemies(@land.getFreePositions(), INITIAL_ENEMY_COUNT)
    @items = new Items()
    @items.generateItems(@land.getFreePositions(), 5)

  getHero:       -> @characters.getHero()
  getEnemies:    -> @characters.getEnemies()
  getCharacters:  -> @characters.getCharacters()
  get: (position) -> @characters.getByPosition(position)
  getItem: (position) -> @items.getByPosition(position)
  getTile: (position) -> @land.getTile(position)
  remove: (obj)-> @characters.remove(obj) || @items.remove(obj)
  put: (position, character) ->
    throw new Error("cannot put on the wall")  if @land.isWall(position)
    throw new Error("character is already exist ") if @get(position)
    character.setPosition(position)

  isExit: (position) -> @land.isExit(position)
  isRoom: (position) -> @land.isRoom(position)

  to_s: ->
    display_table = new Array2D(WIDTH, HEIGHT)
    _.each display_table.pairs(), (p)=>
      symbol = @characters.getSymbol(p) || @items.getSymbol(p) || @land.getSymbol(p)
      display_table.set(p, symbol)
    display_table.to_s()

  @test: ->
    board = new Board()
    console.log(board.to_s())
