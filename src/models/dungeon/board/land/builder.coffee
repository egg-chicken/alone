Array2D = require('utils/array2d')
Area = require('./builder/area')

module.exports = class Builder
  @create: (width, height)->
    builder = new Builder()
    builder.create(width, height)

  create: (width, height)->
    @table = new Array2D(width, height, 0)
    @area = new Area(@table)
    @_devide()
    @_rotate()
    @_devide()
    @_rotate()
    @_devide()
    @_rotate()
    @_devide()
    @_rotate()
    @area.draw()
    @table

  _rotate: ->
    @table = @table.rotate()
    @area.rotate(@table)

  _devide: ->
    @area.devide()

  @test: ->
    board = Builder.create(130, 30)
    console.log(board.to_s())
