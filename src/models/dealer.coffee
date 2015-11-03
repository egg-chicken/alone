Board = require('./board')
Player = require('./player')
Logger = require('./logger')

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
    @setupBoard()

  setupBoard: ->
    @board = Board.create(@board?.getHero())
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
        player.completeBoard()

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
    @turnPlayer.addScore(command.getScore())
    character.waneBuffers()
    to = character.getPosition()
    if @board.isExit(to) && @turnPlayer.isHuman()
      Logger.reachExit(character)
      @boardStatus = BOARD.COMPLETED
    else if not(@board.getHero())
      Logger.gameOver(character)
      @boardStatus = BOARD.FAILED

  @test: ->
    dealer = new Dealer()

    console.log(dealer.board.to_s())
    console.log('-----------------')

    dealer._moveOrAttack(dealer.board.getHero(), "down")
    console.log(dealer.board.to_s())
    console.log('-----------------')

    dealer._moveOrAttack(dealer.board.getHero(), "right")
    console.log(dealer.board.to_s())
    console.log('-----------------')

    dealer._turn()
    console.log(dealer.board.to_s())
