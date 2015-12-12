module.exports = class CommandResult
  constructor: (command)->
    @action    = command.constructor.name.toLowerCase()
    @actor     = command.actor.getUniqueName()
    @target    = command.target?.getUniqueName()
    @item      = command.item
    @direction = command.direction
    @point     = command.point
    @failed    = command.failed
    @defeated  = command.defeated
    @reached   = command.reached
    @gameover  = command.isGameOver?()

  getAction:       -> @action
  getActor:        -> @actor
  getTarget:       -> @target
  getItem:         -> @item
  getDirection:    -> @direction
  getPoint:        -> @point
  getFailedReason: -> @failed?.toString() || ""

  isDefeated: -> @defeated
  isReached:  -> @reached
  isGameOver: -> @gameover
  isFailed:   -> @failed?

  toString: ->
    "#{@actor} #{@action} #{@target || @direction || @item} #{@getFailedReason()}"
