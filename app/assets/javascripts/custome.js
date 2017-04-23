// $.ajax({
//         url: '/find_customer_id',
//         success: function(data) {
//           customer_id = data[0]
//           console.log(customer_id);
//         }
//     });

//     $.ajax({
//         url: '/find_patient_id',
//         success: function(data) {
//           patient_id = data[0]
//           console.log(patient_id);
//         }
//     });

//     $.ajax({
//         url: '/find_provider_id',
//         success: function(data) {
//           provider_id = data[0]
//           console.log(provider_id);
//         }
//     });
//     $.ajax({
//         async: false,
//         url: '/find_physician_id',
//         success: function(data) {
//           physician_id = data[0]
//         }
//     });

//     $.ajax({
//     url: '/find_delegate_customer_id',
//     success: function(data) {
//       delegate_customer_id = data[0];
//     }
//     });

var fillDataInEditForm = function(user) {
  var customer_id = user.customer
  var patient_id = user.patient
  var provider_id = user.provider
  var physician_id = user.physician
  var delegate_customer_id = user.delegate_customer
  var salesman_before_sale_id = user.salesman_before_sale
  var salesman_sav_id = user.salesman_sav

  var restrictedRoleAry = ["Customer", "Delegated customer","Patient", "Physician", "Technical Service Provider"];
  var hideFieldIdList = ["user_address", "user_street", "user_city", "user_postal_code", "user_country"];
  var fieldTemplate = $("#role-base-field").clone()
  var delegated_customer = $('#delegated_customer').clone();
  var skill_data = $('#skills').clone();
  var bank_account_data = $('#bank_accounts').clone();
  var postal_code = $('#postal_code_div').clone();
  var establishment_data = $('#establishment_fields').clone();
  var signature_data = $(".sign_up_page_signature").clone()
  $("#establishment_country").select2();
  checkedRestrictedRoleAry = [];

  if(($("body.users").length > 0) || $("body.registrations.edit").length > 0){
        var selected_type=$('.account-type').val();
        var account_type_data = $(".account-type").select2('data');
        var flag = false;
        var flag1 = false;
        var flag2 = false;
        var flag3 = false;
        var flag4 = false;
        var flag5 = false;
        var flag6 = false;
        var postal_code_flag = false;

        var data_length = $(".account-type :selected").length;
        for(i=0;i<data_length;i++){
            if(account_type_data[i].id== patient_id ){
                flag1 = true;
                $('.sign_up_page_birthdate').html('<div class="col-md-4 col-sm-4"><label for="date_of_birth" class="col-sm-12">Date of Birth</label><div class="input-group"><input id="user_birth_date" class="form-control" data-provide= "datepicker" data-date-format="dd-mm-yyyy" name= "user[birth_date]" type="text"><div class="input-group-addon "><i class="fa fa-calendar-o "></i></div></div></div>');
                // $('.sign_up_page_birthdate').append('<input id="user_birth_date" class="form-control" data-provide= "datepicker" data-date-format="dd-mm-yyyy" name= "user[birth_date]" type="text">');
                $('.sign_up_page_birthdate').fadeIn();
            }
            if(account_type_data[i].id== customer_id ){
                flag2=true;
                $('.sign_up_page_signature').html(signature_data.html());
                    // $('.sign_up_page_signature').append('<input id="user_signature" name="user[signature]" type="file" onc
                $('.sign_up_page_signature').fadeIn(1000);
                // $("#delegated_customer").html(delegated_customer.html()).hide().fadeIn(1000)
                $("#delegated_customer").html(delegated_customer.html()).hide().fadeIn(1000)
                 $(".delegate_customer_ids").select2()
            }
            if(account_type_data[i].id==provider_id || account_type_data[i].id==physician_id ){
                flag4=true;
                $("#skills").html(skill_data.html()).hide().fadeIn(1000)
            }
            if( account_type_data[i].id==customer_id || account_type_data[i].id==provider_id ){
                flag5=true;
                $("#bank_accounts").html(bank_account_data.html()).hide().fadeIn(1000)
            }
            if( account_type_data[i].id==salesman_before_sale_id || account_type_data[i].id==salesman_sav_id ){
              postal_code_flag=true;
              $("#postal_code_div").html(postal_code.html()).hide().fadeIn(1000)
            }
            if(account_type_data[i].id == customer_id || account_type_data[i].id == delegate_customer_id || account_type_data[i].id == provider_id){
              flag6 = true;
              $("#establishment_fields").html(establishment_data.html()).hide().fadeIn(1000)
            }
             // if(!(account_type_data[i].id == 69 ||account_type_data[i].id == 78 || account_type_data[i].id == 73 || account_type_data[i].id == 74)){
             //    flag3 = true;
             //    var index = checkedRestrictedRoleAry.indexOf(this.dataset.value);
             //        checkedRestrictedRoleAry.splice(index, 1);
             //        if(checkedRestrictedRoleAry.length <= 0){
             //            $("#role-base-field").html(fieldTemplate.html()).hide().fadeIn(1000)
             //            $("#user_country").select2();
             //        }
             //        }
            if((account_type_data[i].id == customer_id ||account_type_data[i].id == patient_id || account_type_data[i].id == physician_id || account_type_data[i].id == provider_id || account_type_data[i].id == delegate_customer_id)){
                flag3 = true;
                // console.log(this.dataset)
                // checkedRestrictedRoleAry.push($('.account-type').val().dataset.value);

                // hideFieldIdList.forEach(function(value){
                // $("#"+value).parents(".form-group").fadeOut("1000", function(){
                //   if(value === "user_country") $("#user_country").select2('destroy');
                //     $(this).empty()
                //   });
                // })
                // var index = checkedRestrictedRoleAry.indexOf(this.dataset.value);
                // checkedRestrictedRoleAry.splice(index, 1);
                // if(checkedRestrictedRoleAry.length <= 0){
                    $("#role-base-field").html(fieldTemplate.html()).hide().fadeIn(1000)
                    $("#user_country").select2();
                // }

            }
        }

        if(flag1 == false){
          $('.sign_up_page_birthdate').html('');
          $(".sign_up_page_birthdate").fadeOut();
        }
        if(flag2 == false){
          $('.sign_up_page_signature').html('');
          $(".sign_up_page_signature").fadeOut();
        }
        if(flag3 == false){
          $('#role-base-field').html('');
          $("#role-base-field").fadeOut();
        }
        if(flag4 == false){
          $("#skills").empty();
          $("#skills").fadeOut();
        }
        if(flag5 == false){
          $("#bank_accounts").empty();
          $("#bank_accounts").fadeOut();
        }
        if(flag6 == false){
          $("#establishment_fields").empty();
          $("#establishment_fields").fadeOut();
        }
        if(postal_code_flag == false){
          $('#postal_code_div').html('');
          $('#postal_code_div').fadeOut();
        }


        var establishment_id = $('#user_establishment_id').val()
        if(establishment_id == ""){
          $("#admin_side_user_establishment_service").empty();
        }
        $.ajax({
          url: '/establishment_services',
          type: 'GET',
          data: {'id' : establishment_id},
          dataType: 'json'
        }).success(function(data){
          generate_admin_service(data)
        });
        setTimeout(function(){
          if($("#postal_code_div").length > 0){
            $(".postal").tagit();
          }
        },1000)
    }
}
$(document).on("turbolinks:load", function() {
  $.ajax({
    async: false,
    url: '/get_users',
    success: function(user) {
      customer_id = user.customer
      patient_id = user.patient
      provider_id = user.provider
      physician_id = user.physician
      delegate_customer_id = user.delegate_customer
      salesman_before_sale_id = user.salesman_before_sale
      salesman_sav_id = user.salesman_sav
    }
  });

    /*SIDEPANEL*/

    var $state = localStorage.getItem('state');
    var $state2 = localStorage.getItem('id');
    if($state2 != "undefined"){
      $("#"+$state2).show();
    }else
    {
      $("#"+$state2).hide();
    }

    if($(".master-link").length > 0){
      if($state == "open"){
        $('.collapsible-menu').show();
      }
      else{
       $('.collapsible-menu').hide();
      }
    }
    $(".sidepanel  ul  li.dropdown .collapsible-menu a").click(function(e) {
      localStorage.setItem('state', "open");
    });
    $(".sidepanel  ul  li.dropdown a.master-link").click(function(e) {
        $(this).closest("li").find(".collapsible-menu").slideToggle("fast");
        $(this).closest("li").addClass("collapsible-open");
        $(this).closest("li").siblings().find(".collapsible-menu").slideUp("fast");
        $(this).closest("li").removeClass("collapsible-menu");
        e.stopPropagation();

        if($(this).parents('li').find(".active").length > 0){
          localStorage.setItem('state', "open");
        }
        else{
          localStorage.setItem('state', "close");
        }
    });
    $(".sidepanel  ul  li.dropdown a.root-user-menu").click(function(e) {
        $(this).closest("li").find(".collapsible-menu").slideToggle("fast");
        $(this).closest("li").addClass("collapsible-open");
        $(this).closest("li").siblings().find(".collapsible-menu").slideUp("fast");
        $(this).closest("li").removeClass("collapsible-menu");
        e.stopPropagation();
        $current_id = $(this).siblings('ul').attr("id");
        // debugger;
        if($(this).parents('li').hasClass("collapsible-open") == true){
          localStorage.setItem('id', $current_id);
        }
        // else{
        //   localStorage.setItem('state'+$current_id, "close");
        // }
    });


    $(".navbar-toggle").click(function() {
        $(".sidepanel").toggleClass("open");
        $(".sidepanel").toggleClass("open");
        // $(".push-wrapper").toggleClass("expand");
        $(this).toggleClass("active");
    });
    $('input[type=file]').change(function() {
      $("#photo-path").val($('input[type=file]').val());
      // $("#insurance-photo-path").val($('input[type=file]').val());
    });
    // $('input[name="user[birth_date]"').
    $('.account-type').select2();

    $.ajax({
        url: '/get_all_skills',
        success: function(data) {
          skills = data;
          all_skills = '<option value="'
          for(i=0; i< skills["skills"].length; i++)
          {
            all_skills += skills["skills"][i]["id"]
            all_skills += '">'
            all_skills += skills["skills"][i]['name_'+ skills["language"]]
            all_skills += '</option>'
            if(i!= skills["skills"].length-1){
              all_skills += '<option value="'
            }
          }
        }
    });
    $("#user_position_ids").select2({placeholder: I18n.please_select});
    // GET ACCOUNT TYPE

        var restrictedRoleAry = ["Customer", "Delegated customer","Patient", "Physician", "Technical Service Provider"];
        var hideFieldIdList = ["user_address", "user_street", "user_city", "user_postal_code", "user_country"];
        var fieldTemplate = $("#role-base-field").clone()
        var skill_data = $('#skills').clone();
        var bank_account_data = $('#bank_accounts').clone();
        var delegated_customer = $('#delegated_customer').clone();
        var establishment_data = $('#establishment_fields').clone();
        var postal_code = $('#postal_code_div').clone();
        var signature_data = $(".sign_up_page_signature").clone()

        // $("#user_country").select2();
        $("#establishment_country").select2();
        checkedRestrictedRoleAry = [];
    $('.account-type').on('change', function() {
      var i;
      var account_type_data = $(".account-type").select2('data')
      var selected_type=this.value;
      var flag = false;
      var flag1 = false;
      var flag2 = false;
      var flag3 = false;
      var flag4 = false;
      var flag5 = false;
      var flag6 = false;
      var postal_code_flag = false;
      for(i=0;i<account_type_data.length;i++){

        if( account_type_data[i].id==customer_id || account_type_data[i].id==provider_id ){
            flag = true;
            $('.sign_up_page_bank_account_detail').html('<div class="divider "></div><br><h4 for="informations " class="col-sm-12 control-label ">Bank account</h4><div class="row "><div class="col-md-6 col-sm-6 "><label for="IBAN " class="col-sm-12 ">IBAN</label><input type="text " class="form-control " name="bank_account[iban]" id="IBAN " placeholder="IBAN "></div><div class="col-md-6 col-sm-6 "><label for="bic " class="col-sm-12 ">BIC</label><input type="text " class="form-control " name="bank_account[bic]" id="BIC " placeholder="BIC "></div></div>')
            $(".sign_up_page_bank_account_detai").fadeIn();
        }
        if( account_type_data[i].id==customer_id || account_type_data[i].id==provider_id ){
            flag5=true;
            $("#bank_accounts").html(bank_account_data.html()).hide().fadeIn(1000)
        }
        if( account_type_data[i].id==salesman_before_sale_id || account_type_data[i].id==salesman_sav_id ){
            postal_code_flag=true;
            $("#postal_code_div").html(postal_code.html()).hide().fadeIn(1000)
        }
        if(account_type_data[i].id== patient_id ){
            flag1 = true;
            $('.sign_up_page_birthdate').html('<div class="col-md-4 col-sm-4"><label for="date_of_birth" class="col-sm-12">Date of Birth</label><div class="input-group"><input id="user_birth_date" class="form-control" data-provide= "datepicker" data-date-format="dd-mm-yyyy" name= "user[birth_date]" type="text"><div class="input-group-addon "><i class="fa fa-calendar-o "></i></div></div></div>');
            // $('.sign_up_page_birthdate').append('<input id="user_birth_date" class="form-control" data-provide= "datepicker" data-date-format="dd-mm-yyyy" name= "user[birth_date]" type="text">');
            $('.sign_up_page_birthdate').fadeIn();
        }
        if(account_type_data[i].id== customer_id ){
            flag2=true;
            $('.sign_up_page_signature').html(signature_data.html());
            // $('.sign_up_page_signature').append('<input id="user_signature" name="user[signature]" type="file" onc
             $('.sign_up_page_signature').fadeIn(1000);
             $("#delegated_customer").html(delegated_customer.html()).hide().fadeIn(1000)
             $(".delegate_customer_ids").select2()

        }
        if(account_type_data[i].id==provider_id || account_type_data[i].id == physician_id){
            flag4=true;
            $("#skills").html(skill_data.html()).hide().fadeIn(1000)

        }
        if(account_type_data[i].id==customer_id || account_type_data[i].id==provider_id || account_type_data[i].id==delegate_customer_id){
          flag6=true
          $("#establishment_fields").html(establishment_data.html()).hide().fadeIn(1000)
        }
        if((account_type_data[i].id == customer_id ||account_type_data[i].id == patient_id || account_type_data[i].id == physician_id || account_type_data[i].id == provider_id || account_type_data[i].id == delegate_customer_id)){
            flag3 = true;
            var index = checkedRestrictedRoleAry.indexOf(this.dataset.value);
            checkedRestrictedRoleAry.splice(index, 1);
            if(checkedRestrictedRoleAry.length <= 0){
                $("#role-base-field").html(fieldTemplate.html()).hide().fadeIn(1000)
                $("#user_country").select2();
            }
        }

      }

      if(postal_code_flag == false){
        $('#postal_code_div').html('');
        $('#postal_code_div').fadeOut();
      }
      if(flag == false){
        $('.sign_up_page_bank_account_detail').html('');
        $(".sign_up_page_bank_account_detai").fadeOut();
      }
      if(flag1 == false){
        $('.sign_up_page_birthdate').html('');
        $(".sign_up_page_birthdate").fadeOut();
      }
      if(flag2 == false){
        $('.sign_up_page_signature').html('');
        $(".sign_up_page_signature").fadeOut();
        $("#delegated_customer").html('');
        $("#delegated_customer").hide().fadeOut();
      }
      if(flag3 == false){
        $('#role-base-field').html('');
        $("#role-base-field").fadeOut();
      }
      if(flag4 == false){
       $("#skills").empty();
       $("#skills").fadeOut();
      }
      if(flag5 == false){
       $("#bank_accounts").empty();
       $("#bank_accounts").fadeOut();
      }
      if(flag6 == false){
        $("#establishment_fields").empty();
        $("#establishment_fields").fadeOut();
      }
      if(postal_code_flag == false){
        $('#postal_code_div').html('');
        $('#postal_code_div').fadeOut();
      }
      setTimeout(function(){
        $(".skill-upload-btn").each(function(){
          $(this).prev().val($(this).data("value"))
        })
      }, 3000);
      $(".postal").tagit({
        beforeTagAdded: function(event, ui) {
          if($(".ui-widget-content .ui-autocomplete-input").is(':focus')){
            $.ajax({
            url: '/admin/users/checkpostalcode/',
            type: 'post',
            dataType: 'json',
            data: {'tag' : ui.tagLabel}
            }).success(function(data){
              if ($.trim(data)){
                 alert("This postal code is already exist.");
              }
            });
          }
        }
      });
      $("#user_country").select2().on("change", function(e) {
        id = $(this).val();
        if($("#select_establishment").is(':visible') == false && !check_salesman_role.call()){
          $.ajax({
            url: '/admin/users/get_del_cust_by_country',
            type: 'GET',
            data: {'country_id' : id},
            dataType: 'json'
          }).success(function(data){
            var $select = $('.delegate_customer_ids');
            var options = $select.data('select2').options.options;
            $select.html('');
            var i;
            for(i=0;i<data.length;i++){
              $select.append('<option value='+ data[i].id+'>'+ data[i].email+'</option>');
            }
          });
        }
      });

    });

    var specialityLabel = $(".speciality-drop-list label").clone();
    var specialityDropList = $(".speciality-drop-list select").clone();
    $("#user_speciality_ids").select2({placeholder: I18n.please_select});
    $('.registration_page_title').on('change',function(){
        var selected_type=this.value;
        $("#user_speciality_ids").select2({placeholder: "Please Select"});
        if(selected_type==1 || selected_type==2){
          $("#user_speciality_ids").select2('destroy')
          $(".speciality-drop-list").html(specialityLabel).append(specialityDropList);
          $("#user_speciality_ids").select2({placeholder: "Please Select"});
          $(".speciality-drop-list").fadeIn();
        }
        else{
          $("#user_speciality_ids").select2('destroy')
          $(".speciality-drop-list").html("")
          $(".speciality-drop-list").fadeOut();
        }
    })
    $(document).on("click","#upload-sign",function(){
      $(".upload-sign-btn").click();
    });
    //  $(document).on("click","#skill_upload",function(){
    //   $("#competence-photo-path ").click();
    //   console.log($(".skill-upload-btn"))
    //   // console.log("hii");
    //   // console.log($('#sign').val());
    //   // $("#sign-path").val($('input[type=file]').val())
    // });
    $(document).on("change","#sign",function(){
      $("#sign-path").val($('#sign').val())
    })
    $(document).on("change","#competence-photo-path",function(){
      $(this).prev().val($(this).val())
      // $("#competence-skill-path").val($('#competence-photo-path').val())
    })
    $(document).on("change","#competence-insurance-path",function(){
      $(this).prev().val($(this).val())
      // $("#competence-ins-path").val($('#competence-insurance-path').val())
    })

//edit
    // $.ajax({
    //     url: '/find_salesman_before_sale_id',
    //     async: false,
    //     success: function(data) {
    //       salesman_before_sale_id = data[0];
    //     }
    // });

    // $.ajax({
    //     url: '/find_salesman_sav_id',
    //     async: false,
    //     success: function(data) {
    //       salesman_sav_id = data[0];
    //     }
    // });
    $.ajax({
      async: false,
      url: '/get_users',
      success: function(user) {
        var customer_id = user.customer
        var patient_id = user.patient
        var provider_id = user.provider
        var physician_id = user.physician
        var delegate_customer_id = user.delegate_customer
        var salesman_before_sale_id = user.salesman_before_sale
        var salesman_sav_id = user.salesman_sav

        fillDataInEditForm(user)
      }
    });
});
