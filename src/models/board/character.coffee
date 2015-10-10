_ = require('underscore')
Piece = require('./piece')
Buffers = require('./character/buffers')

module.exports = class Character extends Piece
  TYPES =
    HERO: 0
    SLIME: 1
    BUG: 2
  @createRandomEnemy: (position)->
    type = _.random(1) + 1
    new Character(type, position)

  @createHero: (position)->
    new Character(TYPES.HERO, position)

  constructor: (@type, @position)->
    super(@type, @position)
    @maxHealth = 3
    @health = @maxHealth
    @buffers = new Buffers()
    @items = []

  getSymbol: ->
    switch(@type)
      when TYPES.HERO  then 'H'
      when TYPES.SLIME then 'S'
      when TYPES.BUG   then 'B'

  getScore: ->
    switch(@type)
      when TYPES.HERO   then 0
      when TYPES.SLIME  then 10
      when TYPES.BUG    then 15

  getSkill: ->
    switch(@type)
      when TYPES.SLIME then 'ACID'
      when TYPES.BUG   then 'GUARDFORM'

  getStrategy: ->
    switch(@type)
      when TYPES.SLIME then 'whim'
      when TYPES.BUG   then 'guard'

  getPosition: ->
    @position

  useSkill: (name)->
    switch(name)
      when 'ACID'
        return # TODO: decrease the weapon duration on front character
      when 'GUARDFORM'
        @_addDiffenceBuffer(1, 2)
      else
        throw new Error("use unknown skill #{name}")

  damage: (base)->
    point = Math.max(0, @buffers.diffence(base))
    @health -= point
    point

  heal: (point)->
    @health = Math.min(@maxHealth, @health + point)

  cure: (status)->
    # TODO: cure status

  isDead: ->
    @health <= 0

  isHero: ->
    @type == TYPES.HERO

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

  getBuffersString: ->
    @buffers.to_s()

  waneBuffers: ->
    @buffers.wane()

  _addDiffenceBuffer: (point, duration)->
    @buffers.addDiffenceBuffer(point, duration)
