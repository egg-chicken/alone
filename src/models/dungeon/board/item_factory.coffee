Item = require('./item')

module.exports = class ItemFactory
  ITEM_LIST = [
    # 'NAME',     'SYMBOL', 'EFFECT',   'POWER', 'DESCRIPTION'
    [ 'potion',   'p',      'heal',           3, "heal character's health 3 points"]
    [ 'medicine', 'm',      'heal',           5, "heal character's health 5 points"]
  ]

  @create: ->
    type = Math.floor(Math.random() * ITEM_LIST.length)
    name   = ITEM_LIST[type][0]
    symbol = ITEM_LIST[type][1]
    effect = ITEM_LIST[type][2]
    power  = ITEM_LIST[type][3]
    desc   = ITEM_LIST[type][4]
    new Item(type, name, symbol, effect, power, desc)
