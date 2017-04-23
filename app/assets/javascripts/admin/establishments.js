$(document).on("turbolinks:load", function() {
	$("#new_establishment,.edit_establishment").validate({
	   messages: {
	   	"establishment[name]" : "Please enter name",
	   	"establishment[iban]" : "please enter iban",
	   	"establishment[bic]" : "please enter bic"
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
