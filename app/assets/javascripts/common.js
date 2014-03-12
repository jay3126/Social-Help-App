function cascadeForm(value){
	resetAll();
	if(value == "Corporate"){
		$("#company-fields").removeClass("hide");
		$("#company-ngo-common").removeClass("hide");
	}else if(value == "NGO"){
		$("#ngo-details").removeClass("hide");
		$("#company-ngo-common").removeClass("hide");
	}else if(value == "Socialist" || value == "Donor"){
		$("#individual-details").removeClass("hide")
	}
}

function resetAll(){
	if(!$("#company-fields").hasClass("hide")){
		$("#company-fields").addClass("hide");
	}
	if(!$("#individual-details").hasClass("hide")){
		$("#individual-details").addClass("hide");
	}
	if(!$("#ngo-details").hasClass("hide")){
		$("#ngo-details").addClass("hide");
	}
	if(!$("#company-ngo-common").hasClass("hide")){
		$("#company-ngo-common").addClass("hide");
	}
}

function submitUserForm(){
	var role = $("#user_role").val();
	if(role == '' || role == undefined){
		alert("Please select a role");
	}else{
		$("#user_form").submit();
	}
	return false;
}

function isNumber(evt) {
		evt = (evt) ? evt : window.event;
		var charCode = (evt.which) ? evt.which : evt.keyCode;
		if (charCode > 31 && (charCode < 48 || charCode > 57)) {
				return false;
		}
		return true;
}