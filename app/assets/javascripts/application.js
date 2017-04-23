// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require tether
//= require bootstrap
//= require bootstrap-datepicker

//= require nested_form_fields
//= require jquery.validate
//= require select2
//= require password
//=require custome
//= require zxcvbn
//= require custome-tool
//= require turbolinks
//= require users/registrations
//= require admin/users
//= require admin/bank_accounts
//= require admin/companies
//= require admin/equipment
//= require admin/equipment_brands
//= require admin/equipment_models
//= require admin/equipment_types
//= require admin/establishment_services
//= require admin/establishments
//= require admin/patients
//= require admin/plans
//= require admin/positions
//= require admin/settings
//= require admin/roles
//= require admin/skills
//= require admin/specialities
//= require admin
//= require push
//= require cable
//= require_tree ./channels
Push.Permission.request();

var idList,customer_id, patient_id, provider_id, skills, all_skills, language;
var i = 0, is_signature_added = 0, is_birhdate_added = 0, is_skillzone_added = 0;


$(document).on("turbolinks:load", function() {

  // Mark notification as read
  $(document).on('click', '#notification-redirect-link', function(e){
    // Prevent to redirect and decrease unread notification count first to get updated unread count in next request
    e.preventDefault();
    var _this = this
    $.ajax({
      url: '/mark_notification_as_read',
      dataType: 'script',
      data: {notification_id: $(_this).data("notification-id")},
    })
    // Redirect on notification content with updated unread notification count
    window.location = $(this).attr('href')
  })


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

  $("#user_position_ids").select2({placeholder: I18n.please_select});
  $("#establishment_user_ids").select2();
  $("#equipment_salesman_id").select2();
  $(".patient_invoice_search_patient").select2();
  $(".patient_invoice_search_status").select2();

  $('#user_photo').on('change', function(event) {
    var files = event.target.files;
    var image = files[0]
    var reader = new FileReader();
    reader.onload = function(file) {
      image_Height = 100
      image_Width = 100
      var img = new Image();
      img.height = image_Height
      img.width = image_Width
      img.src = file.target.result;
      $('#display_uploaded_photo').html(img);
    }
    reader.readAsDataURL(image);
  });

  // $('.sign_up_page_signature').hide();
  // $('#display_uploaded_signature').find("img").remove();
  // $("#user_signature").val("")


//This will remove signature_field, birth_date_field and skillzone when user uncheck their checkboxes
  // $(":checkbox").on('click', function(event){
  //     if($(this).val() == customer_id && $(this).attr('id') == 'user_role_ids_'+customer_id)
  //     {
  //       if($(this).prop('checked'))
  //       {}
  //       else
  //       {
  //         $(".sign_up_page_signature").fadeOut(1000, function() {
  //           $('.sign_up_page_signature').empty();
  //         });
  //         is_signature_added = 0;
  //       }
  //     }
  //     else if ($(this).val() == patient_id && $(this).attr('id') == 'user_role_ids_'+patient_id) {
  //       if($(this).prop('checked'))
  //       {}
  //       else
  //       {
  //         $(".sign_up_page_birthdate").fadeOut(1000, function() {
  //           $('.sign_up_page_birthdate').empty();
  //         });
  //         is_birhdate_added = 0;
  //       }
  //     }
  //     else if ($(this).val() == provider_id && $(this).attr('id') == 'user_role_ids_'+provider_id) {
  //       if($(this).prop('checked'))
  //       {}
  //       else
  //       {
  //         $(".sign_up_page_skillzone").fadeOut(1000, function() {
  //           $('.sign_up_page_skillzone').empty();
  //         });
  //         is_skillzone_added = 0;
  //       }
  //     }
  // });

//This will insert signature_field, birth_date_field and skillzone when user check their checkboxes
  // $(":checkbox").on('click', function(event){
  //   var idList = new Array();
  //   var loopCounter = 0;
  //   jQuery("input[type=checkbox]:checked").each
  //   (
  //     function()
  //     {
  //       idList[loopCounter] = jQuery(this).val();
  //       loopCounter += 1;
  //     }
  //   );
    // for(i=0; i<idList.length; i++)
    // {
    //   if(idList[i] == customer_id && is_signature_added == 0){
    //     $('.sign_up_page_signature').append('<label for="user_signature">Signature</label><br>');
    //     $('.sign_up_page_signature').append('<input id="user_signature" name="user[signature]" type="file" onchange="display_image(this)"><div id="display_uploaded_signature"> </div>');
    //     $('.sign_up_page_signature').fadeIn(1000);
    //     is_signature_added = 1;
    //   }
    //   else if (idList[i] == patient_id && is_birhdate_added == 0) {
    //     $('.sign_up_page_birthdate').append('<label for="user_birth_date">Birth date</label><br>');
    //     $('.sign_up_page_birthdate').append('<input id="user_birth_date" class="form-control" data-provide= "datepicker" data-date-format="dd-mm-yyyy" name= "user[birth_date]" type="text">');
    //     $('.sign_up_page_birthdate').fadeIn(1000);
    //     is_birhdate_added = 1;
    //   }
    //   else if (idList[i] == provider_id && is_skillzone_added == 0) {
    //     // $('.sign_up_page_skillzone').append('<script id="user_user_skills_template" type="text/html"><fieldset class="nested_fields nested_user_user_skills"><div class="col-md-8"><label for="user_user_skills_attributes___user_user_skills_index___skill">Skill</label><select name="user[user_skills_attributes][__user_user_skills_index__][skill_id]" id="user_user_skills_attributes___user_user_skills_index___skill_id"><option value="1">HTML - en</option><option value="2">Css -en</option></select><br /><label for="user_user_skills_attributes___user_user_skills_index___proof">Proof</label><input type="file" name="user[user_skills_attributes][__user_user_skills_index__][proof]" id="user_user_skills_attributes___user_user_skills_index___proof" /><br><label for="user_user_skills_attributes___user_user_skills_index___comment">Comment</label><input class="form-control" type="text" name="user[user_skills_attributes][__user_user_skills_index__][comment]" id="user_user_skills_attributes___user_user_skills_index___comment" /><a class=" remove_nested_fields_link" data-delete-association-field-name="user[user_skills_attributes][__user_user_skills_index__][_destroy]" data-object-class="user_skill" href="">Remove</a></div></fieldset></script><a class="add_nested_fields_link" data-association-path="user_user_skills" data-object-class="user_skill" href="">Add User skill</a>');
    //     $('.sign_up_page_skillzone').append('<script id="user_user_skills_template" type="text/html"><fieldset class="nested_fields nested_user_user_skills"><div class="col-md-8"><label for="user_user_skills_attributes___user_user_skills_index___skill">Skill</label><select name="user[user_skills_attributes][__user_user_skills_index__][skill_id]" id="user_user_skills_attributes___user_user_skills_index___skill_id">'+ all_skills +'</select><br /><label for="user_user_skills_attributes___user_user_skills_index___proof">Proof</label><input type="file" name="user[user_skills_attributes][__user_user_skills_index__][proof]" id="user_user_skills_attributes___user_user_skills_index___proof" /><br><label for="user_user_skills_attributes___user_user_skills_index___comment">Comment</label><input class="form-control" type="text" name="user[user_skills_attributes][__user_user_skills_index__][comment]" id="user_user_skills_attributes___user_user_skills_index___comment" /><a class=" remove_nested_fields_link" data-delete-association-field-name="user[user_skills_attributes][__user_user_skills_index__][_destroy]" data-object-class="user_skill" href="">Remove</a></div></fieldset></script><a class="add_nested_fields_link" data-association-path="user_user_skills" data-object-class="user_skill" href="">Add User skill</a>');
    //     $('.sign_up_page_skillzone').fadeIn(1000);
    //     is_skillzone_added = 1;
    //   }
    // }
  // });
  $(document).on("click","#user_emp_status_employee",function(){
    $.ajax({
      url: '/establishments',
      type: 'GET',
      dataType: "json"
    }).success(function(data){
      generate_establishment(data)
      $('#select_establishment').on('change',function(){
        var establishment_id = $('#select_establishment').val()
        $.ajax({
          url: '/establishment_services',
          type: 'GET',
          data: {'id' : establishment_id},
          dataType: 'json'
        }).success(function(data){
          generate_service(data.establishment_service);
          if ($("body.registrations").length < 0){
            if(!check_salesman_role.call() && $('.delegate_customer_ids').is(':visible')){
              generate_dele_customers(data.delegated_customers);
            }
          }
          else{
            generate_dele_customers(data.delegated_customers);
          }
        })
      });
    })
  });
  $(document).on("click","#user_emp_status_self_employed",function(){
    $('.employee').html('')
    $('.service').html('')
  });

  $("#admin_side_user_establishment").select2();
  $("#admin_side_user_establishment_service").select2();
  $("#admin_side_user_establishment_service").empty();
  $("#user_establishment_id").select2();
  $("#user_establishment_service_id").select2();

  var emp_status = getParameterByName('emp_status');

  if(emp_status == 1){
    $('input[value=1]').prop("checked", true)
  }
  if(emp_status == 2) {
    $('input[value=2]').prop("checked", true)
  }

  function getParameterByName(name, url) {
    if (!url) {
      url = window.location.href;
    }
    name = name.replace(/[\[\]]/g, "\\$&");
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, " "));
}

  $('#admin_side_user_establishment').on('change',function(){
    var establishment_id = $('#admin_side_user_establishment').val()
    if(establishment_id == ""){
      $("#admin_side_user_establishment_service").empty();
    }
    $.ajax({
      url: '/establishment_services',
      type: 'GET',
      data: {'id' : establishment_id},
      dataType: 'json'
    }).success(function(data){
      generate_admin_service(data);
    });
  });

});

