Strategy = require('./base')

module.exports = class GuardStrategy extends Strategy
  createCommand: (@inspector) ->
    hero = @inspector.findHero()
    if hero && hero.distance(@character) == 1
      @_attackOrUseSkill(hero)
    else if hero
      @_approach(hero)
    else
      @_randomMove()
