Strategy = require('./base')

module.exports = class TravelerStrategy extends Strategy
  constructor: (@character) ->
    super
    @milestone = null
    @prevPosition = null

  createCommand: (@inspector) ->
    @milestone = null if @character.getPosition().equal(@milestone)
    @prevPosition = @character.getPosition()

    hero = @inspector.findHero()
    doors = @inspector.getDoorsInSight()
    if hero
      @_attackOrUseSkill()
    else if @milestone?
      @_approach(@milestone)
    else if doors.length > 0
      @milestone = @_sample(doors)
      @_approach(@milestone)
    else
      for direction in @_directions()
        next = @character.getPosition()[direction]()
        if !next.equal(@prevPosition) && @inspector.isWalkable(next)
          return @_approach(next)
