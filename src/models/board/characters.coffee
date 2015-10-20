_ = require('underscore')
Character = require('./character')

module.exports = class Characters
  MAX_SIZE = 30
  constructor: ->
    @list = []

  createHero: (freePositions)->
    @createOne(freePositions, '主人公')

  createEnemies: (freePositions, count)->
    freePositions = _.filter freePositions, (p)=>
      not @getByPosition(p)

    _.each freePositions, (p)=>
      size = @list.length
      return if size >= count || size >= MAX_SIZE
      @list.push(new Character.createRandomEnemy(p))

  createOne: (freePositions, name) ->
    position = _.find(freePositions, (p)=> not @getByPosition(p))
    character = Character.create(name, position)
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
