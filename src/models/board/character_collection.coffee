_ = require('underscore')
CharacterFactory = require('./character_factory')

module.exports = class CharacterCollection
  constructor: ->
    @list = []

  add: (character)->
    @list.push(character)
    character

  setPositions: (positions)->
    for i in [0...@list.length]
      if positions[i]
        @list[i].setPosition(positions[i])
      else
        throw new Error("position が足りません")

  getHero: ->
    _.find @list, (character)-> character.isHero()

  getEnemies: ->
    _.filter @list, (character)-> not character.isHero()

  getCharacters: ->
    @list

  getByPosition: (position)->
    _.find @list, (character)->
      character.getPosition().equal(position)

  getSymbol: (position)->
    @getByPosition(position)?.getSymbol()

  remove: (character)->
    found = _.findIndex(@list, (c)-> c == character)
    @list.splice(found,1) if found >= 0
    return found >= 0
