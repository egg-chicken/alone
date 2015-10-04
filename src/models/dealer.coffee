_ = require('underscore')
Board = require('./board')
Player = require('./player')
Logger = require('./logger')

module.exports = class Dealer
  constructor: ()->
    @players = [
      new Player(Player.MODE.HUMAN)
      new Player(Player.MODE.COM)
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

  round: (playerCommand, arg)->
    _.each @players, (player)=>
      @turnPlayer = player
      switch(player.getMode())
        when Player.MODE.HUMAN
          # TODO: perform player command
          return
        when Player.MODE.COM
          @_turn()

  boardIsCompleted: ->
    @boardCompleted

  _turn: ->
    _.each @turnPlayer.characters(), (character)=>
      return if @boardCompleted
      command = @turnPlayer.command(character)
      command.perform(character, @board)
      @_afterPerform(character, command)

  _afterPerform: (character, command)->
    character.waneBuffers()
    to = character.getPosition()
    if @board.isExit(to) && @turnPlayer.getMode() == Player.MODE.HUMAN
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
