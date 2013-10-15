console.log($);

var CPView = Backbone.View.extend({

	events: {
		'focus #COST_JOB_NUM': 'showChoices',
		//'keydown #COST_JOB_NUM': 'showChoices',
		'select #COST_JOB_NUM': 'setTaskList',

	},

	el: $('#main'),

	jobTicketCollection: null,

	taskCollection: null,

	jobTicketList: null,

	taskList: null,

	initialize: function() {
		console.log('init');
		_.bindAll(this);

		this.jobTicketCollection = new JobTicketCollection();

		this.setJobTicketList('#COST_JOB_NUM');

	},

	setJobTicketList: function(e) {
		this._setAutoComplete(e.currentTarget, this.jobTicketCollection, this.setTaskList)
	},

	setTaskList: function(e, ui) {

		var tasks = new JobTaskCollection(null, {
			jobNumber: ui.item.value
		});

		tasks.on('reset', function() {
			console.log(tasks);
			this._setAutoComplete('#COST_TASK', tasks);
		}, this);

	},

	showChoices: function(e) {
		$(e.currentTarget).autocomplete("search", "");
	},

	_setAutoComplete: function(el, collection, onSelectCallback) {
		console.log
		$(el).autocomplete({
			source: collection.getAutoCompleteList(),
			select: (onSelectCallback || null),
			minLength: 0
		});
	}


});

var view = new CPView();
