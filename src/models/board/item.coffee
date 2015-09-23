Piece = require('./piece')
module.exports = class Item extends Piece
  @POTION: 1
  @MEDICINE: 2

  getSymbol: ->
    switch(@type)
      when Item.POTION   then 'p'
      when Item.MEDICINE then 'm'

  getFullName: ->
    switch(@type)
      when Item.POTION   then 'potion'
      when Item.MEDICINE then 'medicine'

  getDescription: ->
    switch(@type)
      when Item.POTION   then "heal character's health"
      when Item.MEDICINE then "cure character's abnormal status"
