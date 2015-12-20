Board = require('./board')
Player = require('./player/')

module.exports = class Dealer
  BOARD =
    PLAYING: 0
    COMPLETED: 1
    FAILED: 2

  constructor: ->
    @players = [
      new Player.Human()
      new Player.Computer()
    ]
    @boardCount = 0
    @setupBoard()

  getPlayer: -> @players[0]

  setupBoard: ->
    @boardCount += 1
    @board = Board.create(@boardCount, @board?.getHero())
    @boardStatus = BOARD.PLAYING
    @players[0].assign(@board.getHero())
    @players[1].assign(@board.getEnemies())

  round: (playerCommand)->
    for player in @players
      @turnPlayer = player
      @_turn()

    if @boardIsCompleted()
      @players[0].addScoreByBoard(@boardCount)
      for player in @players
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
    if command.isDefeated() && @turnPlayer instanceof Player.Human
      @turnPlayer.addScoreByCharacter(command.getTarget())

    character.waneBuffers()
    if command.isReached() && @turnPlayer instanceof Player.Human
      @boardStatus = BOARD.COMPLETED
    else if command.isGameOver()
      @boardStatus = BOARD.FAILED

    console.log(command.toString())
