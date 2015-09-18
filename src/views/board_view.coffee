Console = require('utils/console')

module.exports = class BoardView
  constructor: (@board)->

  render: ->
    Console.print(@board)
