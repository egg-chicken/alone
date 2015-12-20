Board = require('./board')
Player = require('./player/')

module.exports = class Dealer
  BOARD =
    PLAYING: 0
    COMPLETED: 1
    FAILED: 2

  constructor: ->
    @user     = new Player.Human()
    @opponent = new Player.Computer()
    @boardCount = 0
    @setupBoard()

  getPlayer: -> @user

  setupBoard: ->
    @boardCount += 1
    @board = Board.create(@boardCount, @board?.getHero())
    @boardStatus = BOARD.PLAYING
    @user.clearHand()
    @user.assign(@board.getHero())
    @opponent.clearHand()
    @opponent.assign(@board.getEnemies())

  round: (playerCommand)->
    for player in [@user, @opponent]
      break unless @boardStatus == BOARD.PLAYING
      @_turn(player)

  boardIsCompleted: ->
    @boardStatus == BOARD.COMPLETED

  boardIsFailed: ->
    @boardStatus == BOARD.FAILED

  _turn: (player)->
    for character in player.characters()
      break unless @boardStatus == BOARD.PLAYING
      command = player.command(character, @board.inspectBy(character))
      command.perform(@board)
      @_updateBoardStatus(player, command)
      @_addScore(command) if player == @user

  _updateBoardStatus: (player, command)->
    if command.isGameOver()
      @boardStatus = BOARD.FAILED
    else if command.isReached() && player == @user
      @boardStatus = BOARD.COMPLETED

  _addScore: (command)->
    if command.isDefeated()
      @user.addScoreByCharacter(command.getTarget())
    else if command.isReached()
      @user.addScoreByBoard(@boardCount)
