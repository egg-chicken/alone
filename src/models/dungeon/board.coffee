_ = require('underscore')
Array2D = require('utils/array2d')
Inspector = require('./board/inspector')
CharacterFactory = require('./board/character_factory')

module.exports = class Board
  constructor: (@land, @characters, @items, @level)->

  getLevel:           -> @level
  getHero:            -> @characters.getHero()
  getEnemies:         -> @characters.getEnemies()
  getCharacters:      -> @characters.getCharacters()
  get: (position)     -> @characters.getByPosition(position)
  getItem: (position) -> @items.getByPosition(position)
  getDoors: (position)-> @land.getDoors(position)
  isExit: (position)  -> @land.isExit(position)
  isRoom: (position)  -> @land.isRoom(position)
  isSameRoom: (a, b)  -> @land.isSameRoom(a, b)
  isWall: (position)  -> @land.isWall(position)

  remove: (obj) ->
    @characters.remove(obj) || @items.remove(obj)

  createOne: (name) ->
    for p in @land.getFreePositions()
      unless @characters.getByPosition(p)?
        character = CharacterFactory.createByName(name)
        character.setPosition(p)
        return @characters.add(character)
    throw new Error("no free position on the board")

  put: (position, character) ->
    throw new Error("cannot put on the wall")  if @land.isWall(position)
    throw new Error("character is already exist") if @get(position)
    character.setPosition(position)

  inspectBy:(character) ->
    new Inspector(@, character)

  to_s: ->
    display_table = new Array2D(@land.getWidth(), @land.getHeight())
    for p in display_table.pairs()
      symbol = @characters.getSymbol(p) || @items.getSymbol(p) || @land.getSymbol(p)
      display_table.set(p, symbol)
    display_table.to_s()
