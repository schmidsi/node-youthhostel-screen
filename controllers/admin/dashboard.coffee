Q         = require 'q'
express   = require 'express'

Screen    = require '../../models/screen'
TextPanel = require '../../models/text_panel'


router = express.Router()

router.get '/', (req, res) ->
    Screen.find().exec()
    .then (screens) ->
        return res.render('admin/dashboard', coll: screens)

    .then null, (err) ->
        throw err

router.get '/screens/:id', (req, res) ->
    (->
        if req.params.id is 'add'
            return Q.fcall -> new Screen()
        else
            return Screen.findById( req.params.id ).exec()
    )()
    .then (screen) ->
        return res.render('admin/screen-detail', doc: screen)

    .then null, (err) ->
        throw err


router.post '/screens/:id', (req, res) ->
    if req.body.action is 'delete'
        Screen.findOneAndRemove(_id: req.params.id).exec()
        .then () ->
            return res.redirect("/admin/")

        .then null, (err) ->
            throw err


    (->
        if req.params.id is 'add'
            return Q.fcall -> new Screen( req.body )
        else
            return Screen.findById( req.params.id ).exec()
    )()
    .then (screen) ->
        if req.params.id isnt 'add'
            screen.set( req.body )
        return screen.save()

    .then (screen) ->
        if req.body.action is 'save'
            return res.redirect("/admin/screens/#{ screen.id }")
        if req.body.action is 'save-back'
            return res.redirect("/admin/")

    .then null, (err) ->
        throw err

module.exports = router
