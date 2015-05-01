
var CPView = Backbone.View.extend({
	
	events: {
		'focus #COST_JOB_NUM': 'setJobTicketList',
		//'select #COST_JOB_NUM': 'setTaskList',
		
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
	
	_setAutoComplete: function(el, collection, onSelectCallback) {
		$(el).autocomplete({
			source: collection.getAutoCompleteList(),
			select: onSelectCallback || null
		});
	}

	
});

var view = new CPView();
