Storage = require('models/storage')
Board = require('./board')
Land = require('./board/land')
CharacterCollection = require('./board/character_collection')
CharacterFactory    = require('./board/character_factory')
ItemCollection = require('./board/item_collection')
ItemFactory    = require('./board/item_factory')

module.exports = class BoardFactory
  WIDTH = 80
  HEIGHT = 30
  INITIAL_ENEMY_COUNT = 5
  INITIAL_ITEM_COUNT = 5

  @create: ->
    difficulty = Storage.getDifficulty()
    hero = Storage.getHero() || CharacterFactory.createHero()

    f = new BoardFactory()
    f.setupLand(WIDTH, HEIGHT)
    f.setupCharacters(difficulty, hero)
    f.setupItems()
    new Board(f.land, f.characters, f.items, difficulty)

  @createHall: (width, height)->
    land = Land.createHall(width, height)
    characters = new CharacterCollection()
    items = new ItemCollection()
    new Board(land, characters, items)

  setupLand: (width, height)->
    @land = Land.createRandom(width, height)

  setupCharacters: (difficulty, hero) ->
    CharacterFactory.setCreateSlot(difficulty)
    @characters = new CharacterCollection()
    @characters.add(hero)
    @characters.add(CharacterFactory.createBySlot()) for i in [0...INITIAL_ENEMY_COUNT]
    @characters.setPositions(@land.getFreePositions())

  setupItems: ->
    @items = new ItemCollection()
    @items.add(ItemFactory.create()) for i in [0...INITIAL_ITEM_COUNT]
    @items.setPositions(@land.getFreePositions())
