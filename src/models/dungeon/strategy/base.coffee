Command = require('./../command/')

module.exports = class Strategy
  SKILL_USE_RATE = 1/4
  DIRECTIONS = ['up', 'down', 'left', 'right']

  constructor: (@character)->

  createCommand: (@inspector)->
    @_randomMove()

  _randomMove: ->
    direction = @_sample(DIRECTIONS)
    new Command.Move(@character, direction)

  _attackOrUseSkill: (target)->
    if Math.random() > SKILL_USE_RATE
      @_attack()
    else
      @_useSkill(target)

  _attack: (target)-> @_approach(target)

  _useSkill: (target)->
    switch(@character.getSkillRange())
      when 1
        target ||= @inspector.findHero()
        new Command.UseSkill(@character, target)
      when 0
        new Command.UseSkill(@character, @character)
      else
        throw new Error('cannot deal the skill range: #{@character.getSkillRange()}')

  _approach: (target)->
    target ||= @inspector.findHero()
    direction = @inspector.findNearByDirection(target)
    @prevPosition = @character.getPosition()
    new Command.MoveOrAttack(@character, direction)

  _sample: (array)->
    i = Math.floor(Math.random() * array.length)
    array[i]

  _directions: ->
    DIRECTIONS
