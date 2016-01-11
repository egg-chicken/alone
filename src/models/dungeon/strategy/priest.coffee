Strategy = require('./base')

module.exports = class PriestStrategy extends Strategy
  createCommand: (@inspector) ->
    target = @_nearest()
    if target == null
      @_randomMove()
    else if target.distance(@character) > 1
      @_approach(target)
    else if target.isHero()
      @_attack(target)
    else
      @_useSkill(target)

  _nearest: ->
    min = null
    for c in @inspector.getCharactersInSight()
      unless min && min.distance(@character) < c.distance(@character)
        min = c
    min
