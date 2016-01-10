_ = require('underscore')
Piece = require('./piece')
Buffers = require('./character/buffers')

module.exports = class Character extends Piece
  TYPES = { HERO: 0 }

  constructor: (@type, @name, @symbol, @skill, @skillRange, @strategy, @maxHealth, @attack)->
    super(@type, @symbol, null)
    @level = 1
    @buffers = new Buffers()
    @items = []
    @skillCount = 0
    @health = @maxHealth

  getSkill: -> @skill
  getStrategy: -> @strategy

  addSkillCount: ->
    @skillCount += 1

  getSkillCount: ->
    @skillCount

  getSkillRange: ->
    @skillRange

  getAttack: ->
    buf = if @weapon then @weapon.getPower() else 0
    @attack + buf

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

  getWeapon: ->
    @weapon

  setItems: (items)->
    @items = items

  useItem: (item, target=@)->
    found = _.findIndex(@items, (i)-> i == item)
    if found < 0
      throw new Error("the character doesn't have item #{item}")
    else if item.isEquipment()
      @weapon = item
    else
      @items.splice(found,1)
      item.activate(target)

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

  getLevel: ->
    @level

  levelUp: ->
    @level += 1
    @maxHealth += 1
    @health += 1
