_ = require('underscore')
Character = require('./character')

module.exports = class Characters
  MAX_SIZE = 30
  constructor: ->
    @list = []

  generate_hero: (free_positions)->
    position = _.find free_positions, (p)=>
      not @get_by_position(p)

    @list.push(new Character(Character.HERO, position))

  generate_enemies: (free_positions, count)->
    free_positions = _.filter free_positions, (p)=>
      not @get_by_position(p)

    _.each free_positions, (p)=>
      size = @list.length
      return if size >= count || size >= MAX_SIZE
      @list.push(new Character(Character.SLIME, p))

  get_hero: ->
    _.find @list, (character)->
      character.getType() == Character.HERO

  get_enemies: ->
    _.filter @list, (character)->
      character.getType() != Character.HERO

  get_by_position: (position)->
    _.find @list, (character)->
      character.getPosition().equal(position)

  getSymbol: (position)->
    @get_by_position(position)?.getSymbol()

  remove: (character)->
    @list = _.without(@list, character)
