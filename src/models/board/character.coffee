Piece = require('./piece')
module.exports = class Character extends Piece
  @HERO: 1
  @SLIME: 2
  count = 0
  constructor: (@type, @position)->
    super(@type, @position)
    @health = 3

  getSymbol: ->
    switch(@type)
      when Character.HERO   then 'H'
      when Character.SLIME  then 's'

  damage: (point)->
    @health -= point

  isDead: ->
    @health <= 0
