$(document).on("turbolinks:load", function() {
	 $("#new_bank_account").validate({
  rules: {
    "bank_account[user_id]": "required"
    },
  messages: {
    "bank_account[user_id]": "Please select valid user ",
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