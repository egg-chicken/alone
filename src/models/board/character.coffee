_ = require('underscore')
Piece = require('./piece')
Buffers = require('./character/buffers')
Data = require('./character/data')

module.exports = class Character extends Piece
  TYPES = { HERO: 1 }
  @createRandomEnemy: (position)->
    type = _.random(2) + 2
    new Character(type, position)

  @createHero: (position)->
    new Character(TYPES.HERO, position)

  constructor: (@type, @position)->
    super(@type, @position)
    @buffers = new Buffers()
    @items = []
    @skillCount = 0
    @symbol    = Data[@type][1]
    @skill     = Data[@type][2]
    @strategy  = Data[@type][3]
    @score     = Data[@type][4]
    @maxHealth = Data[@type][5]
    @health = @maxHealth


  getSymbol: -> @symbol
  getScore: -> @score
  getSkill: -> @skill
  getStrategy: -> @strategy
  getPosition: ->
    @position

  useSkill: (name, target)->
    switch(name)
      when 'ACID'
        return # TODO: decrease the weapon duration on front character
      when 'GUARDFORM'
        @_addDiffenceBuffer(1, 2)
      when 'AID'
        if (target.health == target.maxHealth)
          throw new Error("He canceled skill, because that is meaningless")
        else if @skillCount <= 2
          target.heal(3)
        else
          throw new Error("He doesn't have medicine!")
      else
        throw new Error("use unknown skill #{name}")
    @skillCount += 1

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
