Logger = require('../logger')

module.exports = class Move
  constructor: (@actor, @direction)->

  perform: (board)->
    try
      @_move(board)
    catch e
      Logger.failed(e)

  _move: (board)->
    from = @actor.getPosition()
    to = from[@direction]()

    Logger.move(@actor, to)

    board.put(to, @actor)
    item = board.getItem(to)
    if item
      Logger.getItem(@actor, item)
      @actor.addItem(item)
      board.remove(item)