function display_image(elem){
  var files = elem.files;
  var image = files[0]
  var reader = new FileReader();
  reader.onload = function(file) {
    image_Height = 100
    image_Width = 100
    var img = new Image();
    img.height = image_Height
    img.width = image_Width
    img.src = file.target.result;
    $('#display_uploaded_signature').html(img);
  }
  reader.readAsDataURL(image);
}

function generate_establishment(data){
  var i;
  var div = document.querySelector('.employee'),
    frag = document.createDocumentFragment(),
    select = document.createElement("select");
  $('.employee').html('<label class="col-sm-12" for="user_esatblishment">Establishment</label>');
  select.options.add( new Option(" ") );
  for(i=0;i<data.length;i++){
    select.options.add( new Option(data[i].name,data[i].id) );
  }
  frag.appendChild(select);
  $(select).attr("id","select_establishment")
  // $(select).attr("class","form-control")
  $(select).attr("name","user[establishment_id]")
  $('.employee').fadeIn();
  div.appendChild(frag);
  // $('.employee').append('</div>')
  $("#select_establishment").select2({placeholder: "Please Select"});
}
function generate_service(data){
  var i;
  var div = document.querySelector('.service'),
    frag = document.createDocumentFragment(),
    select = document.createElement("select");
  $('.service').html('<label class="col-sm-12" for="user_esatblishment">Service</label>');
  for(i=0;i<data.length;i++){
    select.options.add( new Option(data[i].name,data[i].id) );
  }
  frag.appendChild(select);
  $(select).attr("id","select_service")
  $(select).attr("name","user[establishment_service_id]")
  $('.service').fadeIn(1000);
  div.appendChild(frag);
  $("#select_service").select2();
}
function generate_dele_customers(data){
  var $select = $('.delegate_customer_ids');
  var options = $select.data('select2').options.options;
  $select.html('');
  var i;
  for(i=0;i<data.length;i++){
    $select.append('<option value='+ data[i].id+'>'+ data[i].email+'</option>');
  }
}
function generate_admin_service(data){
  var i;
  var div = document.querySelector('.admin_service'),
    frag = document.createDocumentFragment(),
    select = document.createElement("select");
  if(data){
    if(data.length > 0){
      $('.admin_service').html('<label class="col-sm-12 admin_user_establishment" for="admin_user_establishment">Establishment Service</label>');
    }
    if(data.length == 0){
      select.options.add( new Option("Select service".name,"") );
    }
    for(i=0;i<data.length;i++){
      select.options.add( new Option(data[i].name,data[i].id) );
    }
  frag.appendChild(select);
  $(select).attr("id","admin_side_user_establishment_service")
  $(select).attr("name","establishment_service_id")
  $('.admin_service').fadeIn(1000);
  if(div != null)
    div.appendChild(frag);
  $("#admin_side_user_establishment_service").select2();
  }
}

