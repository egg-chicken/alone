Logger = require('../logger')

module.exports = class UseItem
  constructor: (@actor, @item)->

  perform: (board)->
    Logger.useItem(@actor, @item)
    @actor.useItem(@item)
