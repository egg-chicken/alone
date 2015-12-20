_ = require('underscore')
Buffer = require('./buffer')
module.exports = class Buffers
  constructor: ->
    @list = []

  diffence: (base)->
    calc = (point, buf)->
      if buf.isDiffenceBuffer()
        point -= buf.getPoint()
      else
        point
    _.inject(@list, calc, base)

  addDiffenceBuffer: (point, duration)->
    buffer = Buffer.createDiffenceBuffer(point, duration)
    @list.push(buffer)

  to_s: ->
    _.map(@list, (buffer)-> buffer.getSymbol()).join(",")

  wane: ->
    size = @list.length-1
    for i in [size..0] by -1
      @list[i].wane()
      if @list[i].isExpired()
        @list.splice(i, 1)
