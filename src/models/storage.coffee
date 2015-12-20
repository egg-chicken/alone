class Storage
  constructor: ->
    @difficulty = 1

  getDifficulty: -> @difficulty
  setDifficulty: (diff) -> @difficulty = diff

module.exports = new Storage()
