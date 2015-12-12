module.exports = class UseItem
  constructor: (@actor, @item)->

  perform: (board)->
    @actor.useItem(@item)
