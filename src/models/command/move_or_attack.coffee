Move = require("./move")
Attack = require("./attack")
Command = require('./command')

module.exports = class MoveOrAttack extends Command
  constructor: (@actor, @direction)->

  perform: (board)->
    from = @actor.getPosition()
    to = from[@direction]()
    @target = board.get(to)
    try
      if @target? then @_attack(board) else @_move(board)
    catch e
      @failed = e

  _attack: Attack::_attack
  _move:   Move::_move
