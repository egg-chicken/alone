Pair = require('utils/pair')

module.exports = class Cell
  SYMBOL = '|'
  constructor: (@table, @position)->
  draw: ->
    @table.set(@position, SYMBOL)

  rotate: (rotatedTable)->
    h = @table.height - 1
    @position = new Pair(h-@position.y, @position.x)
    @table = rotatedTable
