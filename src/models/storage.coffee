class Storage
  constructor: ->
    @difficulty = 1
    @score = 0
    @hero = null

  getDifficulty: -> @difficulty
  setDifficulty: (diff) -> @difficulty = diff

  getScore: -> @score
  setScore: (score) -> @score = score

  getHero: -> @hero
  setHero: (hero) -> @hero = hero

module.exports = new Storage()
