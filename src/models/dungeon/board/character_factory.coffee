Character = require('./character')

module.exports = class CharacterFactory
  CHARACTER_LIST = [
    # 'NAME',     'SYMBOL', 'SKILL',     'SKILLRANGE', 'STRATEGY', 'HEALTH', 'ATTACK'
    [ '主人公',   'H',      'NOTHING',              0, 'Whim',            3,       1]

    [ '灰泥緑虫', 'S',      'ACID',                 1, 'Whim',            1,       1]
    [ '手甲虫',   'B',      'GUARDFORM',            0, 'Guard',           2,       1]
    [ '葛籠鼠',   'M',      'AID',                  1, 'Priest',          2,       1]
    [ '盲瓜坊',   'P',      'TACKLE',               1, 'Traveler',        3,       2]

    [ '霞魚',     'F',      'NOTHING',              1, 'Whim',            1,       1]
    [ '鼻歌蛙',   'O',      'NOTHING',              1, 'Traveler',        4,       1]
    [ '拳骨蟹',   'C',      'NOTHING',              1, 'Traveler',        5,       2]
    [ '人喰大蓮', 'R',      'NOTHING',              1, 'Guard',           6,       2]
  ]

  GENERATION_TABLE = [
    [0, 0, 0, 0, 0]
    [1, 1, 2, 2, 3]
    [1, 2, 3, 4, 4]
    [5, 6, 6, 7, 8]
    [5, 6, 7, 7, 8]
  ]

  @create: (index = null)->
    type       = if index? then index else Math.floor(Math.random() * CHARACTER_LIST.length)
    name       = CHARACTER_LIST[type][0]
    symbol     = CHARACTER_LIST[type][1]
    skill      = CHARACTER_LIST[type][2]
    skillRange = CHARACTER_LIST[type][3]
    strategy   = CHARACTER_LIST[type][4]
    maxHealth  = CHARACTER_LIST[type][5]
    attack     = CHARACTER_LIST[type][6]
    new Character(type, name, symbol, skill, skillRange, strategy, maxHealth, attack)

  @createHero: ->
    @create(0)

  @createEnemy: ->
    heroCount = 1
    type = Math.floor(Math.random() * (CHARACTER_LIST.length - heroCount)) + heroCount
    @create(type)

  @createByName: (name)->
    for i in [0...CHARACTER_LIST.length]
      if name == CHARACTER_LIST[i][0]
        return @create(i)
    throw new Error("unknown character: #{name}")

  @setCreateSlot: (slotNumber)->
    @slot = GENERATION_TABLE[slotNumber]

  @createBySlot: ->
    index = Math.floor(Math.random() * @slot.length)
    @create(@slot[index])
