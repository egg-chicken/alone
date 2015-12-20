_ = require('underscore')
ScoreKeeper = require('./score_keeper')
Player = require('./base')

module.exports = class HumanPlayer extends Player
  constructor: ->
    @scoreKeeper = new ScoreKeeper()
    @hand = []
    @nextCommand = null

  getHero: -> @hand[0]

  command: (character, inspector)-> @nextCommand

  setCommand: (command)-> @nextCommand = command

  setScore: (score)                -> @scoreKeeper.setScore(score)
  getScore:                        -> @scoreKeeper.getScore()
  addScoreByCharacter: (character) -> @scoreKeeper.addScoreByCharacter(character)
  addScoreByBoard: (boardLevel)    -> @scoreKeeper.addScoreByBoard(boardLevel)
