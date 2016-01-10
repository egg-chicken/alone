Strategy = require('./base')

module.exports = class WhimStrategy extends Strategy
  createCommand: (@inspector) ->
    hero = @inspector.findHero()
    if hero && @inspector.isNeighbor(hero)
      @_attackOrUseSkill(hero)
    else
      @_randomMove()
