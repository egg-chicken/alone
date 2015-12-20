Command = require('./command')
module.exports = class Move extends Command
  constructor: (@actor, @direction)->

  perform: (board)->
    try
      @_move(board)
    catch e
      @failed = e
    finally
      @actor.waneBuffers()

  _move: (board)->
    from = @actor.getPosition()
    to = from[@direction]()
    board.put(to, @actor)

    @item = board.getItem(to)
    if @item
      @actor.addItem(@item)
      board.remove(@item)

    @reached = board.isExit(to)
