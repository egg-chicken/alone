Command = require('./command')

module.exports = class UseItem extends Command
  constructor: (@actor, @item)->

  perform: (board)->
    @actor.useItem(@item)
