_ = require('underscore')
Pair = require('utils/pair')
Cell = require('./cell')
Line = require('./line')

module.exports = class Area
  SYMBOL = 0
  roomSymbol = 'a'.charCodeAt()
  constructor: (@table, base, end)->
    @base = base || new Pair(0, 0)
    @end  = end  || new Pair(@table.width - 1, @table.height - 1)
    @children = []
    @roomSymbol = roomSymbol
    roomSymbol += 1

  draw: ->
    if _.isEmpty(@children)
      for p in @base.cover(@end)
        code = if @_onEdge(p) then SYMBOL else @roomSymbol
        @table.set(p, code)
    else
      for child in @children
        child.draw()
    @table

  devide: ->
    return null if  @end.x - @base.x < 10 || @end.y - @base.y < 5
    if _.isEmpty(@children)
      border = _.random(@base.x+5, @end.x-6)
      borderBase = new Pair(border, @base.y)
      borderEnd  = new Pair(border, @end.y)
      leftWall  = _.random(1, border - @base.x - 4)
      rightWall = _.random(1, @end.x - border  - 4)
      @children = [
        new Area(@table, @base, borderEnd.shift(-leftWall, 0))
        new Area(@table, borderBase.shift(rightWall, 0),  @end)
        new Line(@table, borderBase.shift(0, 2),  borderEnd.shift(0,-2))
        new Line(@table, borderBase.shift(-leftWall, 2), borderBase.shift(-1, 2))
        new Line(@table, borderEnd.shift(1, -2), borderEnd.shift(rightWall, -2))
        new Cell(@table, borderBase.shift(-leftWall, 2))
        new Cell(@table, borderEnd.shift(rightWall, -2))
      ]
    else
      for child in @children
        child.devide?()

  rotate: (rotatedTable)->
    for child in @children
      child.rotate(rotatedTable)
    h = @table.height - 1
    @_init(rotatedTable, h-@base.y, @base.x, h-@end.y, @end.x)

  _onEdge: (p)->
    @base.x == p.x || @base.y == p.y || @end.x == p.x || @end.y == p.y

  _init: (table, x, y, endX, endY)->
    @table = table
    @base = new Pair(Math.min(x, endX), Math.min(y, endY))
    @end  = new Pair(Math.max(x, endX), Math.max(y, endY))
