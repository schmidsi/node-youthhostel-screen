express  = require 'express'
mongoose = require 'mongoose'


MONGO_URI   = process.env.MONGO_URI ||
              process.env.MONGOLAB_URI ||
              'mongodb://localhost/node-youthhostel-screen'
PORT        = process.env.PORT || 3000


app = express()
app.set 'port', PORT

app.set 'view engine', 'jade'
app.set 'views', __dirname + '/frontend/templates'
app.set 'trust proxy', true

app.locals.env = app.settings.env

app.use express.static(__dirname + '/dist')

app.use '/lib', express.static(__dirname + '/node_modules')
app.use '/lib', express.static(__dirname + '/bower_components')

# Until the image optimisation process isn't implemented, hack it like this:
app.use '/img', express.static(__dirname + '/frontend/images')

app.use require('body-parser').urlencoded(extended: true)
app.use require('body-parser').json()
app.use require('cookie-parser')()
app.use require('cookie-session')(secret: process.env.SECRET || 'INSECURE!!!')
app.use require('flash')()

app.get '/', (req, res) ->
    return res.render('index')

app.use '/admin', require('./controllers/admin/dashboard')


if not module.parent
    mongoose.connect(MONGO_URI)

    app.listen app.get('port')
    console.log '\n' + 'Server started and listening on port:' + app.get('port')

module.exports = app
