module.exports = class Buffer
  TYPES =
    ATTACK: 0
    DIFFENCE: 1
  @createDiffenceBuffer: (point, duration)->
    new Buffer(TYPES.DIFFENCE, point, duration)

  constructor: (@type, @point, @duration)->

  isAttackBuffer: ->
    @type == TYPES.ATTACK

  isDiffenceBuffer: ->
    @type == TYPES.DIFFENCE

  isExpired: ->
    @duration <= 0

  wane: ->
    @duration -= 1

  getPoint: ->
    @point

  getSymbol: ->
    switch(@type)
      when TYPES.ATTACK   then "A(#{@duration})"
      when TYPES.DIFFENCE then "D(#{@duration})"
