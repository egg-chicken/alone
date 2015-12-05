_ = require('underscore')
Item = require('./item')

module.exports = class ItemCollection
  MAX_SIZE = 30
  constructor: ->
    @list = []

  createItems: (free_positions, count)->
    for p in free_positions
      size = @list.length
      return if size >= count || size >= MAX_SIZE
      @list.push(new Item(Item.POTION, p))

  getByPosition: (position)->
    _.find @list, (item)->
      item.getPosition().equal(position)

  getSymbol: (position)->
    @getByPosition(position)?.getSymbol()

  remove: (item)->
    found = _.findIndex(@list, (i)-> i == item)
    if found >= 0
      @list.splice(found,1)
      true
    else
      false
