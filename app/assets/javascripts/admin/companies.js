$(document).on("turbolinks:load", function() {
	 $("#new_company").validate({
    rules: {
      "company[name]": {
        required: true,
        checkName: true
      },
    },
   messages: {
    "company[name]":{
      required: "Please Enter name ",
      checkName: "Please enter unique name"
    },
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