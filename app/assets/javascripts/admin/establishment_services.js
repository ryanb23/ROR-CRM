$(document).on("turbolinks:load", function() {
	$("#new_establishment_service").validate({
	   messages: {
	   	"establishment_service[name]" : "Please enter name",
	   	"establishment_service[establishment_id]" : "please select establishment"
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