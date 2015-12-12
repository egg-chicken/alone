Move = require("./move")
Attack = require("./attack")
Command = require('./command')

module.exports = class MoveOrAttack extends Command
  constructor: (@actor, @direction)->

  perform: (board)->
    from = @actor.getPosition()
    to = from[@direction]()
    @target = board.get(to)

    if @target?
      new Attack(@actor, @target).perform(board)
    else
      new Move(@actor, @direction).perform(board)
