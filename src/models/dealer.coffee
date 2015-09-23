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
          @_turn(playerCommand, arg)
        when Player.MODE.COM
          @_turn()
    @board.waneBuffers()

  boardIsCompleted: ->
    @boardCompleted

  _turn: (command, arg)->
    _.each @turnPlayer.characters(), (character)=>
      return if @boardCompleted
      switch(command)
        when 'useItem'
          Logger.useItem(character, arg)
          character.useItem(arg)
        when 'useSkill'
          Logger.useSkill(character, arg)
          character.useSkill(arg)
        when 'up', 'down', 'left', 'right'
          @_moveOrAttack(character, command)
        else
          command = @turnPlayer.direction(character)
          @_moveOrAttack(character, command)

  _moveOrAttack: (character, direction)->
    from = character.getPosition()
    switch(direction)
      when 'up', 'down', 'left', 'right'
        to = from[direction]()
        target = @board.get(to)
    try
      if to && target
        @_attack(character, target)
      else if to
        @_move(character, to)
      else
        Logger.doNothing(character)
    catch e
      Logger.failed(e)

  _move: (character, to)->
    Logger.move(character, to)
    @board.put(to, character)
    item = @board.getItem(to)
    if item
      Logger.getItem(character, item)
      character.addItem(item)
      @board.remove(item)
    if @board.isExit(to) && @turnPlayer.getMode() == Player.MODE.HUMAN
      Logger.reachExit(character)
      @boardCompleted = true

  _attack: (character, target)->
    Logger.attack(character, target)
    target.damage(1)
    Logger.isDamaged(target, 1)

    if target.isDead()
      Logger.isDead(target)
      @turnPlayer.addScore(target.getScore())
      @board.remove(target)

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
