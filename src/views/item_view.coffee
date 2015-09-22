Console = require('utils/console')
EventEmitter = require('events').EventEmitter

module.exports = class ItemView extends EventEmitter
  constructor: (@items)->

  render: ->
    Console.print(@items)
