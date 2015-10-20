_ = require('underscore')
Character = require('./character')

module.exports = class Characters
  MAX_SIZE = 30
  constructor: ->
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

  createOne: (freePositions, name) ->
    position = _.find(freePositions, (p)=> not @getByPosition(p))
    character = Character.create(name, position)
    @list.push(character)

  addOne: (freePositions, character)->
    position = _.find(freePositions, (p)=> not @getByPosition(p))
    character.setPosition(position)
    @list.push(character)

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
