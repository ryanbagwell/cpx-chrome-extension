var SettingsView = Backbone.View.extend({

    events: {
        "click button": "save"
    },

    el: $('form'),

    initialize: function(options) {
        _.bindAll(this, 'save', 'showAlert');
        this.on('saved', this.showAlert);
        $('#cnp-url').val(localStorage['cnpURL']);
    },

    save: function(e) {
        e.preventDefault();
        localStorage['cnpURL'] = $('#cnp-url').val();
        this.trigger('saved');
    },

    showAlert: function(e) {
        this.$el.find('.message-wrapper .alert').show().delay(2000).fadeOut(1000);
    }

});

jQuery(document).ready(function() {
    var settings = new SettingsView();
});


