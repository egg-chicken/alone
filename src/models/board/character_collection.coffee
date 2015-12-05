_ = require('underscore')
CharacterFactory = require('./character_factory')

module.exports = class CharacterCollection
  MAX_SIZE = 30
  constructor: (@monsterTable)->
    @list = []

  createHero: (freePositions, hero)->
    if hero
      @addOne(freePositions, hero)
    else
      @createOne(freePositions, '主人公')

  createEnemies: (freePositions, count)->
    count = Math.min(count, MAX_SIZE)
    for i in [0...count]
      @createOne(freePositions)

  createOne: (freePositions, nameOrIndex) ->
    if not(nameOrIndex) && @monsterTable?.length > 0
      nameOrIndex = _.sample(@monsterTable)
    position = _.find(freePositions, (p)=> not @getByPosition(p))
    if nameOrIndex >= 0
      character = CharacterFactory.create(nameOrIndex)
    else
      character = CharacterFactory.createByName(nameOrIndex)

    character.setPosition(position)
    @list.push(character)
    character

  addOne: (freePositions, character)->
    position = _.find(freePositions, (p)=> not @getByPosition(p))
    character.setPosition(position)
    @list.push(character)
    character

  getHero: ->
    _.find @list, (character)-> character.isHero()

  getEnemies: ->
    _.filter @list, (character)-> not character.isHero()

  getCharacters: ->
    @list

  getByPosition: (position)->
    _.find @list, (character)->
      character.getPosition().equal(position)

  getSymbol: (position)->
    @getByPosition(position)?.getSymbol()

  remove: (character)->
    found = _.findIndex(@list, (c)-> c == character)
    @list.splice(found,1) if found >= 0
    return found >= 0
