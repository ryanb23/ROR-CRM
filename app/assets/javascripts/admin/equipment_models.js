$(document).on("turbolinks:load", function() {
	$("#new_equipment_model").validate({
	   messages: {
	   	"equipment_model[name]" : "Please enter name",
	   	"equipment_model[equipment_brand_id]": "please select equipment brand"
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