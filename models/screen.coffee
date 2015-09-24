mongoose = require 'mongoose'


screenSchema = new mongoose.Schema
    name: String
    description: String
    location:
        name: String
        coords:
            lng: Number
            lat: Number
    panels: [ Object ]


screenSchema.plugin require('mongoose-timestamp')


module.exports = mongoose.model('Screen', screenSchema)
