PanelBase = require './panel_base'
mongoose  = require 'mongoose'


textPanel = new PanelBase
    size:
        type: String
        enum: ['s', 'm', 'l']
        default: 'm'
    text: String


module.exports = mongoose.model('TextPanel', textPanel)
