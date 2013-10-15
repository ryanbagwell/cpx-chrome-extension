var JobTaskCollection = TaskCollection.extend({

	url: '/lookup_tasks.htm',

	jobNumber: 0,

	query: function() {
		if (this.jobNumber == this.options.jobNumber) return;
		this.fetch({
			data: {
				'J_NUM': this.options.jobNumber,
				'task_field': 'add_time.COST_TASK',
				'job_field': 'add_time.COST_JOB_NUM'
			},
			reset: true
		});

		this.jobNumber = this.options.jobNumber;
	}

});



