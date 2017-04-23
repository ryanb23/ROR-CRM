$(document).on("turbolinks:load", function() {
  // $(".roles [data-id='role-33'],.roles [data-id='role-38']").on('click',function(){
  //   if($(this).is(':checked')){
  //     $('.sign_up_page_bank_account_detail').html('<label for="bank_account_iban">Iban</label><br><input id="bank_account_iban" class="form-control" name= "bank_account[iban]" type="text"><br><label for="bank_account_bic">Bic</label><br><input id="bank_account_bic" class="form-control" name= "bank_account[bic]" type="text">');
  //     $('.sign_up_page_bank_account_detail').fadeIn("slow");
  //   }
  //   else if(($(".roles [data-id='role-33']").is(':checked') == false) && ($(".roles [data-id='role-38']").is(':checked') == false)){
  //     console.log("checked false")
  //     $('.sign_up_page_bank_account_detail').html('');
  //   }
  // });
  // $(":checkbox").not(".roles [data-id='role-33'],.roles [data-id='role-38']").on('click',function(){
  //   if ($(".roles [data-id='role-33']" || ".roles [data-id='role-38']").is(':checked')){

  //   }
  //   else{
  //   $('.sign_up_page_bank_account_detail').html('');
  //   }
  // });
    /*
      Registration page hide speciality page base on condition of title
      title = Dr| Pr then show speciality drop list
      therwise hide speciality drop list
    */
    // var specialityLabel = $(".speciality-drop-list label").clone()
    // var specialityDropList = $(".speciality-drop-list select").clone()
    // $("#user_speciality_ids").select2({placeholder: "Please Select"});
    // $("#user_title").on("change",function(){
    //   if($(this).val() == 1 || $(this).val() == 2){
    //     $("#user_speciality_ids").select2('destroy')
    //     $(".speciality-drop-list").html(specialityLabel).append(specialityDropList);
    //     $("#user_speciality_ids").select2({placeholder: "Please Select"});
    //   }
    //   else if ($(this).val() == 3 || $(this).val() == 4){
    //     $("#user_speciality_ids").select2('destroy')
    //     $(".speciality-drop-list").html("")
    //   }
    // });

    /*
      Hide field based on role on registration
      restrictedRoleAry : Restricted role who have no need to feel up hideFieldIdList field.
    */
    // var restrictedRoleAry = ["Customer", "Patient", "Physician", "Technical Service Provider"];
    // var hideFieldIdList = ["user_address", "user_street", "user_city", "user_postal_code", "user_country"];
    // var fieldTemplate = $("#role-base-field").clone() // Copy template before bind select2 plugin for country
    // $("#user_country").select2();
    // checkedRestrictedRoleAry = [];
    // $(".sign_up_page_role :checkbox").on("change", function(){
    //   if(this.checked && $.inArray(this.dataset.value, restrictedRoleAry) >= 0){
    //     checkedRestrictedRoleAry.push(this.dataset.value);
    //     hideFieldIdList.forEach(function(value){
    //       $("#"+value).parents(".form-group").fadeOut("1000", function(){
    //         if(value === "user_country") $("#user_country").select2('destroy');
    //         $(this).empty()
    //       })
    //     })
    //   }
    //   else if(!this.checked && $.inArray(this.dataset.value, restrictedRoleAry) >= 0){
    //     var index = checkedRestrictedRoleAry.indexOf(this.dataset.value);
    //     checkedRestrictedRoleAry.splice(index, 1);
    //     if(checkedRestrictedRoleAry.length <= 0){
    //       $("#role-base-field").html(fieldTemplate.html()).hide().fadeIn(1000)
    //       $("#user_country").select2();
    //     }
    //   }
    // })

    /*SIDEPANEL*/
  //   $('#insurance_date').datepicker({
  //       format: 'dd-mm-yyyy',
  //       startDate: '0d'
  //   });
  //   $(".navbar-toggle").click(function() {
  //       $(".sidepanel").toggleClass("open");
  //       $(".push-wrapper").toggleClass("expand");
  //       $(this).toggleClass("active");
  //   });
  //   $('input[type=file]').change(function() {
  //       console.log("insurance");
  //       $("#photo-path").val($('input[type=file]').val());
  //       // $("#insurance-photo-path").val($('input[type=file]').val());

  //   });
  //   $('.account-type').select2();
  //    $.ajax({
  //   url: '/find_customer_id',
  //   success: function(data) {
  //     customer_id = data[0]
  //     console.log(customer_id);
  //   }
  // });

  //   $.ajax({
  //   url: '/find_patient_id',
  //   success: function(data) {
  //     patient_id = data[0]
  //     console.log(patient_id);
  //   }
  // });

  //   $.ajax({
  //   url: '/find_provider_id',
  //   success: function(data) {
  //     provider_id = data[0]
  //     console.log(provider_id);
  //   }
  // });

  //   $.ajax({
  //   url: '/get_all_skills',
  //   success: function(data) {
  //     skills = data
  //     console.log(skills);
  //     all_skills = '<option value="'
  //     for(i=0; i< skills["skills"].length; i++)
  //     {
  //       all_skills += skills["skills"][i]["id"]
  //       all_skills += '">'
  //       all_skills += skills["skills"][i]['name_'+ skills["language"]]
  //       all_skills += '</option>'
  //       if(i!= skills["skills"].length-1){
  //         all_skills += '<option value="'
  //       }
  //     }
  //     console.log(all_skills);
  //   }
  // });
    // GET ACCOUNT TYPE
        // var restrictedRoleAry = ["Customer", "Patient", "Physician", "Technical Service Provider"];
        // var hideFieldIdList = ["user_address", "user_street", "user_city", "user_postal_code", "user_country"];
        // var fieldTemplate = $("#role-base-field").clone();
        // var skill_data = $('#skills').clone();
        // $("#user_country").select2();
        // checkedRestrictedRoleAry = [];
    // $('.account-type').on('change', function() {
    //    // console.log($(".account-type").select2('data'));
    //    var i;
    //    var account_type_data = $(".account-type").select2('data')
    //     var selected_type=this.value;

    //     if(selected_type==34){
    //       $("#lastname").parent().fadeOut();
    //     }
    //     else{
    //       $("#lastname").parent().fadeIn();
    //     }
    //     var flag = false;
    //     var flag1 = false;
    //     var flag2 = false;
    //     var flag3 = false;
    //     var flag4 = false;
    //     for(i=0;i<account_type_data.length;i++){

    //     if( account_type_data[i].id == customer_id || account_type_data[i].id== provider_id ){
    //         flag = true;
    //         $('.sign_up_page_bank_account_detail').html('<div class="divider "></div><br><h4 for="informations " class="col-sm-12 control-label ">Bank account</h4><div class="row "><div class="col-md-6 col-sm-6 "><label for="IBAN " class="col-sm-12 ">IBAN</label><input type="text " class="form-control " name="bank_account[iban]" id="IBAN " placeholder="IBAN "></div><div class="col-md-6 col-sm-6 "><label for="bic " class="col-sm-12 ">BIC</label><input type="text " class="form-control " name="bank_account[bic]" id="BIC " placeholder="BIC "></div></div>')
    //         $(".sign_up_page_bank_account_detai").fadeIn();
    //     }
    //     if(account_type_data[i].id== patient_id ){
    //         flag1 = true;
    //         $('.sign_up_page_birthdate').html('<div class="col-md-4 col-sm-4"><label for="date_of_birth" class="col-sm-12">Date of Birth</label><div class="input-group"><input id="user_birth_date" class="form-control" data-provide= "datepicker" data-date-format="dd-mm-yyyy" name= "user[birth_date]" type="text"><div class="input-group-addon "><i class="fa fa-calendar-o "></i></div></div></div>');
    //         // $('.sign_up_page_birthdate').append('<input id="user_birth_date" class="form-control" data-provide= "datepicker" data-date-format="dd-mm-yyyy" name= "user[birth_date]" type="text">');
    //         $('.sign_up_page_birthdate').fadeIn();
    //     }
    //     if(account_type_data[i].id== customer_id ){
    //         flag2=true;
    //         $('.sign_up_page_signature').html('<div class="col-md-4 col-sm-4 "><label for="photo" class="col-sm-12">Signature</label><div class="input-group "><input type="text" class="form-control" name="photo-path" id="sign-path" placeholder="Upload Photo"><input type="file" class="form-control hide upload-sign-btn" name="user[signature]" id="sign"><div class="upload-dummy input-group-addon" id="upload-sign">Upload</div></div</div>');
    //         // $('.sign_up_page_signature').append('<input id="user_signature" name="user[signature]" type="file" onc
    //          $('.sign_up_page_signature').fadeIn(1000);
    //     }
    //     if(account_type_data[i].id==provider_id){
    //         flag4=true;
    //         $("#skills").html(skill_data.html()).hide().fadeIn(1000)

    //     }
    //      if(!(account_type_data[i].id == customer_id ||account_type_data[i].id == patient_id || account_type_data[i].id == 37 || account_type_data[i].id == provider_id)){
    //         flag3 = true;
    //         var index = checkedRestrictedRoleAry.indexOf(this.dataset.value);
    //             checkedRestrictedRoleAry.splice(index, 1);
    //             if(checkedRestrictedRoleAry.length <= 0){
    //                 $("#role-base-field").html(fieldTemplate.html()).hide().fadeIn(1000)
    //                 $("#user_country").select2();
    //             }
    //             }
    //         if(account_type_data[i].id == customer_id ||account_type_data[i].id == patient_id || account_type_data[i].id == 37 || account_type_data[i].id == provider_id){
    //         flag3 = false;
    //          checkedRestrictedRoleAry.push(this.dataset.value);
    //                 hideFieldIdList.forEach(function(value){
    //                 $("#"+value).parents(".form-group").fadeOut("1000", function(){
    //                     if(value === "user_country") $("#user_country").select2('destroy');
    //                     $(this).empty()
    //                 })
    //             })
    //             }
    //     }

    //     if(flag == false){
    //         $('.sign_up_page_bank_account_detail').html('');
    //         $(".sign_up_page_bank_account_detai").fadeOut();
    //     }
    //     if(flag1 == false){
    //         $('.sign_up_page_birthdate').html('');
    //         $(".sign_up_page_birthdate").fadeOut();
    //     }
    //     if(flag2 == false){
    //         $('.sign_up_page_signature').html('');
    //         $(".sign_up_page_signature").fadeOut();
    //     }
    //     if(flag4 == false){
    //        $("#skills").empty();
    //        $("#skills").fadeOut();
    //     }

    // });

        // $('.registration_page_title').select2();
        // var specialityLabel = $(".speciality-drop-list label").clone()
        // console.log(specialityLabel+"label");
        // var specialityDropList = $(".speciality-drop-list select").clone()
        // console.log(specialityDropList+"select");
    // $('.registration_page_title').on('change',function(){
    //     var selected_type=this.value;
    //     $("#user_speciality_ids").select2({placeholder: "Please Select"});
    //     if(selected_type==1 || selected_type==2){
    //         $("#user_speciality_ids").select2('destroy')
    //         $(".speciality-drop-list").html(specialityLabel).append(specialityDropList);
    //         $("#user_speciality_ids").select2({placeholder: "Please Select"});
    //         $(".speciality-drop-list").fadeIn();
    //         console.log("hi")
    //     }
    //     else{
    //         $("#user_speciality_ids").select2('destroy')
    //         $(".speciality-drop-list").html("")
    //         $(".speciality-drop-list").fadeOut();
    //     }
    // })
    // $(document).on("click","#upload-sign",function(){
    //   $(".upload-sign-btn").click();
    // });
    //  $(document).on("click","#skill_upload",function(){
    //   $("#competence-photo-path ").click();
    //   console.log($(".skill-upload-btn"))
    //   // console.log("hii");
    //   // console.log($('#sign').val());
    //   // $("#sign-path").val($('input[type=file]').val())
    // });
    // $(document).on("change","#sign",function(){
    //     console.log($('#sign').val()+"change");
    //     $("#sign-path").val($('#sign').val())
    // })
    // $(document).on("change","#competence-photo-path",function(){
    //     console.log($('#competence-photo-path').val()+"change");
    //     $("#competence-skill-path").val($('#competence-photo-path').val())
    // })
    // $(document).on("change","#competence-insurance-path",function(){

    //     $("#competence-ins-path").val($('#competence-insurance-path').val())
    // })
     $("#new_user").validate({
  rules: {
    "user[password_confirmation]": {
      equalTo: "#user_password"
    },
    "user[photo]": {
      accept: "image/png,image/jpg,image/jpeg"
    },
    "user[signature]": {
      accept: "image/png,image/jpg,image/jpeg"
    },
  },
  messages: {
    "user[email]":{
      required: "Please enter email address ",
    },
    "user[password]": "Please enter password",
    "user[password_confirmation]": {
      required: "Please enter confirm password ",
      equalTo: "Password and Password confirmation should be same"
    },
    "user[photo]": {
      accept: "Please upload valid file"
    },
    "user[signature]": {
      accept: "Please upload valid file"
    },
    "user[phone]": "Please enter phone number",
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

  $(".edit_user").validate({
    messages: {
      "user[email]":{
        required: "Please enter email address ",
      }
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
  $(".edit_user_profile").validate({
    messages: {
      "user[email]":{
        required: "Please enter email address ",
      }
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

  /*
    FOR SPECIALITY
  */
  // Approve Speciality
  $(document).on('click','#approved_speciality',function(e){
    $("#user_speciality_ids").val($(this).parents(".data-update-container:first").data("all-value-ids")).trigger("change")
    removeDataContainer(this);
  });

  // Reject Speciality
  $(document).on('click','#reject_speciality',function(e){
    removeDataContainer(this);
  });


  /*
    FOR SKILL
  */
  // Approve new skill
  $(document).on("click", "#added_skill_approve", function(){
    var hiddenEle = generate_ele("hidden")
    // replace field name attributes and remove hidden fieldset
    $("#add_new_skill_link").click();
    var $newRecord = $("#skills .row fieldset:last"); // Clone existing html to genrate new record
    var $dataContainer = $(this).parents(".data-update-container:first"); // Fetch container which contain new data
    // replace new data with exisiting data
    $newRecord.find("select").val($dataContainer.find('span#skill_name').data("value"))
    $newRecord.find("#competence-skill-path").val($dataContainer.find('span#skill_file').data("value"))
    $newRecord.find("#note").val($dataContainer.find('span#skill_comment').data("value"))
    $(hiddenEle).attr({
      name: $newRecord.find("#competence-photo-path").attr('name'),
      value: $dataContainer.find('span#skill_file').data("file-value")
    })
    $newRecord.find("#competence-photo-path").parent().append(hiddenEle); // Send image url to save
    $newRecord.find("#competence-photo-path").remove()
    removeDataContainer(this);
  });

  // Approve removed skill
  $(document).on("click", "#removed_skill_approve", function(){
    var userSkillResourceId = $(this).parents(".data-update-container:first").data("user-skill-value")
    $("#skill_resource_" + userSkillResourceId ).parents('fieldset').find('.remove_nested_fields_link').click()
    removeDataContainer(this);
  });

  // Approve changed skill
  $(document).on("click", "#change_skill_approve", function(){
    var hiddenEle = generate_ele("hidden")
    // replace field name attributes and remove hidden fieldset
    var userSkillResourceId = $(this).parents(".data-update-container:first").data("user-skill-value")
    var $targetRecord = $("#skill_resource_" + userSkillResourceId).parents('fieldset')
    var $dataContainer = $(this).parents(".data-update-container:first"); // Fetch container which contain new data
    // replace new data with exisiting data
    $targetRecord.find("select").val($dataContainer.find('span#skill_name').data("value"))
    if($dataContainer.find('span#skill_file').data("value") != ""){
      $targetRecord.find("#competence-skill-path").val($dataContainer.find('span#skill_file').data("value"))
      $(hiddenEle).attr({
        name: $targetRecord.find("#competence-photo-path").attr('name'),
        value: $dataContainer.find('span#skill_file').data("file-value")
      })
      $targetRecord.find("#competence-photo-path").parent().append(hiddenEle); // Send image url to save
      $targetRecord.find("#competence-photo-path").attr({"data-value": hiddenEle.value})
    }
    $targetRecord.find("#note").val($dataContainer.find('span#skill_comment').data("value"))
    // $targetRecord.find("#competence-photo-path").remove()
    removeDataContainer(this);
  });

  // Reject Skills
  $(document).on("click", "#skill_reject", function(){
    removeDataContainer(this);
  });

  /*
     FOR INSURANCE
  */
  // Approve new insurance
  $(document).on("click", "#added_insurance_approve", function(){
    var hiddenEle = generate_ele("hidden");
    // replace field name attributes and remove hidden fieldset
    $("#add_new_insurance_link").click();
    var $newRecord = $("#insurance fieldset.nested_user_insurances:last"); // Clone existing html to genrate new record
    var $fileContainer = $newRecord.find(".insurance-file-details"); // Get reference of file field form for insurance file
    var $dataContainer = $(this).parents(".data-update-container:first"); // Fetch container which contain new data
    // replace new data with exisiting data
    $newRecord.find("#name-of-insurance").val($dataContainer.find('span#insurance_name').data("value"));
    $newRecord.find("#insurance_end_date_field").val($dataContainer.find('span#insurance_end_date').data("value"));
    if($dataContainer.find(".uploads span").length > 0){
      $dataContainer.find(".uploads span").each(function(){
        $newRecord.find("#add_insurance_file_link").click();
        var $newFileRecord = $fileContainer.find("fieldset:last") // Get new generated field for file
        $newFileRecord.find("#competence-ins-path").val($(this).data("value"))
        $(hiddenEle).attr({
          name: $newFileRecord.find("input[type='file']").attr('name'),
          value: $(this).data("file-value")
        })
        $newFileRecord.append(hiddenEle); // Send image url to save
        $newFileRecord.find("input[type='file']").remove();
      })
    }
    removeDataContainer(this);
  });

  // Approve removed insurance
  $(document).on("click", "#removed_insurance_approve", function(){
    var userInsuranceResourceId = $(this).parents(".data-update-container:first").data("insurance-value")
    $("#insurance_resource_" + userInsuranceResourceId ).parents('fieldset').find('.remove_nested_fields_link').click()
    removeDataContainer(this);
  });

  // Modifying
  // Approve changed insurance
  $(document).on("click", "#change_insurance_approve", function(){
    var hiddenEle = generate_ele("hidden")
    // replace field name attributes and remove hidden fieldset
    var $dataContainer = $(this).parents(".data-update-container:first"); // Fetch container which contain new data
    var $targetRecord = $("#insurance_resource_" + $dataContainer.data("insurance-value") ).parents('fieldset')
    var $targetChildRecordList = $targetRecord.find(".insurance-file-details")
    // replace new data with exisiting data
    $targetRecord.find("#name-of-insurance").val($dataContainer.find('span#insurance_name').data("value"))
    $targetRecord.find("#insurance_end_date_field").val($dataContainer.find('span#insurance_end_date').data("value"))

    if($dataContainer.find('.uploads').length > 0){
      $dataContainer.find('.uploads span').each(function(){
        var $targetChildRecord = $targetChildRecordList.find('fieldset .file_field_' + $(this).data('ref-value'))
        if($(this).data('status') == "removed"){
          $targetChildRecord.find("[data-id='"+ $(this).data("ref-value") +"' ]").parents('fieldset:first').find('.remove_nested_fields_link').click();
        }
        else if($(this).data('status') == "change"){
          $targetChildRecord.find("#competence-ins-path").val($(this).data("value"))
          var hiddenEle = generate_ele("hidden")
          $(hiddenEle).attr({
            name: $targetChildRecord.find("#competence-insurance-path").attr('name'),
            value: $(this).data("file-value")
          })
          $targetChildRecord.append(hiddenEle)
          // $targetChildRecord.find("#competence-photo-path").remove()
          // $targetChildRecord.find("#competence-photo-path").attr({"data-value": hiddenEle.value})
        }
        else if($(this).data('status') == "added"){
          $targetRecord.find('#add_insurance_file_link').click();
          $targetChildRecord = $targetChildRecordList.find('fieldset:last')
          $targetChildRecord.find("#competence-ins-path").val($(this).data("value"))
          var hiddenEle = generate_ele("hidden")
          $(hiddenEle).attr({
            name: $targetChildRecord.find("#competence-insurance-path").attr('name'),
            value: $(this).data("file-value")
          })
          $targetChildRecord.append(hiddenEle)
        }
      })
    }
    removeDataContainer(this);
  });

  // Reject insurance
  $(document).on("click", "#insurance_reject", function(){
    removeDataContainer(this);
  });
  $(document).on("fields_added.nested_form_fields", function(event, param){
    // $(this).find(".uploaded_insurance_files").last().remove()
  })
});

var removeDataContainer = function(ele) {
  $(ele).parents(".data-update-container:first:first").remove();
}
