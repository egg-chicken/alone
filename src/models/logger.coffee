module.exports = class Logger
  @doNothing: (character)->
    console.log("#{character.getUniqueName()} do nothing")

  @attack: (character ,target)->
    console.log("#{character.getUniqueName()} attacked #{target.getUniqueName()}")

  @isDamaged: (character, point)->
    console.log("#{character.getUniqueName()} take #{1} damage")

  @isDead: (character)->
    console.log("#{character.getUniqueName()} is dead")

  @move: (character, to)->
    console.log("#{character.getUniqueName()} go to (#{to.to_s()})")

  @failed: (error)->
    console.log("but failed")
