module.exports = class Attack
  constructor: (@actor, @target)->

  perform: (board)->
    @_attack(board)

  isGameOver: -> @defeated && @target.isHero()

  _attack: (board)->
    @point = @target.damage(1)
    @defeated = @target.isDead()
    if @defeated
      board.remove(@target)
