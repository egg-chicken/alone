Strategy = require('./base')

module.exports = class PriestStrategy extends Strategy
  createCommand: (@inspector) ->
    target = @inspector.getNearestCharacterInSight()
    if not target?
      @_randomMove()
    else if @target.distance(@character) > 1
      @_approach(target)
    else if target == @inspector.findHero()
      @_attack(target)
    else
      @_useSkill(target)
