_ = require('underscore')
Character = require('./character')

module.exports = class Characters
  MAX_SIZE = 30
  constructor: ->
    @list = []

  generateHero: (free_positions)->
    position = _.find free_positions, (p)=>
      not @getByPosition(p)

    @list.push(new Character(Character.HERO, position))

  generateEnemies: (free_positions, count)->
    free_positions = _.filter free_positions, (p)=>
      not @getByPosition(p)

    _.each free_positions, (p)=>
      size = @list.length
      return if size >= count || size >= MAX_SIZE
      @list.push(new Character(Character.SLIME, p))

  getHero: ->
    _.find @list, (character)->
      character.getType() == Character.HERO

  getEnemies: ->
    _.filter @list, (character)->
      character.getType() != Character.HERO

  getByPosition: (position)->
    _.find @list, (character)->
      character.getPosition().equal(position)

  getSymbol: (position)->
    @getByPosition(position)?.getSymbol()

  remove: (character)->
    found = _.findIndex(@list, (c)-> c == character)
    @list.splice(found,1) if found >= 0
    return found >= 0
