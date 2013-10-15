var TaskModel = Backbone.Model.extend({

	defaults: {
		number: '',
		client: '',
		name: '',
		team: '',
		priority: ''
	}

});

var TaskCollection = BaseCollection.extend({

	name: 'TaskCollection',

	model: TaskModel,

	url: '/lookup_task_table',

	parse: function(html) {
		var $rows = $(html).find('table tr');
		$rows.find('tr').first().remove();

		return $.map($rows, function(row) {

			if ( $(row).find('td:eq(0)').text() == 'Task:' || $(row).find('td:eq(0)').text() == 'NONE') return false;

			return {
				task: $(row).find('td:eq(0)').text(),
				name: $(row).find('td:eq(1)').text(),
				group: $(row).find('td:eq(2)').text(),
				kind: $(row).find('td:eq(3)').text(),
			}
		});
	},

	getAutoCompleteList: function() {
		return this.map(function(job){
			return {
				label: job.get('name'),
				value: job.get('task')
			}
		});
	}

});