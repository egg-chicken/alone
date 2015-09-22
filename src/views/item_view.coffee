_ = require('underscore')
Console = require('utils/console')
EventEmitter = require('events').EventEmitter

module.exports = class ItemView extends EventEmitter
  constructor: (@items)->

  render: ->
    names = _.map(@items, (item)-> "#{item.getFullName()}: #{item.getDescription()}")
    Console.print(names.join("\n"))
