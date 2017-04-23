$(document).on("turbolinks:load", function() {
	$("#new_role").validate({
	   messages: {
	   	"role[name_en]" : "Please enter name in english",
	   	"role[name_fr]" : "please enter name in french",
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