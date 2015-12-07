Logger = require('../logger')
Move = require("./move")
Attack = require("./attack")

module.exports = class MoveOrAttack
  constructor: (@actor, @direction)->

  perform: (board)->
    from = @actor.getPosition()
    to = from[@direction]()
    @target = board.get(to)

    if @target?
      new Attack(@actor, @target).perform(board)
    else
      new Move(@actor, @direction).perform(board)
