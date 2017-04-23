$(document).on("turbolinks:load", function() {
	$("#new_equipment_type").validate({
	   messages: {
	   	"equipment_type[name]" : "Please enter name",
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