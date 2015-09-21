Piece = require('./piece')
module.exports = class Item extends Piece
  @POTION: 1
  @MEDICINE: 2
  count = 0

  getSymbol: ->
    switch(@type)
      when Item.POTION   then 'p'
      when Item.MEDICINE then 'm'
