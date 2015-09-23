module.exports = class Logger
  @doNothing: (character)->
    console.log("#{character.getUniqueName()} do nothing")

  @attack: (character ,target)->
    console.log("#{character.getUniqueName()} attacked #{target.getUniqueName()}")

  @isDamaged: (character, point)->
    console.log("#{character.getUniqueName()} take #{point} damage")

  @isDead: (character)->
    console.log("#{character.getUniqueName()} is dead")

  @move: (character, to)->
    console.log("#{character.getUniqueName()} go to (#{to.to_s()})")

  @reachExit: (character)->
    console.log("#{character.getUniqueName()} reached exit of this board")

  @getItem: (character, item)->
    console.log("#{character.getUniqueName()} got #{item.getUniqueName()}")

  @useItem: (character, item)->
    console.log("#{character.getUniqueName()} used #{item.getFullName()}")

  @useSkill: (character, skill)->
    console.log("#{character.getUniqueName()} used #{skill}")

  @failed: (error)->
    console.log("but failed (#{error})")
