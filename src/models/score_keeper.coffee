module.exports = class ScoreKeeper
  SCORE_MASTER =
    H:   0,
    S:  10,
    B:  15,
    M:  20,
    P:  25

  constructor: ->
    @score = 0

  addScoreByCharacter: (killedCharacter)->
    gain = SCORE_MASTER[killedCharacter.getSymbol()]
    @score += gain

  addScoreByBoard: (boardLevel)->
    @score += boardLevel * 100

  getScore: ->
    @score
