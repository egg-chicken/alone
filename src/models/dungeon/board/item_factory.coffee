Item = require('./item')

module.exports = class ItemFactory
  ITEM_LIST = [
    # 'NAME',         'SYMBOL', 'EFFECT',   'POWER', 'DESCRIPTION'
    [ 'potion',       'p',      'heal',           3, "restore 3 health"]
    [ 'high potion',  'h',      'heal',           5, "restore 5 health"]
    [ 'wood staff',   'w',      'weapon',         1, "[weapon] gain 1 attack"]
  ]

  @create: ->
    type = Math.floor(Math.random() * ITEM_LIST.length)
    name   = ITEM_LIST[type][0]
    symbol = ITEM_LIST[type][1]
    effect = ITEM_LIST[type][2]
    power  = ITEM_LIST[type][3]
    desc   = ITEM_LIST[type][4]
    new Item(type, name, symbol, effect, power, desc)
