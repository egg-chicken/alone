_ = require('underscore')
Piece = require('./piece')
Buffers = require('./character/buffers')

module.exports = class Character extends Piece
  TYPES = { HERO: 0 }

  constructor: (@type, @name, @symbol, @skill, @skillRange, @strategy, @score, @maxHealth)->
    super(@type, @symbol, null)
    @buffers = new Buffers()
    @items = []
    @skillCount = 0
    @health = @maxHealth

  getScore: -> @score
  getSkill: -> @skill
  getStrategy: -> @strategy

  addSkillCount: ->
    @skillCount += 1

  getSkillCount: ->
    @skillCount

  getSkillRange: ->
    @skillRange

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

  isHealthy: ->
    @health == @maxHealth

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

  addDiffenceBuffer: (point, duration)->
    @buffers.addDiffenceBuffer(point, duration)
