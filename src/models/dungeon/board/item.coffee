Piece = require('./piece')
module.exports = class Item extends Piece
  constructor: (@type, @name, @symbol, @effect, @power, @description)->
    super(@type, @symbol, null)

  getFullName: ->
    @name

  getDescription: ->
    @description

  getPower: ->
    if @power instanceof Array
      @power[Math.floor(Math.random() * @power.length)]
    else
      @power

  isEquipment: ->
    @effect == 'weapon' || @effect == 'shield'

  activate: (target)->
    switch(@effect)
      when 'heal'
        target.heal(@getPower())
      else
        throw new Error("unknown effect: #{@effect}")
