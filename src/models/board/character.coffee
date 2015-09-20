module.exports = class Character
  @HERO: 1
  @SLIME: 2
  count = 0
  constructor: (@type, @position)->
    count += 1
    @id = count

  getSymbol: ->
    switch(@type)
      when Character.HERO   then 'H'
      when Character.SLIME  then 's'

  getType: ->
    @type

  setPosition: (p)->
    @position = p

  getPosition: ->
    @position
