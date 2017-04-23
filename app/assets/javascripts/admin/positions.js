$(document).on("turbolinks:load", function() {
	$("#new_position").validate({
	   messages: {
	   	"position[name]" : "Please enter name",
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