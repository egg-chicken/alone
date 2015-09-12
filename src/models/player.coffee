_ = require('underscore')

module.exports = class Player
  constructor: ()->
    @hand = []

  add: (character)->
    @hand.push(character)

  characters: ->
    @hand

  direction: (character)->
    _.sample ['up', 'down', 'left', 'right']
