Logger = require('../logger')

module.exports = class Attack
  constructor: (@actor, @target)->

  perform: (board)->
    @_attack(board)

  _attack: (board)->
    point = @target.damage(1)
    Logger.attack(@actor, @target)
    Logger.isDamaged(@target, point)

    if @target.isDead()
      Logger.isDead(@target)
      board.remove(@target)
