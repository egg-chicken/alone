# 盤面の上に配置される駒を表す
module.exports = class Piece
  count = 0
  constructor: (@type, @position)->
    count += 1
    @id = count

  getSymbol: ->
    throw new Error('this method must be overriden')

  getId: ->
    @id

  setPosition: (p)->
    @position = p

  getPosition: ->
    @position

  getUniqueName: ->
    "#{@getSymbol()}(#{@id})"