function check_postal_code_submit_form(action){
  var isNewValidationSuccess,isEditValidationSuccess;
  if (action == "new"){
    isNewValidationSuccess = $("#new_establishment").valid();
  }
  else{
    isEditValidationSuccess = $(".edit_establishment").valid();
  }
  if(isNewValidationSuccess === true || isEditValidationSuccess === true){
    submitNewEstablishmentForm(action);
  }
}

function submitNewEstablishmentForm(action){
  var postal_code = $("#establishment_postal_code").val();
  $.ajax({
    url: '/admin/establishment_form_check_postal_code',
    type: 'GET',
    data: {'postal_code' : postal_code},
    dataType: 'json'
  }).success(function(data){
    if(data == true){
      var r = confirm("Warning, you're triying to create an establishment on a geographical perimeter of another Salesman. Do you really wants to continue ?");
      if(r == true){
        if(action == "new"){
          $("#new_establishment").submit();
          }
        else{
          $(".edit_establishment").submit();
        }
      }
    }
    else if(data == false){
      if(action == "new"){
        $("#new_establishment").submit();
        }
      else{
        $(".edit_establishment").submit();
      }
    }
  });
}

function check_postal_code(){
  var isValidationSuccess = $("#new_user").valid();
  if(isValidationSuccess == true){
    submitNewUserForm();
  }
}

