_ = require('underscore')
PieceCollection = require('./piece_collection')
CharacterFactory = require('./character_factory')

module.exports = class CharacterCollection extends PieceCollection
  constructor: ->
    @list = []

  getHero: ->
    _.find @list, (character)-> character.isHero()

  getEnemies: ->
    _.filter @list, (character)-> not character.isHero()

  getCharacters: ->
    @list
