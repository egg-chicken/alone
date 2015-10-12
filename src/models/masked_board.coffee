_ = require('underscore')

# 一部が隠された盤面の情報を表す。
# プレイヤーは、この情報をもとに戦術を組み立てる。
module.exports = class MaskedBoard
  DIRECTIONS = ['up', 'down', 'left', 'right']

  constructor: (@board, @character)->
    @target = @board.getHero()

  findNearByDirection: (target=@target)->
    position = @character.getPosition()
    targetPosition = target.getPosition()
    method = (direction) ->
      targetPosition.distance(position[direction]())
    _.min(_.shuffle(DIRECTIONS), method)

  isNeighbor: (target=@target)->
    @character.getPosition().distance(target.getPosition()) < 2

  isSight: ->
    return false unless @board.isRoom(@character.getPosition())

    t1 = @board.getTile(@character.getPosition())
    t2 = @board.getTile(@target.getPosition())
    t1 == t2

  getNearestCharacterInSight: ->
    characters = @board.getCharacters()
    position = @character.getPosition()

    characters = _.reject characters, (target) =>
      targetPosition = target.getPosition()
      samePosition = targetPosition == position
      sameRoom = @board.isRoom(position) && @board.getTile(position) == @board.getTile(targetPosition)
      neighbor = targetPosition.distance(position) == 1
      samePosition || not(sameRoom || neighbor)

    return if _.isEmpty(characters)

    _.min characters, (target) =>
      targetPosition = target.getPosition()
      targetPosition.distance(position)
