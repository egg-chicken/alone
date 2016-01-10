Command = require('./../command/')

module.exports = class Strategy
  SKILL_USE_RATE = 1/4
  DIRECTIONS = ['up', 'down', 'left', 'right']

  constructor: (@character)->

  createCommand: (@inspector)->
    @_randomMove()

  _approach: (target)->
    direction = @inspector.findNearByDirection(target)
    new Command.Move(@character, direction)

  _randomMove: ->
    direction = @_sample(DIRECTIONS)
    new Command.Move(@character, direction)

  _attackOrUseSkill: (target)->
    if Math.random() > SKILL_USE_RATE
      @_attack(target)
    else
      @_useSkill(target)

  _attack: (target)->
    new Command.Attack(@character, target)

  _useSkill: (target)->
    switch(@character.getSkillRange())
      when 1
        target ||= @inspector.findHero()
        new Command.UseSkill(@character, target)
      when 0
        new Command.UseSkill(@character, @character)
      else
        throw new Error("cannot deal the skill range: #{@character.getSkillRange()}")

  _sample: (array)->
    i = Math.floor(Math.random() * array.length)
    array[i]

  _directions: ->
    DIRECTIONS
