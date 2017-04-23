$( document ).ready(function() {
  var customer_id, patient_id, provider_id;
  var i = 0, is_signature_added = 0, is_birhdate_added = 0, is_provider_added = 0;
  $('.admin_side_skillzone').hide();

//ajax requests for getting customer_id patient_id and provider_id
      $.ajax({
      url: '/find_customer_id',
      success: function(data) {
        customer_id = data[0]
        console.log(customer_id);
      }
    });

    $.ajax({
    url: '/find_patient_id',
    success: function(data) {
      patient_id = data[0]
      console.log(patient_id);
      }
    });

    $.ajax({
    url: '/find_provider_id',
    success: function(data) {
      provider_id = data[0]
      console.log(provider_id);
      display_skillzone();
      }
    });

//this function make skillzone visible when user has created with skill otherwise make skillzone invisible
    function display_skillzone(){
      var ids = new Array();
      var loopCounter = 0;
      jQuery("input[type=checkbox]:checked").each
      (
        function()
        {
          ids[loopCounter] = jQuery(this).val();
          loopCounter += 1;
        }
      );
      console.log("ids" + provider_id);
      for(i=0; i<ids.length; i++)
      {
        if(ids[i] != provider_id)
        {
          $('.admin_side_skillzone').hide();
          $("#user_user_skills_attributes_0_skill_id").val($("#user_user_skills_attributes_0_skill_id option:first").val());
        }
        else if(ids[i] == provider_id)
        {
          $('.admin_side_skillzone').show();
        }
      }
    }

//This will remove signature_field, birth_date_field and skillzone when user uncheck their checkboxes
  $(":checkbox").on('click', function(event){
      if($(this).val() == customer_id && $(this).attr('id') == "user_role_ids_"+customer_id)
      {
        if($(this).prop('checked'))
        {}
        else
        {
          $(".admin_side_signature_field").fadeOut(1000, function() {
            $('.admin_side_signature_field').remove();
          });
          is_signature_added = 0;
        }
      }
      else if ($(this).val() == patient_id && $(this).attr('id') == 'user_role_ids_'+patient_id) {
        if($(this).prop('checked'))
        {}
        else
        {
          $("#user_birth_date_input").fadeOut(1000, function() {
            $('.admin_side_user_data').find("#user_birth_date_input").remove();
          });
          is_birhdate_added = 0;
        }
      }
      else if ($(this).val() == provider_id && $(this).attr('id') == 'user_role_ids_'+provider_id) {
        if($(this).prop('checked'))
        {}
        else
        {
          $('.admin_side_skillzone').fadeOut(1000);
          $("#user_user_skills_attributes_0_skill_id").val($("#user_user_skills_attributes_0_skill_id option:first").val());
          is_provider_added = 0;
        }
      }
  });


//This will insert signature_field, birth_date_field and skillzone when user check their checkboxes
  $(":checkbox").on('click', function(event){
    var idList = new Array();
    var loopCounter = 0;
    jQuery("input[type=checkbox]:checked").each
    (
      function()
      {
        idList[loopCounter] = jQuery(this).val();
        loopCounter += 1;
      }
    );
    console.log(idList);
    for(i=0; i<idList.length; i++)
    {
      if(idList[i] == customer_id && is_signature_added == 0){
          $(".admin_side_photo_field").before( '<fieldset class="inputs admin_side_signature_field" style="display:none"><ol><li id="user_signature_input" class="file input optional"><label class="label" for="user_signature">Signature</label><input id="user_signature" name="user[signature]" type="file"><p class="inline-hints"><span> Upload JPG/PNG/GIF image</span></p></li></ol></fieldset>');
          $(".admin_side_signature_field").fadeIn(1000);
          is_signature_added = 1;
      }
      else if (idList[i] == patient_id && is_birhdate_added == 0) {
        $(".admin_side_user_data ol:first").append('<li id="user_birth_date_input" class="datepicker input optiojnal stringish"><label class="label" for="user_birth_date">Birth date</label><input id="user_birth_date" class="datepicker" data-datepicker-options="{"minDate":"1-1-1935","maxDate":"Time.now.year","dateFormat":"dd/mm/yy"}" name="user[birth_date]" type="text"></li>');
        $('#user_birth_date_input').fadeIn(1000);
        is_birhdate_added = 1;
      }
      else if (idList[i] == provider_id && is_provider_added == 0) {
        $('.admin_side_skillzone').fadeIn(1000);
        is_provider_added = 1;
      }
    }
  });

});
