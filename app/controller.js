CPView = Backbone.View.extend({

	events: {
		'focus #COST_JOB_NUM': 'setJobTicketList',
		//'keydown #COST_JOB_NUM': 'showChoices',
		'select #COST_JOB_NUM': 'setTaskList',

	},

	el: $('#main'),

	jobTicketCollection: null,

	taskCollection: null,

	jobTicketList: null,

	taskList: null,

	initialize: function() {
		_.bindAll(this, 'setJobTicketList', 'setTaskList', '_setAutoComplete');

		this.jobTicketCollection = new JobTicketCollection();

		this.jobTicketCollection.query();

	},

	setJobTicketList: function(e) {
		this._setAutoComplete(e.currentTarget, this.jobTicketCollection, this.setTaskList)
	},

	setTaskList: function(e, ui) {

		var tasks = new JobTaskCollection(null, {
			jobNumber: ui.item.value
		});

		tasks.on('reset', function() {
			this._setAutoComplete('#COST_TASK', tasks);
		}, this);

		tasks.query();

	},


	_setAutoComplete: function(el, collection, onSelectCallback) {

		try {
			if ($(el).autocomplete('option', 'disabled') === false)
				return;
		} catch(e) {}

		$(el).autocomplete({
			source: collection.getAutoCompleteList(),
			select: (onSelectCallback || null),
			minLength: 0
		});

		$(el).autocomplete("search", "");
	}


});

var view = new CPView();
