Strategy = require('./base')

module.exports = class WhimStrategy extends Strategy
  createCommand: (@inspector) ->
    hero = @inspector.findHero()
    if hero && hero.distance(@character) == 1
      @_attackOrUseSkill(hero)
    else
      @_randomMove()
