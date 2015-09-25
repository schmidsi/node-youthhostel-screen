$ = require 'foundation-sites/js/vendor/jquery'
window.jQuery = window.$ = $

require 'foundation-sites/js/vendor/fastclick'
require 'foundation-sites/js/foundation'

require 'typeahead-addresspicker/bower_components/typeahead.js/dist/typeahead.bundle.js'
require 'typeahead-addresspicker/dist/typeahead-addresspicker.js'

$ ->
    $(document).foundation()



    if $('#location-map').length

        $lng = $('input[name="location.coords.lng"]')
        $lat = $('input[name="location.coords.lat"]')

        marker = draggable: false

        if $lat.val() and $lng.val()
            zoom = 11
            center = new google.maps.LatLng( $lat.val(), $lng.val() )
            marker.visible = true
            marker.position = center
        else
            zoom = 7
            center = new google.maps.LatLng(46.8131873,8.2242101)

        addressPicker = new AddressPicker
            map:
                id: '#location-map'
                zoom: zoom
                center: center
            marker: marker
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

        addressPicker.bindDefaultTypeaheadEvent( $('location') )

        $(addressPicker).on 'addresspicker:selected', (event, result) ->
            console.log( result )

            $lng.val( result.lng() )
            $lat.val( result.lat() )
