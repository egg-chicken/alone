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
      @move(character, command)
    _.each @com.characters(), (character)=>
      direction = @com.direction(character)
      @move(character, direction)

  move: (character, direction)->
    from = character.get_position()
    switch(direction)
      when 'up', 'down', 'left', 'right'
        to = from[direction]()

    try
      target = @board.get(to)
      @board.remove(target) if target
      @board.put(to, character)
    catch e
      console.warn(e)

  @test: ->
    dealer = new Dealer()

    console.log(dealer.board.to_s())
    console.log('-----------------')

    dealer.move(dealer.board.get_hero(), "down")
    console.log(dealer.board.to_s())
    console.log('-----------------')

    dealer.move(dealer.board.get_hero(), "right")
    console.log(dealer.board.to_s())
    console.log('-----------------')

    dealer.turn()
    console.log(dealer.board.to_s())
