express   = require 'express'

screen    = require '../../models/screen'
textPanel = require '../../models/text_panel'


router = express.Router()

router.get '/', (req, res) ->
    return res.render('admin/dashboard')

router.get '/screens/add', (req, res) ->
    return res.render('admin/screen-detail')

module.exports = router
