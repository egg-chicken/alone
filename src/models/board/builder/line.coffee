_ = require('underscore')
Pair = require('utils/pair')

module.exports = class Line
  SYMBOL = '_'
  constructor: (@table, @base, @end)->
  draw: ->
    _.each @base.cover(@end), (p)=>
      @table.set(p, SYMBOL)

  rotate: (rotatedTable)->
    h = @table.height - 1
    @_init(rotatedTable, h-@base.y, @base.x, h-@end.y, @end.x)

  _init: (table, x, y, endX, endY)->
    @table = table
    @base = new Pair(Math.min(x, endX), Math.min(y, endY))
    @end  = new Pair(Math.max(x, endX), Math.max(y, endY))
