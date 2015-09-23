module.exports = class BoardView
  constructor: (@board)->

  render: ->
    console.log(@board.to_s())
