module.exports = class PieceCollection
  constructor: ->
    @list = []

  add: (piece)->
    @list.push(piece)
    piece

  remove: (piece)->
    for i in [0...@list.length]
      if @list[i] == piece
        return @list.splice(i, 1)

  getByPosition: (position)->
    for piece in @list
      if piece.getPosition().equal(position)
        return piece

  getSymbol: (position)->
    @getByPosition(position)?.getSymbol()

  setPositions: (positions)->
    for i in [0...@list.length]
      if positions[i]
        @list[i].setPosition(positions[i])
      else
        throw new Error("position が足りません")
