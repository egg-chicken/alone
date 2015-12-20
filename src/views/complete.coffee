Base = require('./base')

module.exports = class CompleteView extends Base
  render: ->
    @clear()
    @print("\n\n\n\n    COMPLETE\n\n\n\n")
