module.exports = class Character
  @HERO: 1
  @SLIME: 2
  count = 0
  constructor: (@type)->
    count += 1
    @id = count

  get_symbol: ->
    switch(@type)
      when Character.HERO   then 'H'
      when Character.SLIME  then 's'
