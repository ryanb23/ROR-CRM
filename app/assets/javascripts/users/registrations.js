$(function(){
	if($("body.registrations").length > 0){
		/*
			Registration page hide speciality page base on condition of title
			title = Dr| Pr then show speciality drop list
			therwise hide speciality drop list
		*/
		var specialityLabel = $(".speciality-drop-list label").clone()
		var specialityDropList = $(".speciality-drop-list select").clone()
		$("#user_speciality_ids").select2({placeholder: I18n.please_select});

		$("#user_title_1, #user_title_2").on("change",function(){
			console.log("speciality")
			$("#user_speciality_ids").select2('destroy')
			$(".speciality-drop-list").html(specialityLabel).append(specialityDropList);
			$("#user_speciality_ids").select2({placeholder: "Please Select"});
		});

		$("#user_title_3, #user_title_4").on("change",function(){
			$("#user_speciality_ids").select2('destroy')
			$(".speciality-drop-list").html("")
		});

		/*
			Hide field based on role on registration
			restrictedRoleAry : Restricted role who have no need to feel up hideFieldIdList field.
		*/
		var restrictedRoleAry = ["Customer", "Patient", "Physician", "Technical Service Provider"];
		var hideFieldIdList = ["user_address", "user_street", "user_city", "user_postal_code", "user_country"];
		var fieldTemplate = $("#role-base-field").clone() // Copy template before bind select2 plugin for country
		// $("#user_country").select2();
		checkedRestrictedRoleAry = [];
		$(".account-type").select2();
		var account_type_data = $(".account-type").select2('data');
		 $('.account-type').on('change', function() {
		 	for(i=0;i<account_type_data.length;i++){
		 		if((account_type_data[i].id == 69 ||account_type_data[i].id == 78)&& $.inArray(this.dataset.value, restrictedRoleAry) >= 0){
		 			console.log("inside country")
		 			checkedRestrictedRoleAry.push(this.dataset.value);
					hideFieldIdList.forEach(function(value){
					$("#"+value).parents(".form-group").fadeOut("1000", function(){
						if(value === "user_country") $("#user_country").select2('destroy');
						$(this).empty()
					})
				})
		 		}
		 		else if(!(account_type_data[i].id == 69 ||account_type_data[i].id == 78)&& $.inArray(this.dataset.value, restrictedRoleAry) >= 0){
		 			var index = checkedRestrictedRoleAry.indexOf(this.dataset.value);
				checkedRestrictedRoleAry.splice(index, 1);
				if(checkedRestrictedRoleAry.length <= 0){
					$("#role-base-field").html(fieldTemplate.html()).hide().fadeIn(1000)
					$("#user_country").select2();
				}
		 		}
		 	}
		 });
		// $(".sign_up_page_role :checkbox").on("change", function(){
		// 	if(this.checked && $.inArray(this.dataset.value, restrictedRoleAry) >= 0){
		// 		checkedRestrictedRoleAry.push(this.dataset.value);
		// 		hideFieldIdList.forEach(function(value){
		// 			$("#"+value).parents(".form-group").fadeOut("1000", function(){
		// 				if(value === "user_country") $("#user_country").select2('destroy');
		// 				$(this).empty()
		// 			})
		// 		})
		// 	}
		// 	else if(!this.checked && $.inArray(this.dataset.value, restrictedRoleAry) >= 0){
		// 		var index = checkedRestrictedRoleAry.indexOf(this.dataset.value);
		// 		checkedRestrictedRoleAry.splice(index, 1);
		// 		if(checkedRestrictedRoleAry.length <= 0){
		// 			$("#role-base-field").html(fieldTemplate.html()).hide().fadeIn(1000)
		// 			$("#user_country").select2();
		// 		}
		// 	}
		// })
	
	} // If condition end

})

$(document).on("turbolinks:load", function(){
	var updatedUserSkillEle = generate_ele("hidden")
	var updatedSkillValueAry;
	var skillFileFieldChange = [];

	var updatedUserInsuranceEle = generate_ele("hidden")
	var updatedUserInsuranceFileEle = generate_ele("hidden")
	var updatedInsuranceValueAry;
	var insuranceFileFieldChange = [];
	var insuranceFileFieldParentChange = [];
	
	var updatedUserFieldEle = generate_ele("hidden")
	var updatedUserValueAry;
		
	$('.delegate_customer_ids').select2();
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

	// To keep track of skill's | insurance's file upload changes
	$(document).on("change", "input[type='file']", function(){
		if($(this).hasClass("skill-upload-btn"))
			skillFileFieldChange.push($(this).data('id'))
		else
			insuranceFileFieldChange.push($(this).data('id'))
			insuranceFileFieldParentChange.push($(this).data('parent-id'))
	})

	$(document).on("fields_removing.nested_form_fields", function(event, param){
		insuranceFileFieldChange.push(event.delegateTarget.activeElement.dataset.id)
		insuranceFileFieldParentChange.push(event.delegateTarget.activeElement.dataset.parentId)
	})
	// $(document).on("click", ".ins-file-remove-link", function(){
		
	// })

	$("form.edit_user_profile").submit(function(){
		// Check for value update in existing skills | insurance
		updatedSkillValueAry = [];
		updatedInsuranceValueAry = [];
		updatedUserValueAry = [];
		for(var i=0;i<$(".val:visible").length;i++){
			if(Array.isArray($(".val:visible").eq(i).val())){
				if(!$(".val:visible").eq(i).val().compare($(".val:visible").eq(i).data("val")))
					updatedUserValueAry.push($(".val:visible").eq(i).data("id"))
			}
			else{
		  	if($(".val:visible").eq(i).val()  != $(".val:visible").eq(i).data("val")){
		    	if($(".val:visible").eq(i).hasClass('ins-field'))
		    		updatedInsuranceValueAry.push($(".val:visible").eq(i).data("id"))
		    	else if($(".val:visible").eq(i).hasClass('user-field'))
		    		updatedUserValueAry.push($(".val:visible").eq(i).data("id"))
		    	else
			    	updatedSkillValueAry.push($(".val:visible").eq(i).data("id"))
		    }	
			}
	  }

	  // Set updated record to hidden field and send in form
	  // Skill
	  updatedSkillValueAry = updatedSkillValueAry.concat(skillFileFieldChange);
		$(updatedUserSkillEle).attr({name: "skill_updates_ids", value: updatedSkillValueAry});
	  
	  // Insurance
	  updatedInsuranceValueAry = updatedInsuranceValueAry.concat(insuranceFileFieldParentChange);
		$(updatedUserInsuranceEle).attr({name: "insurance_updates_ids", value: updatedInsuranceValueAry});
		$(updatedUserInsuranceFileEle).attr({name: "insurance_file_updates_ids", value: insuranceFileFieldChange});

		// User
		$(updatedUserFieldEle).attr({name: "user_updates_ids", value: updatedUserValueAry})
		
		$(this).find("#updates-div").html("");
		$(this).find("#updates-div")
			.append(updatedUserSkillEle)
			.append(updatedUserInsuranceEle)
			.append(updatedUserInsuranceFileEle)
			.append(updatedUserFieldEle);
	})
})