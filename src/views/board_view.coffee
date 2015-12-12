module.exports = class BoardView
  RED     = '\u001b[31m'
  GREEN   = '\u001b[32m'
  YELLOW  = '\u001b[33m'
  BLUE    = '\u001b[34m'
  RESET   = '\u001b[0m'

  constructor: (@board)->

  render: ->
    console.log("LEVEL: #{@board.getLevel()}")
    console.log(@colorBoard())

  colorBoard: ->
    @board.to_s()
      .replace(/\|/g, " ")
      .replace(/([a-z])/g,    "#{GREEN  }$1#{RESET}")
      .replace(/([A-GI-Z])/g, "#{RED    }$1#{RESET}")
      .replace(/H/g,          "#{BLUE   }H#{RESET}")
      .replace(/@/g,          "#{YELLOW }@#{RESET}")
