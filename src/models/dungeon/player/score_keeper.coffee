module.exports = class ScoreKeeper
  SCORE_MASTER =
    H:   0,
    S:   2,
    B:   4,
    M:   4,
    P:  10,
    F:   5,
    O:  20,
    C:  40,
    R:  80

  constructor: ->
    @score = 0

  addScoreByCharacter: (killedCharacter)->
    gain = SCORE_MASTER[killedCharacter.getSymbol()]
    throw new Error("#{killedCharacter.getSymbol()} score is not defined") unless gain
    @score += gain

  addScoreByBoard: (boardLevel)->
    @score += Math.pow(boardLevel, 2) * 10

  getScore: ->
    @score

  setScore: (score)->
    @score = score
