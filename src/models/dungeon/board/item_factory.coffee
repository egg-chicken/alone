Item = require('./item')

module.exports = class ItemFactory
  ITEM_LIST = [
    # 'NAME',         'SYMBOL', 'EFFECT',   'POWER', 'DESCRIPTION'
    [ 'Healing Leaf', 'l',      'heal',     [1,2,3], "restore 1-3 health"]
    [ 'Potion',       'p',      'heal',           3, "restore 3 health"]
    [ 'Elixir',       'e',      'heal',          10, "restore 10 health"]
    [ 'Long Sword',   's',      'weapon',         1, "gain 1 attack"]
    [ 'Battle Axe',   'a',      'weapon',   [0,1,2], "gain 0-2 attack"]
  ]

  @create: ->
    type = Math.floor(Math.random() * ITEM_LIST.length)
    name   = ITEM_LIST[type][0]
    symbol = ITEM_LIST[type][1]
    effect = ITEM_LIST[type][2]
    power  = ITEM_LIST[type][3]
    desc   = ITEM_LIST[type][4]
    new Item(type, name, symbol, effect, power, desc)
