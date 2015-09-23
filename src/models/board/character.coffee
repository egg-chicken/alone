_ = require('underscore')
Piece = require('./piece')
module.exports = class Character extends Piece
  @HERO: 0
  @SLIME: 1
  @BUG: 2
  @createRandomEnemy: (position)->
    type = _.random(1) + 1
    new Character(type, position)

  constructor: (@type, @position)->
    super(@type, @position)
    @maxHealth = 3
    @health = @maxHealth
    @items = []

  getSymbol: ->
    switch(@type)
      when Character.HERO  then 'H'
      when Character.SLIME then 'S'
      when Character.BUG   then 'B'

  getScore: ->
    switch(@type)
      when Character.HERO   then 0
      when Character.SLIME  then 10
      when Character.BUG    then 15

  damage: (point)->
    @health -= point

  heal: (point)->
    @health = Math.min(@maxHealth, @health + point)

  cure: (status)->
    # TODO: cure status

  isDead: ->
    @health <= 0

  addItem: (item)->
    @items.push(item)

  getItems: ->
    @items

  setItems: (items)->
    @items = items

  useItem: (item, target=@)->
    found = _.findIndex(@items, (i)-> i == item)
    if found >= 0
      @items.splice(found,1)
      item.activate(target)
    else
      throw new Error("the character doesn't have item #{item}")

  getHealthString: ->
    "#{@health}/#{@maxHealth}"

  getItemsString: ->
    _.map(@items, (item)-> item.getSymbol()).join(",")
