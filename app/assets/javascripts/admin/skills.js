$(document).on("turbolinks:load", function() {
	$("#new_skill").validate({
	   messages: {
	   	"skill[name_en]" : "Please enter name in english",
	   	"skill[name_fr]" : "please enter name in french",
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