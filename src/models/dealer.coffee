_ = require('underscore')
Board = require('./board')
Player = require('./player')
Logger = require('./logger')

module.exports = class Dealer
  constructor: ()->
    @board = new Board()
    @player = new Player()
    @com    = new Player()
    @player.assign(@board.getHero())
    @com.assign(@board.getEnemies())

  round: (playerCommand, arg)->
    @turnPlayer = @player
    @_turn(playerCommand, arg)
    @turnPlayer = @com
    @_turn()

  _turn: (command, arg)->
    _.each @turnPlayer.characters(), (character)=>
      switch(command)
        when 'useItem'
          Logger.useItem(character, arg)
          character.useItem(arg)
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

  _attack: (character, target)->
    Logger.attack(character, target)
    target.damage(1)
    Logger.isDamaged(target, 1)

    if target.isDead()
      Logger.isDead(target)
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
