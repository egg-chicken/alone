Board = require('./board')
Player = require('./player')

module.exports = class Dealer
  BOARD =
    PLAYING: 0
    COMPLETED: 1
    FAILED: 2

  constructor: ->
    @players = [
      Player.createHuman()
      Player.createComputer()
    ]
    @boardCount = 0
    @setupBoard()

  setupBoard: ->
    @boardCount += 1
    @board = Board.create(@boardCount, @board?.getHero())
    @boardStatus = BOARD.PLAYING
    @players[0].assign(@board.getHero())
    @players[1].assign(@board.getEnemies())

  round: (playerCommand)->
    for player in @players
      @turnPlayer = player
      if player.isHuman()
        @_turn(playerCommand)
      else
        @_turn()

    if @boardIsCompleted()
      for player in @players
        player.clearHand()
        player.addScoreByBoard(@boardCount)

  boardIsCompleted: ->
    @boardStatus == BOARD.COMPLETED

  boardIsFailed: ->
    @boardStatus == BOARD.FAILED

  _turn: (playerCommand)->
    for character in @turnPlayer.characters()
      if  @boardStatus == BOARD.PLAYING
        command = playerCommand || @turnPlayer.command(character, @board.inspectBy(character))
        command.perform(@board)
        @_afterPerform(character, command)

  _afterPerform: (character, command)->
    if command.isDefeated()
      @turnPlayer.addScoreByCharacter(command.getTarget())

    character.waneBuffers()
    if command.isReached() && @turnPlayer.isHuman()
      @boardStatus = BOARD.COMPLETED
    else if command.isGameOver()
      @boardStatus = BOARD.FAILED

    console.log(command.toString())
