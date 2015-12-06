_ = require('underscore')
Array2D = require('utils/array2d')
CharacterCollection = require('./board/character_collection')
CharacterFactory    = require('./board/character_factory')
ItemCollection = require('./board/item_collection')
ItemFactory    = require('./board/item_factory')
Land = require('./board/land')
Inspector = require('./board/inspector')

module.exports = class Board
  WIDTH = 80
  HEIGHT = 30
  INITIAL_ENEMY_COUNT = 5
  INITIAL_ITEM_COUNT = 5

  @create: (level, hero = null)->
    land = Land.createRandom(WIDTH, HEIGHT)

    CharacterFactory.setCreateSlot(level)
    characters = new CharacterCollection()
    characters.add(hero || CharacterFactory.createHero())
    characters.add(CharacterFactory.createBySlot()) for i in [0...INITIAL_ENEMY_COUNT]
    characters.setPositions(land.getFreePositions())

    items = new ItemCollection()
    items.add(ItemFactory.create()) for i in [0...INITIAL_ITEM_COUNT]
    items.setPositions(land.getFreePositions())
    new Board(land, characters, items, level)

  @createHall: (width, height)->
    land = Land.createHall(width, height)
    characters = new CharacterCollection()
    items = new ItemCollection()
    new Board(land, characters, items)

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
    throw new Error("character is already exist ") if @get(position)
    character.setPosition(position)

  inspectBy:(character) ->
    new Inspector(@, character)

  to_s: ->
    display_table = new Array2D(WIDTH, HEIGHT)
    for p in display_table.pairs()
      symbol = @characters.getSymbol(p) || @items.getSymbol(p) || @land.getSymbol(p)
      display_table.set(p, symbol)
    display_table.to_s()
