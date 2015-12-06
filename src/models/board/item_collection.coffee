module.exports = class ItemCollection
  constructor: ->
    @list = []

  add: (item)->
    @list.push(item)

  setPositions: (positions)->
    for i in [0...@list.length]
      if positions[i]
        @list[i].setPosition(positions[i])
      else
        throw new Error("position が足りません")

  getByPosition: (position)->
    for item in @list
      if item.getPosition().equal(position)
        return item

  getSymbol: (position)->
    @getByPosition(position)?.getSymbol()

  remove: (item)->
    for i in [0...@list.length]
      if @list[i] == item
        return @list.splice(i, 1)
    false
