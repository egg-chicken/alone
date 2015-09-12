_ = require('underscore')
Array2D = require('utils/array2d')
Character = require('./character')

module.exports = class Characters
  MAX_ENEMY = 30
  constructor: (map_width, map_height)->
    @table = new Array2D(map_width, map_height, null)
    @enemies = []
    @hero = null

  generate_hero: (free_positions)->
    position = _.find free_positions, (p)=>
      @table.get(p) == null
    @hero = new Character(Character.HERO)
    @table.set(position, @hero)

  generate_enemies: (free_positions, count)->
    free_positions = _.filter free_positions, (p)=>
      @table.get(p) == null

    _.each free_positions, (p)=>
      size = @enemies.length
      return if size >= count || size >= MAX_ENEMY
      enemy = new Character(Character.SLIME)
      @enemies.push(enemy)
      @table.set(p, enemy)

  get_hero: ->
    @hero

  get: (position)->
    @table.get(position)

  get_symbol: (position)->
    @table.get(position)?.get_symbol()

  set: (position, character)->
    @table.set(position, character)

  pop: (position) ->
    character = @table.get(position)
    @table.set(position, null)
    character

  position: (character)->
    _.find @table.pairs(), (p)=>
      @table.get(p) == character
