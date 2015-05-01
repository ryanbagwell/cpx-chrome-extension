var JobTaskCollection = TaskCollection.extend({
	
	url: '/lookup_tasks.htm',

	query: function() {
		this.fetch({
			data: {
				'J_NUM': this.options.jobNumber,
				'task_field': 'add_time.COST_TASK',
				'job_field': 'add_time.COST_JOB_NUM'
			}
		});
	}
	
});



