_ = require('underscore')
Board = require('./board')
Player = require('./player')

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
        console.log("#{character.getUniqueName()} do nothing")

    try
      target = @board.get(to)
      if target
        console.log("#{character.getUniqueName()} attacked #{target.getUniqueName()}")
        target.damage(1)
        console.log("#{target.getUniqueName()} take 1 damage")
        if target.isDead()
          console.log("#{target.getUniqueName()} is dead")
          @board.remove(target)
      else
        console.log("#{character.getUniqueName()} go to (#{to.to_s()})")
        @board.put(to, character)
    catch e
      console.log("but failed")

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
