

var BaseCollection = Backbone.Collection.extend({

	name: null,

	dataType: 'html',

	initialize: function(models, options) {
		if (options) this.options = options;
		this.on('reset', this.stash);
		return this;




	},

	sync: function(method, model, options) {
		var options = $.extend({
			dataType: 'html',
			parse: this.parse
			}, options);

		return Backbone.sync.call(this, method, model, options);
	},

	getAutoCompleteList: function() {
		return null;
	},

	/*
	 * DRY
	 */
	query: function() {
		this.fetch({reset: true});
	},

	/*
	 * Populates the models either from local storage or from querying the server.
	 */
	populate: function(options) {
		var models = localStorage.getItem(this.name);
		if (models) {
			console.log('using local storage');
			this.add(models);
			this.trigger('reset');
		} else {
			this.query(options);
		}
	},

	/*
	 * Saves the collection locally
	 */
	stash: function() {
		localStorage.setItem(this.name, this.models);
	}

});