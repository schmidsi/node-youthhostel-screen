$ = require 'foundation-sites/js/vendor/jquery'
window.jQuery = window.$ = $

require 'foundation-sites/js/vendor/fastclick'
require 'foundation-sites/js/foundation'

require 'typeahead-addresspicker/bower_components/typeahead.js/dist/typeahead.bundle.js'
require 'typeahead-addresspicker/dist/typeahead-addresspicker.js'

$ ->
    $(document).foundation()

    addressPicker = new AddressPicker
        map:
            id: '#location-map'
            zoom: 7
            center: new google.maps.LatLng(46.8131873,8.2242101)
        marker:
            draggable: false
        autocompleteService:
            types: ['(cities)']
            componentRestrictions: country: 'CH'

    $('#location').typeahead {
        highlight: true
    }, {
        displayKey: 'description'
        source: addressPicker.ttAdapter()
    }

    $('#location').bind('typeahead:selected',      addressPicker.updateMap);
    $('#location').bind('typeahead:cursorchanged', addressPicker.updateMap);

    addressPicker.bindDefaultTypeaheadEvent($('location'))

    $(addressPicker).on 'addresspicker:selected', (event, result) ->
        $('input[name=lng]').val( result.lng() )
        $('input[name=lat]').val( result.lat() )
