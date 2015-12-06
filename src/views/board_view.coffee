module.exports = class BoardView
  constructor: (@board)->

  render: ->
    console.log("LEVEL: #{@board.getLevel()}")
    console.log(@board.to_s())
