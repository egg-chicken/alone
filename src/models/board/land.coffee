_ = require('underscore')
Builder = require('./builder')

module.exports = class Land
  WALL = 0
  constructor: (width, height)->
    @table = Builder.create(width, height)

  get_free_position: ->
    pairs = _.shuffle(@table.pairs())
    _.find pairs, (p)=>
      @table.get(p) != WALL

  is_wall: (position)->
    @table.get(position) == WALL

  get_symbol: (position)->
    @table.get(position)
