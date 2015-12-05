Character = require('./character')

module.exports = class CharacterFactory
  CHARACTER_LIST = [
    # 'NAME',     'SYMBOL', 'SKILL',     'SKILLRANGE', 'STRATEGY', 'SCORE', 'HEALTH'
    [ '主人公',   'H',      'NOTHING',              0, 'whim',           0,        3]
    [ '灰泥緑虫', 'S',      'ACID',                 1, 'whim',          10,        1]
    [ '手甲虫',   'B',      'GUARDFORM',            0, 'guard',         15,        2]
    [ '葛籠鼠',   'M',      'AID',                  1, 'devoted',       20,        2]
    [ '盲瓜坊',   'P',      'TACKLE',               1, 'traveler',      25,        3]
  ]

  GENERATION_TABLE = [
    [2, 2, 2, 3, 3]
    [3, 3, 3, 3, 3]
    [3, 3, 3, 3, 4]
    [3, 3, 4, 5, 5]
    [5, 5, 5, 5, 5]
  ]

  @create: (index = null)->
    type       = index || Math.floor(Math.random() * CHARACTER_LIST.length)
    name       = CHARACTER_LIST[type][0]
    symbol     = CHARACTER_LIST[type][1]
    skill      = CHARACTER_LIST[type][2]
    skillRange = CHARACTER_LIST[type][3]
    strategy   = CHARACTER_LIST[type][4]
    score      = CHARACTER_LIST[type][5]
    maxHealth  = CHARACTER_LIST[type][6]
    new Character(type, name, symbol, skill, skillRange, strategy, score, maxHealth)

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

  @createByTable: (level)->
    slot = GENERATION_TABLE[level]
    type = Math.floor(Math.random() * slot.length)
    @create(type)
