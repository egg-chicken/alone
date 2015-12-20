_ = require('underscore')
Strategy = require('./player/strategy')
ScoreKeeper = require('./score_keeper')

module.exports = class Player
  MODE =
    HUMAN: 0
    COMPUTER: 1
  constructor: (@mode)->
    @scoreKeeper = new ScoreKeeper()
    @hand = []
    @strategies = {}
    @reservedCommand = null

  @createHuman: -> new Player(MODE.HUMAN)
  @createComputer: -> new Player(MODE.COMPUTER)

  assign: (character)->
    if character instanceof Array
      @hand = @hand.concat(character)
    else
      @hand.push(character)

  characters: ->
    _.filter @hand, (character)-> not character.isDead()

  getCharacter: ->
    @hand[0]

  command: (character, inspector)->
    return @reservedCommand if @reservedCommand

    unless @strategies[character.getId()]
      @strategies[character.getId()] = new Strategy(character)
    @strategies[character.getId()].createCommand(inspector)

  setNextCommand: (command)-> @reservedCommand = command

  getScore:                        -> @scoreKeeper.getScore()
  addScoreByCharacter: (character) -> @scoreKeeper.addScoreByCharacter(character)
  addScoreByBoard: (boardLevel)    -> @scoreKeeper.addScoreByBoard(boardLevel)

  clearHand: ->
    @hand = []
    @strategies = {}

  isHuman: ->
    @mode == MODE.HUMAN

  isComputer: ->
    @mode == MODE.COMPUTER
