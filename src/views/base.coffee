module.exports = class BaseView
  render: ->
    throw new Error('please override me')

  clear: ->
    termCode = '\u001B[2J\u001B[0;0f'
    process.stdout.write(termCode)

  print: (str)->
    console.log(str)
