Piece = require('./piece')
module.exports = class Item extends Piece
  constructor: (@type, @name, @symbol, @effect, @power, @description)->
    super(@type, @symbol, null)

  getFullName: ->
    @name

  getDescription: ->
    @description

  activate: (target)->
    switch(@effect)
      when 'heal'
        target.heal(3)
      else
        throw new Error("unknown effect: #{@effect}")
