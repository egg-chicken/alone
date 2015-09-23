_ = require('underscore')
Piece = require('./piece')
module.exports = class Character extends Piece
  @HERO: 1
  @SLIME: 2
  constructor: (@type, @position)->
    super(@type, @position)
    @maxHealth = 3
    @health = @maxHealth
    @items = []

  getSymbol: ->
    switch(@type)
      when Character.HERO   then 'H'
      when Character.SLIME  then 's'

  damage: (point)->
    @health -= point

  isDead: ->
    @health <= 0

  addItem: (item)->
    @items.push(item)

  getItems: ->
    @items

  to_s: ->
    item_names = _.map @items, (item)-> item.getSymbol()
    "#{@getSymbol()}: { health: #{@health}/#{@maxHealth} , items: #{item_names} }"
