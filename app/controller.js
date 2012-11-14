// Backbone.sync = function(method, model, options) {
// 	console.log(method);
// 	console.log(model);
// 	console.log(options);
// 	
// 	
// };
// 

var CPView = Backbone.View.extend({
	
	el: $('#main'),
	
	jobTickets: null,
	
	// events: {
	// 	'keyup #COST_JOB_NUM': 'jobSearch',
	// 	'blur #COST_JOB_NUM': 'fillJobNumber'
	// },
	
	initialize: function() {
		console.log('init');
		_.bindAll(this);
		
		this.jobTickets = new JobTickets();
		console.log(this.jobTickets);
		this.jobTickets.on('reset', function() {
			console.log('reset');
			console.log(this.jobTickets);
		});
		this.jobTickets.fetch({
			error: function(collection, xhr, options) {
				console.log('error');
				console.log(xhr);
				
			}
			
		});
	},
	
	jobSearch: function() {
		console.log('jobSearch');
	},
	
	fillJobNumber: function() {
		
	}
	
	
});

var view = new CPView();
