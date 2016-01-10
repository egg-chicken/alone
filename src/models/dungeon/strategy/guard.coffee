Strategy = require('./base')

module.exports = class GuardStrategy extends Strategy
  createCommand: (@inspector) ->
    hero = @inspector.findHero()
    if hero
      @_attackOrUseSkill(hero)
    else
      @_randomMove()
