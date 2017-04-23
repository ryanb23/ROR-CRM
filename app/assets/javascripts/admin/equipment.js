$(document).on("turbolinks:load", function() {
	$('#equipment_acquisition_date,#equipment_start_date,#equipment_end_date').datepicker({
	  format: 'dd-mm-yyyy',
	  startDate: '0d',
	  orientation: "bottom" ,
	  autoclose: true
	});
  $("#new_equipment").validate({
    // rules: {
    //   "company[name]": {
    //     required: true,
    //     checkName: true
    //   },
    // },
   messages: {
    "equipment[serial_number]" : "Please enter serial number",
    "equipment[acquisition_date]" : "Please enter acquisition date",
    "equipment[end_date]" : "Please enter end date",
    "equipment[start_date]" : "Please enter start date",
    "equipment[incident]" : "Please enter incident",
    "equipment[leasing_reference]" : "Please enter leasing reference",
    "equipment[status]" : "Please enter serial status",
    "equipment[equipment_type_id]" : "Please select equipment type",
    "equipment[equipment_model_id]" : "Please select equipment model",
    "equipment[user_id]" : "Please select user",
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