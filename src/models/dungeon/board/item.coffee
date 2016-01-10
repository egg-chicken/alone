Piece = require('./piece')
module.exports = class Item extends Piece
  constructor: (@type, @name, @symbol, @effect, @power, @description)->
    super(@type, @symbol, null)

  getFullName: ->
    @name

  getDescription: ->
    @description

  getPower: ->
    @power

  isEquipment: ->
    @effect == 'weapon' || @effect == 'shield'

  activate: (target)->
    switch(@effect)
      when 'heal'
        target.heal(@power)
      else
        throw new Error("unknown effect: #{@effect}")
