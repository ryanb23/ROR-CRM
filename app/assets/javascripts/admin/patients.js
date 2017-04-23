$(document).on("turbolinks:load", function() {
	// on load
  fillUpMedicalContext = function(value){
    if($("#form_file_type").val() == 1){
        $("#medical_context").html('<option value="sport">Sport</option><option value="chest pain">Chest pain</option><option value="discomfort">Discomfort</option><option value="dyspnea">Dyspnea</option>');
    }
    else{
        $("#medical_context").html('<option value="weight">Weight</option><option value="cut">Cut</option><option value="suspicion of SAS">Suspicion of SAS</option><option value="epworth">Epworth</option>');
    }
    $("#medical_context").val(value).trigger('change')
  }

  jQuery.validator.addMethod("NameCheckSpecChar", function (value) {
        if (/[!@#$%^&*()_=\[\]{};':"\\|,.<>\/?+-]/.test(value)) {
            return false;
        } else {
            return true;
        };
    }, "Speical Characters not allowed in nickname");
  jQuery.validator.methods["date"] = function (value, element) { return true; } 
	$("#new_patient").validate({
		rules:{
		 "user[lastname]": {
			 	required: true,
				NameCheckSpecChar: true
			},
			"user[firstname]": {
				required: true,
				NameCheckSpecChar: true
			}
		},
		highlight: function(element) {
        $(element).closest('.addon-form-group')
    },
    unhighlight: function(element) {
        $(element).closest('.addon-form-group')
    },
    errorElement: 'span',
      errorClass: 'help-block',
      errorPlacement: function(error, element) {
          if(element.parent('.input-group').length) {
              error.insertAfter(element.parent());
          } else {
              error.insertAfter(element);
          }
      }
  });

	$("#new_patient").submit(function( e ) {
		var isValid = $(this).valid();
		if(!isValid) {
      e.preventDefault();
    }
    else{
		  var result = confirm("Please confirm you want to send the file")
	    if(result == false)
	      return false
    }
	});
});