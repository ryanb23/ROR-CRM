$(document).on("turbolinks:load", function() {
	$("#user_role").on("change",function(){
		var value = $(this).val();
		$.ajax({
	    url: '/admin/users/set_current_role',
	    data: {value: value}
    });
	})
});
