Board = require('./board')

module.exports = class Dealer
  constructor: ()->
    @board = new Board()

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

    dealer.move(Board.HERO, "down")
    console.log(dealer.board.to_s())
    console.log('-----------------')

    dealer.move(Board.HERO, "right")
    console.log(dealer.board.to_s())
