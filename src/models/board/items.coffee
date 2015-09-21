_ = require('underscore')
Item = require('./item')

module.exports = class Items
  MAX_SIZE = 30
  constructor: ->
    @list = []

  generateItems: (free_positions, count)->
    position = _.find free_positions, (p)=>
      not @getByPosition(p)

    _.each free_positions, (p)=>
      size = @list.length
      return if size >= count || size >= MAX_SIZE
      @list.push(new Item(Item.POTION, p))

  getByPosition: (position)->
    _.find @list, (item)->
      item.getPosition().equal(position)

  getSymbol: (position)->
    @getByPosition(position)?.getSymbol()

  remove: (item)->
    @list = _.without(@list, item)
