_ = require('underscore')
Board = require('./board')
MaskedBoard = require('./masked_board')
Player = require('./player')
Logger = require('./logger')

module.exports = class Dealer
  constructor: ()->
    @players = [
      Player.createHuman()
      Player.createComputer()
    ]
    @setupBoard()

  setupBoard: ()->
    if @board
      items = @board.getHero().getItems()
      @board = new Board()
      @board.getHero().setItems(items)
      _.each @players, (player)=> player.completeBoard()
    else
      @board = new Board()

    @boardCompleted = false
    @players[0].assign(@board.getHero())
    @players[1].assign(@board.getEnemies())

  round: (playerCommand)->
    _.each @players, (player)=>
      @turnPlayer = player
      if player.isHuman()
        @_turn(playerCommand)
      else
        @_turn()

  boardIsCompleted: ->
    @boardCompleted

  _turn: (playerCommand)->
    _.each @turnPlayer.characters(), (character)=>
      return if @boardCompleted
      command = playerCommand || @turnPlayer.command(character, new MaskedBoard(@board, character))
      command.perform(character, @board)
      @_afterPerform(character, command)

  _afterPerform: (character, command)->
    character.waneBuffers()
    to = character.getPosition()
    if @board.isExit(to) && @turnPlayer.isHuman()
      Logger.reachExit(character)
      @boardCompleted = true
    # TODO: add score if player character kills enemy

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
