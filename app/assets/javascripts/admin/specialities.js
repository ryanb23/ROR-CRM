$(document).on("turbolinks:load", function() {
	$("#new_speciality").validate({
	   messages: {
	   	"speciality[name_en]" : "Please enter name in english",
	   	"speciality[name_fr]" : "please enter name in french",
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