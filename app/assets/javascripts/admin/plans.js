$(document).on("turbolinks:load", function() {
	$("#new_plan").validate({
		rules: {
			"plan[price]" : {
				number : true
			}
		},
	   messages: {
	   	"plan[name]" : "Please enter name",
	   	"plan[quota]" : "Please enter quota",
	   	"plan[description]" : "Please enter description",
			"plan[price]" : "Please enter valid price"
	  },
	  errorElement: 'div',
	  errorPlacement: function(error, element) {
	    var placement = $(element).data('error');
	    if (placement) {
	      $(placement).append(error);
	    } else {
	      error.insertAfter(element);
	    }
	  }
  });
});
