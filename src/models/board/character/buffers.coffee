_ = require('underscore')
Buffer = require('./buffer')
module.exports = class Buffers
  constructor: ->
    @list = []

  diffence: (base)->
    calc = (point, buf)->
      if buf.isDiffenceBuffer()
        point -= buf.activate()
      else
        point
    _.inject(@list, calc, base)

  addDiffenceBuffer: (point, duration)->
    buffer = Buffer.createDiffenceBuffer(point, duration)
    @list.push(buffer)

  to_s: ->
    _.map(@list, (buffer)-> buffer.getSymbol()).join(",")
