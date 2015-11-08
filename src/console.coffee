Dealer = require('./models/dealer')
MainController = require('./controllers/main_controller')

dealer = new Dealer()
mainController = new MainController(dealer)
