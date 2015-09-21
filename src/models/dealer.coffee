_ = require('underscore')
Board = require('./board')
Player = require('./player')
Logger = require('./logger')

module.exports = class Dealer
  constructor: ()->
    @board = new Board()
    @player = new Player()
    @com    = new Player()
    @player.assign(@board.get_hero())
    @com.assign(@board.get_enemies())

  turn: (command)->
    _.each @player.characters(), (character)=>
      direction = @player.direction(character)
      @moveOrAttack(character, command)
    _.each @com.characters(), (character)=>
      direction = @com.direction(character)
      @moveOrAttack(character, direction)

   moveOrAttack: (character, direction)->
    from = character.getPosition()
    switch(direction)
      when 'up', 'down', 'left', 'right'
        to = from[direction]()
      else
        Logger.doNothing(character)

    try
      target = @board.get(to)
      if target
        Logger.attack(character, target)
        target.damage(1)
        Logger.isDamaged(target, 1)

        if target.isDead()
          Logger.isDead(target)
          @board.remove(target)
      else
        Logger.move(character, to)
        @board.put(to, character)
    catch e
      Logger.failed(e)

  @test: ->
    dealer = new Dealer()

    console.log(dealer.board.to_s())
    console.log('-----------------')

    dealer.moveOrAttack(dealer.board.get_hero(), "down")
    console.log(dealer.board.to_s())
    console.log('-----------------')

    dealer.moveOrAttack(dealer.board.get_hero(), "right")
    console.log(dealer.board.to_s())
    console.log('-----------------')

    dealer.turn()
    console.log(dealer.board.to_s())
