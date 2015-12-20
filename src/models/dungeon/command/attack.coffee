Command = require('./command')
module.exports = class Attack extends Command
  constructor: (@actor, @target)->

  perform: (board)->
    @_attack(board)
    @actor.waneBuffers()

  _attack: (board)->
    @point = @target.damage(1)
    @defeated = @target.isDead()
    if @defeated
      board.remove(@target)
