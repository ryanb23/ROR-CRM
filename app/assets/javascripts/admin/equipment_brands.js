$(document).on("turbolinks:load", function() {
	$("#new_equipment_brand").validate({
	   messages: {
	   	"equipment_brand[equipment_type_id]" : "Please select equipment brand",
	   	"equipment_brand[name]" : "Please enter name",
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