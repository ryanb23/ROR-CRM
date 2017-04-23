$(document).ready(function() { 
  $("#bank_account_user_id").select2({});
  $("#establishment_service_establishment_id").select2({placeholder: "Please Select"})
  // $("#User").select2({placeholder: "Please Select"});
  $('.collapse').hide();
      // console.log($(this).find('div'))
    $('#headingOne').click(function() {
      if(!$('#collapseOne').is(':visible')) {
          $('.collapse').hide(400);
      }
      $('.collapse').toggle(400);
    });
});