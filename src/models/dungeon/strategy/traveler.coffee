Strategy = require('./base')

module.exports = class TravelerStrategy extends Strategy
  constructor: (@character) ->
    super
    @destination = null

  createCommand: (@inspector) ->
    @_updateDestination()
    hero = @inspector.findHero()
    if hero && hero.distance(@character) == 1
      @_attackOrUseSkill(hero)
    else if hero
      @_approach(hero)
    else
      @_approach(@destination)

  _updateDestination: ->
    if @destination == null || @character.getPosition().equal(@destination)
      doors = @inspector.getDoorsInSight()
      if doors.length > 0
        @destination = @_sample(doors)
      else
        @destination = @_forward()

  _forward: ->
    for direction in @_directions()
      next = @character.getPosition()[direction]()
      if !next.equal(@prevPosition) && @inspector.isWalkable(next)
        return next

  _approach: (target)->
    @prevPosition = @character.getPosition()
    super
