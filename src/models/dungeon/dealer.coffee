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
    @user.assign(@board.getHero())
    @opponent.assign(@board.getEnemies())

  round: (playerCommand)->
    for player in [@user, @opponent]
      @turnPlayer = player
      @_turn()

    if @boardIsCompleted()
      @user.addScoreByBoard(@boardCount)
      for player in [@user, @opponent]
        player.clearHand()

  boardIsCompleted: ->
    @boardStatus == BOARD.COMPLETED

  boardIsFailed: ->
    @boardStatus == BOARD.FAILED

  _turn: ->
    for character in @turnPlayer.characters()
      if  @boardStatus == BOARD.PLAYING
        command = @turnPlayer.command(character, @board.inspectBy(character))
        command.perform(@board)
        @_afterPerform(character, command)

  _afterPerform: (character, command)->
    if command.isDefeated() && @turnPlayer == @user
      @turnPlayer.addScoreByCharacter(command.getTarget())

    character.waneBuffers()
    if command.isReached() && @turnPlayer == @user
      @boardStatus = BOARD.COMPLETED
    else if command.isGameOver()
      @boardStatus = BOARD.FAILED

    console.log(command.toString())
