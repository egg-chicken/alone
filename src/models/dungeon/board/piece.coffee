# 盤面の上に配置される駒を表す
module.exports = class Piece
  count = 0
  constructor: (@type, @symbol, @position)->
    count += 1
    @id = count

  getSymbol: ->
    @symbol

  getId: ->
    @id

  setPosition: (p)->
    @position = p

  getPosition: ->
    @position

  getUniqueName: ->
    "#{@symbol}(#{@id})"

  distance: (other)->
    if other.position
      @position.distance(other.position)
    else
      @position.distance(other)
