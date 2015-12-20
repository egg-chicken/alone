class Storage
  constructor: ->
    @difficulty = 1
    @score = 0

  getDifficulty: -> @difficulty
  setDifficulty: (diff) -> @difficulty = diff

  getScore: -> @score
  setScore: (score) -> @score = score

module.exports = new Storage()
