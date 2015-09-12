_ = require('underscore')
Board = require('./board')
Player = require('./player')

module.exports = class Dealer
  constructor: ()->
    @board = new Board()
    @player = new Player()
    @player.add(@board.get_hero())

  turn: ()->
    _.each @player.characters(), (character)=>
      direction = @player.direction(character)
      @move(character, direction)

  move: (character, direction)->
    from = @board.position(character)
    switch(direction)
      when 'up', 'down', 'left', 'right'
        to = from[direction]()

    hero = @board.pop(from)
    @board.pop(to) if @board.get(to)
    @board.put(to, hero)

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