function submitNewUserForm(){
  $.ajax({
    url: '/find_delegate_customer_id',
    success: function(data) {
      delegate_customer_id = data[0];
    }
  });
  var flag = false;
  var postal_code = $("#zipcode").val();
  var account_type_data = $(".account-type").select2('data')
  for(i=0;i<account_type_data.length;i++){
    if( account_type_data[i].id==delegate_customer_id){
      flag = true;
    }
  }
  if( postal_code.length > 0  && flag == false) {
    $.ajax({
      url: '/admin/new_user_form_check_postal_code',
      type: 'GET',
      data: {'postal_code' : postal_code},
      dataType: 'json'
    }).success(function(data){
      if(data == true){
        var r = confirm("Warning, you're triying to create a {delegate customer /customer /provider} on a geographical perimeter of another Salesman. Do you really wants to continue ?");
        if(r == true){
          $("#new_user").submit();
        }
      }
      else if(data == false){
        $("#new_user").submit();
      }
    });
  }
  else{
    $("#new_user").submit();
  }
}

function setNotificationToFalse(obj){
  var href = $(obj).attr('href');
  $.ajax({
    url: '/admin/change_notification_value',
    type: 'GET',
    data: {'href' : href},
    dataType: 'json'
  }).success(function(data){
    var val = $(".notification").text();
    $(".notification").text("");
  });
}

//
// Common functions :-
//
// generate new elements
function generate_ele(type, arg){
  // Create element
  switch(type){
    case "button": case "checkbox": case "radio": case "file": case "hidden": case "image": case "password": case "reset": case "submit": case "text": case "color": case "date": case "datetime": case "datetime-local": case "email": case "month": case "number": case "range": case "search": case "tel": case "time": case "url": case "week":
        var ele = document.createElement('input');
        ele.type = type;
        break;
    default:
        var ele = document.createElement(type);
  }

  // Set attributes
  if(typeof arg !== 'undefined'){
    if(type == "select"){
      for (var i = 0; i < arg.value.length; i++) {
        option = document.createElement("OPTION")
        option.setAttribute("value", arg.value[i])
        if(arg.selected == arg.value[i]){
          option.setAttribute("selected", "selected")
        }
        option.appendChild(document.createTextNode(arg.value[i]))
        ele.appendChild(option)
      }
    }
    else{
      ele.value = arg.value || "";
    }
    ele.id = arg.id || "";
    ele.className = arg.class || "";
    ele.htmlFor = arg.htmlfor || ""
    ele.name = arg.name || ""
    if(ele.tagName == "LABEL"){
      ele.appendChild(document.createTextNode(arg.lblText || "label"));
    }
    else if(ele.tagName == "DIV"){
      ele.appendChild(document.createTextNode(arg.innerText || ""));
    }
  }
  return ele
}

// compare array
Array.prototype.compare = function(secondAry){
  return (this.length == secondAry.length) && this.every(function(element, index) {
    return element === secondAry[index];
  });
}
