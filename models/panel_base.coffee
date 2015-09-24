mongoose = require 'mongoose'


class PanelBase extends mongoose.Schema
    constructor: ()  ->
        mongoose.Schema.apply(this, arguments)

        @add
            priority:
                type: Number
                enum: [1, 2, 3] # 1 is the highest prio
                default: 3
            duration:
                type: Number
                default: 60
            timeslots:
                morning:
                    type: Boolean
                    default: true
                noon:
                    type: Boolean
                    default: true
                afternoon:
                    type: Boolean
                    default: true
                evening:
                    type: Boolean
                    default: true
                night:
                    type: Boolean
                    default: true

        @plugin require('mongoose-timestamp')


module.exports = PanelBase
