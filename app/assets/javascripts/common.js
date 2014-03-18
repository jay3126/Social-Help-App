Array.prototype.capitalize=function()
{
  for (i=0;i<this.length;i++){
  	this[i]=this[i].charAt(0).toUpperCase() + this[i].slice(1);
  }
  return this;
}
$(document).ready(function(){
	if($(".profile-modal-link").length > 0 ){
		$(".profile-modal-link").click(function(){
			var userId = $(this).attr("user-id");
			$.ajax({
				type: 'GET',
				url: "/users/user_profile",
				data: {id: userId},
				dataType: 'JSON',
				success: function(response){
					$("#user-details-img").attr('src',response["pic"]);
					delete response["pic"];
					var list = "";
					Object.keys(response).forEach(function (key) { 
					    var dd = response[key]
					    var dt = key.split("_").capitalize().join(" ");
					    var ele = "<dt>" + dt + " : </dt><dd>" + dd + "</dd>";
					   	list = list.concat(ele);
					});
					$("#user-details-list").html(list);
					$("#user-details-modal").modal();
				}
			});
		});
	}
});

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