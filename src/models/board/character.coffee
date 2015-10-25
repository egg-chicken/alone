_ = require('underscore')
Piece = require('./piece')
Buffers = require('./character/buffers')
Data = require('./character/data')

module.exports = class Character extends Piece
  TYPES = { HERO: 1 }
  @createRandomEnemy: (position)->
    type = _.random(3) + 2
    new Character(type, position)

  @createHero: (position)->
    new Character(TYPES.HERO, position)

  @create: (name, position)->
    if name
      index = _.findIndex(Data, (data)-> data[0] == name)
    else
      index = _.random(3) + 2
    throw new Error("unknown character: #{name}") unless index?
    new Character(index, position)

  constructor: (@type, @position)->
    super(@type, @position)
    @buffers = new Buffers()
    @items = []
    @skillCount = 0
    @symbol    = Data[@type][1]
    @skill     = Data[@type][2]
    @skillRange = Data[@type][3]
    @strategy  = Data[@type][4]
    @score     = Data[@type][5]
    @maxHealth = Data[@type][6]
    @health = @maxHealth


  getSymbol: -> @symbol
  getScore: -> @score
  getSkill: -> @skill
  getStrategy: -> @strategy
  getPosition: ->
    @position

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
