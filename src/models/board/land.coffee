_ = require('underscore')
Builder = require('./builder')

module.exports = class Land
  WALL = 0
  STONE_FLOOR = 1
  constructor: (width, height)->
    @table = Builder.create(width, height)
    _.each @table.pairs(), (p)=>
      unless @table.get(p) == WALL
        @table.set(p, STONE_FLOOR)

  get_free_positions: ->
    pairs = @table.pairs()
    filtered = _.filter pairs, (p)=> @table.get(p) != WALL
    _.shuffle(filtered)

  is_wall: (position)->
    @table.get(position) == WALL

  get_symbol: (position)->
    switch(@table.get(position))
      when WALL        then '#'
      when STONE_FLOOR then ' '
      else '?'
