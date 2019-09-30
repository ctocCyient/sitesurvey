<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html >
<html lang="en">

<head>

<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="icon" href="<c:url value='resources/assets/img/icon.ico' />"
	type="image/x-icon" />

<title>Site Survey</title>
<meta content='width=device-width, initial-scale=1.0, shrink-to-fit=no'
	name='viewport' />
<script src="<c:url value='resources/js/jquery.min.js' />"></script>

<script src="<c:url value='resources/js/jquery-ui.min.js' />"></script>
<script src="<c:url value='resources/js/validations.js' />"></script>

<link rel="stylesheet"
	href="<c:url value='resources/css/jquery-ui.css' />">

<script
	src="<c:url value='resources/assets/js/plugin/webfont/webfont.min.js' />"></script>
<link rel="stylesheet"
	href="<c:url value='resources/assets/css/bootstrap.min.css' />">
<link rel="stylesheet"
	href="<c:url value='resources/assets/css/azzara.min.css' />">

<script type="text/javascript">

WebFont.load({
	google: {"families":["Open+Sans:300,400,600,700"]},
	custom: {"families":["Flaticon", "Font Awesome 5 Solid", "Font Awesome 5 Regular", "Font Awesome 5 Brands"], urls: ["<c:url value='resources/assets/css/fonts.css' />"]},
	active: function() {
		sessionStorage.fonts = true;
	}
});
if(sessionStorage.getItem("username")==null)
	{
	//window.location.href = "/sitesurvey/";
	//alert(sessionStorage.getItem("username"));
	   url = "/sitesurvey/";
	      $( location ).attr("href", url);
	}
   else
	   {
	   role=sessionStorage.getItem("role");
		siteId=sessionStorage.getItem("siteId");
		ticketId=sessionStorage.getItem("ticketId");
	   }


$(document).ready(function(){	
	 $("#navbar").load('<c:url value="/resources/common/header.jsp" />'); 
	  $("#superAdminSidebar").load('<c:url value="/resources/common/superAdminSidebar.jsp" />'); 
	  $("#technicianSidebar").load('<c:url value="/resources/common/technicianSidebar.jsp" />'); 

	//  getRegions();
		//getSiteId();
		//$("#type,#username,#emailId,#pwd,#cpwd,#mobileNum,#region").attr('required', '');  
		 $(".isa_success").fadeOut(10000);
		 getBB();
		 $("input").attr("required", "true");
		 $("select").attr("required", "true");
         $("select option:contains('Select')").attr("disabled","disabled");
         $('#photo_1_checkbox').prop('checked', true);
         $('#photo_2_checkbox').prop('checked', true);
         $('#photo_3_checkbox').prop('checked', true);
    	 $("#tag_photo1").removeAttr("required");                    	 
    	 $("#tag_photo2").removeAttr("required");    
    	 $("#tag_photo3").removeAttr("required");                    	 
    	 /*$("#tag_photo1").attr("disabled","disabled");
    	 $("#tag_photo2").attr("disabled","disabled");
    	 $("#tag_photo3").attr("disabled","disabled");*/	 
});

function populateDropdown(data,id)
{
	var	catOptions="<option value=''>Select</option>";
 	for (i in data) {
 		
   	 	 catOptions += "<option>" + data[i] + "</option>";
 		}
 		document.getElementById(id).innerHTML = catOptions;
 		 $("select option[value='']").attr('disabled','disabled');
}



jsonLen = 0;
Unqid = 0;
base64_1=0;
base64_2=0;
base64_3=0;
function getBB()
{
	 $.ajax({
		 	type:"get",
		 	url:"getBBData",
		 	contentType:'application/json',
		 	datatype:"json",
		 	data:{"siteid":siteId},
		 	success:function(res){
	         	jsonData = JSON.parse(res)[0];
 	         	jsonLen=JSON.parse(res).length;
	         	if(JSON.parse(res).length==0)
	         		{
		         	document.getElementById("siteid").value=siteId;
		         	//document.getElementById("id").value=0;

		         	//$("#photo_1_text_div_radio").prop("checked", true);
		         	$('input[name="photo_1_text_div_radio"][value="Yes"]').attr('checked', true); 
		         	$('input[name="photo_2_text_div_radio"][value="Yes"]').attr('checked', true);
		         	$('input[name="photo_3_text_div_radio"][value="Yes"]').attr('checked', true);
		         	//$("#photo_2_text_div_radio").prop("checked", true);
		         	//$("#photo_3_text_div_radio").prop("checked", true);
 				//	$("input").attr("required", "false");
	         	    $("#photo_1_div").show();
	 	         	$("#photo_2_div").show();
	 	         	$("#photo_3_div").show();
	 	         	$("#photo_1_text_div").hide();
	 	         	$("#photo_2_text_div").hide();
	 	         	$("#photo_3_text_div").hide();
	 	         	
	 	         	
   
	         		}
		 		//alert(jsonData.id)	
		 		else
		 			{
	 	         	Unqid = jsonData.id;
	         	document.getElementById("siteid").value=jsonData.siteid.siteid;
	         	document.getElementById("id").value=jsonData.id;
	         	document.getElementById("Manufacturer").value=jsonData.Manufacturer;
	         	document.getElementById("type").value=jsonData.type;
	         	document.getElementById("manufacturedDate").value=jsonData.manufacturedDate;
	         	document.getElementById("number_of_working_Module_rating").value=jsonData.number_of_working_Module_rating;
	         	document.getElementById("capacity").value=jsonData.capacity;
	         	document.getElementById("overallCondition").value=jsonData.overallCondition;
	         	document.getElementById("number_of_batteries").value=jsonData.number_of_batteries;
				document.getElementById("tag_observed").value=jsonData.tag_observed;
	         	document.getElementById("comments").value=jsonData.comments;
	         	document.getElementById("photo_1_text").value=jsonData.tag_photo_Name;
 	         	document.getElementById("photo_2_text").value=jsonData.tag_photo1_Name;
 	         	document.getElementById("photo_3_text").value=jsonData.tag_photo2_Name;

	         	
	         	
	         	    $("#photo_1_div").hide();
	 	         	$("#photo_2_div").hide();
	 	         	$("#photo_3_div").hide();
	 	         	$("#photo_1_text_div").show();
	 	         	$("#photo_2_text_div").show();
	 	         	$("#photo_3_text_div").show();
	 	         	 $("#photo_1_text").attr("disabled","disabled");
	 	     	    $("#photo_2_text").attr("disabled","disabled");
	 	     	    $("#photo_3_text").attr("disabled","disabled"); 
	 	         	
	 	     	  base64_1 = base64js.fromByteArray(jsonData.tag_photo);
	 	     	  base64_2 = base64js.fromByteArray(jsonData.tag_photo1);	         	
	 	     	  base64_3 = base64js.fromByteArray(jsonData.tag_photo_2);	         	
	         	
	         	
		 			}
		 	},
		 	error:function()
		 	{
		 		console.log("Error");	
		 	}
	 });
}	




function image_popup(phototext,base64)
{ 
    var htmlstring = "<img id='ItemPreview' 'src=data:image/png;base64,"+base64+"' width='104' height='142'>";
    //$("#ItemPreview").attr('src', 'data:image/jpeg;base64,' + base64);
	Swal.fire({
		  title: "<i>"+phototext+"</i>", 
		  html: "<center><table border='0'><tr><td><img id='ItemPreview' src='data:image/jpeg;base64,"+base64+"' width='300' height='300'></td></tr></table><center>",  
		  timer: 1000,
		});
}

function photohover(obj)
{
	if(obj.id=="picture_1")
		{
		image_popup("Tag photo",base64_1);
		}
	else if(obj.id=="picture_2")
		{
		image_popup("Battery Bank Photo 1",base64_2);
		}
	else if(obj.id=="picture_3")
	{
	image_popup("Battery Bank Photo 2",base64_3);
	}
}

function upload_files(id)
{
	var Value = $("input[name='"+id.name+"']:checked").val();
	var name = $("input[name='"+id.name+"']:checked").val();	
    if(Value=="Yes"){ 
    	switch(id.name) {
    	  case "photo_1_text_div_radio":
    	    $("#photo_1_div").show();
         	$("#photo_1_text_div").hide();
    	    break;   
    	    
    	  case "photo_2_text_div_radio":     	    
           	$("#photo_2_text_div").hide();
           	$("#photo_2_div").show();
      	    break;     
      	    
    	  case "photo_3_text_div_radio":     	    
             	$("#photo_3_text_div").hide();
             	$("#photo_3_div").show();
        	    break;     
      	    

    	  default:
    	    // code block
    	}
    	}
    
    if(Value=="No"){ 
    	switch(id.name) {    	   
    	 case "photo_1_text_div_radio":
      	    $("#photo_1_div").hide();
      	  $("#photo_1_text").attr("disabled","disabled");
    	   
           	$("#photo_1_text_div").show();
      	    break;    
      	    
    	  case "photo_2_text_div_radio":
        	    $("#photo_2_div").hide();
        	    $("#photo_2_text").attr("disabled","disabled");
             	$("#photo_2_text_div").show();
        	    break; 
        	    
    	  case "photo_3_text_div_radio":
      	    $("#photo_3_div").hide();
           	$("#photo_3_text_div").show();
    	    $("#photo_3_text").attr("disabled","disabled");

      	    break; 
        	    
        	    
    	  default:
    	    // code block
    	}
    	}
	}

	 
</script>
<style>
.fa-bars, .fa-ellipsis-v {
	color: #fff !important;
}

label {
	color: #495057 !important;
	font-size: 13px !important;
}
</style>
<body class="login">

	<div class="main-header" style="background-color: #00B1BF;">
		<!-- Logo Header -->
		<div class="logo-header">

			<a href="home" class="logo"> <img
				src="<c:url value='resources/assets/img/logo.png' />"
				alt="navbar brand" class="navbar-brand">
			</a>
			<button class="navbar-toggler sidenav-toggler ml-auto" type="button"
				data-toggle="collapse" data-target="collapse" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"> <i class="fa fa-bars"></i>
				</span>
			</button>
			<button class="topbar-toggler more">
				<i class="fa fa-ellipsis-v"></i>
			</button>
			<div class="navbar-minimize">
				<button class="btn btn-minimize btn-rounded">
					<i class="fa fa-bars"></i>
				</button>
			</div>
		</div>
		<!-- End Logo Header -->

		<!-- Navbar Header -->
		<div id="navbar"></div>
		<!-- End Navbar -->
	</div>

	<!-- Sidebar -->
	<div id="technicianSidebar"></div>
	<!-- End Sidebar -->

	<div class="wrapper wrapper-login">
		<div class="container container-login animated fadeIn">
<!-- 			<div align="center"> -->
<%-- 				<span class="isa_success" style="color: #35B234; font-size: 20px">${status}</span> --%>
<!-- 			</div> -->
<!-- 			<br> -->
<!-- 			<br> -->

			<h3 class="text-center">Add Battery Bank</h3>
			<span id="msg" style="color: red; font-size: 12px;">*All
				Fields are Mandatory*</span><br>
			<br>
			<form:form action="saveBB" method="post"
				modelAttribute="Site_Battery_Bank" enctype="multipart/form-data">
				<div class="login-form">

				<form:input type="hidden" path="id" id="id"/>
					<br> <label for="Site ID" class="placeholder"><b>Site ID</b></label>
					<form:input id="siteid" path="siteid.siteid"
						class="form-control input-full filled" readonly="true"/>
					<br> <label for="Manufacturer" class="placeholder"><b>Manufacturer</b></label>
					<form:select id="Manufacturer" path="Manufacturer"
						name="Manufacturer" class="form-control input-full filled">
						<form:option value="">Select</form:option>
						<form:options items="${BBManufacturer}"></form:options>
					</form:select>
					<br> <label for="type" class="placeholder"><b>Type</b></label>
					<form:select id="type" path="type" name="type"
						class="form-control input-full filled">
						<form:option value="">Select</form:option>
						<form:options items="${BBType}"></form:options>
					</form:select>



					<br> <label for="date" class="placeholder"><b>Date of
						Manufacturer/Installation</b></label> 
					<form:input type="date" id="manufacturedDate"
						path="manufacturedDate" class="form-control input-full filled" />
					<br> <label for="number_of_batteries" class="placeholder"><b>Number_of_batteries</b></label>
					<form:input id="number_of_batteries" path="number_of_batteries" onkeypress="return isNumber(event)"
						name="number_of_batteries" class="form-control input-full filled" />
					<br> <label for="number_of_working_Module_rating"
						class="placeholder"><b>Number of Working modules available</b></label>
					<form:input id="number_of_working_Module_rating" onkeypress="return isNumber(event)"
						path="number_of_working_Module_rating"
						name="number_of_working_Module_rating"
						class="form-control input-full filled" />
					<br> <label for="capacity" class="placeholder"><b>Capacity</b></label>
					<form:input id="capacity" path="capacity" name="capacity" onkeypress="return isNumber(event)"
						class="form-control input-full filled" />
					<br> <label for="overallCondition" class="placeholder"><b>Overall
						Condition of Battery Bank Equipment</b></label>


					<form:select id="overallCondition" path="overallCondition"
						name="overallCondition" class="form-control input-full filled">
						<form:option value="">Select</form:option>
						<form:option value="Not assessed">Not assessed </form:option>
						<form:option
							value="very poor- Broken batteries, liquid / gel leackage,building out">very poor- Broken batteries, liquid / gel leackage,building out</form:option>
						<form:option value="Poor - No breakages but bulging out">Poor - No breakages but bulging out</form:option>
						<form:option value="Fair - Only sulfation on terminals">Fair - Only sulfation on terminals</form:option>
						<form:option
							value="Good - No issues and locks to be in good condition">Good - No issues and locks to be in good condition</form:option>
						<form:option value="Very good - Looks almost new">Very good - Looks almost new</form:option>
						<form:option value="Not applicable">Not applicable</form:option>
					</form:select>
					<br> <label for="tag_observed" class="placeholder"><b>Tag_observed</b></label>
					<form:select id="tag_observed" path="tag_observed"
						name="tag_observed" class="form-control input-full filled">
						<form:option value="">Select</form:option>
						<form:option value="Yes">Yes</form:option>
						<form:option value="No">No</form:option>

					</form:select>
					
					<br> <label for="comments" class="placeholder"><b>Observation/Comments</b></label>
					<form:input id="comments" path="comments" name="comments" onkeypress="return isCharacters(event)"  
						class="form-control input-full filled" />
					<br> 
					<div id="photo_1_div">
					<label for="tag_photo1" class="placeholder"><b>Tag
						photo</b></label>
					<input type="file" id="tag_photo1"  name="photos" onchange="ValidateFileUpload(this.id)" accept="image/*"
						class="form-control input-full filled" /></div>
																		
						
						
											<div id="photo_1_text_div">
					 <label for="Photo_1" class="placeholder" style="float:left" ><b>Tag
						photo</b></label><br>
					 					<div class="row mt-1">				
					 
					 <div class="col-md-9">
					<input type="text" id="photo_1_text" 
						class="form-control input-full filled" 
						 /></div>
						 <div class="col-md-3">
										<input class="btn btn-info" type="button" id="picture_1" onclick="photohover(this);" value="View"/>

						</div>
						</div>

						</div>
						<div class="row mt-1">	<div class="col-md-7">
						<label for="Radio_1" class="placeholder" ><b>Do you want to upload Image</b></label><br></div><div class="col-md-3">Yes				
						  <input type="radio"  value="Yes" id="defaultChecked" name="photo_1_text_div_radio" onclick="upload_files(this)" /></div><div class="col-md-2">No<input type="radio" onclick="upload_files(this)" value="No"  name="photo_1_text_div_radio" checked/>
						<br>
						</div>
						</div>
<br>
					<div id="photo_2_div">
					
					<label for="tag_photo1" class="placeholder"><b>Battery Bank Photo 1</b></label>
					<input type="file" id="tag_photo2"  name="photos" onchange="ValidateFileUpload(this.id)" accept="image/*"
						class="form-control input-full filled" /> 
						</div>
																		
						
						
											<div id="photo_2_text_div">
					 <label for="Photo_2" class="placeholder" style="float:left" ><b>Battery Bank Photo 1</b></label><br>
					 					<div class="row mt-1">				
					 
					 <div class="col-md-9">
					<input type="text" id="photo_2_text" 
						class="form-control input-full filled" 
						 /></div>
						 <div class="col-md-3">
										<input class="btn btn-info" type="button" id="picture_2" onclick="photohover(this);" value="View"/>

						</div>
						</div>

						</div>
						<div class="row mt-1">	<div class="col-md-7">
						<label for="Radio_1" class="placeholder" ><b>Do you want to upload Image</b></label><br></div><div class="col-md-3">Yes				
						  <input type="radio"  value="Yes" id="defaultChecked" name="photo_2_text_div_radio" onclick="upload_files(this)" /></div><div class="col-md-2">No<input type="radio" onclick="upload_files(this)" value="No"  name="photo_2_text_div_radio" checked/>
						</div>
						</div>
						
						
						

											<div id="photo_3_div">
											<br>
											<label for="tag_photo_2" class="placeholder"><b>Battery Bank Photo 2</b></label>
					<input type="file" id="tag_photo3"  name="photos" onchange="ValidateFileUpload(this.id)" accept="image/*"
						class="form-control input-full filled" /> 
						
						
						
																		
						</div>
						
						
											<div id="photo_3_text_div">
					<br>
					 <label for="Photo_3" class="placeholder" style="float:left" ><b>Battery Bank Photo 2</b></label><br>
					 					<div class="row mt-1">				
					 
					 <div class="col-md-9">
					<input type="text" id="photo_3_text" 
						class="form-control input-full filled" 
						 /></div>
						 <div class="col-md-3">
										<input class="btn btn-info" type="button" id="picture_3" onclick="photohover(this);" value="View"/>

						</div>
						</div>

						</div>
						<div class="row mt-1">	<div class="col-md-7">
						<label for="Radio_1" class="placeholder" ><b>Do you want to upload Image</b></label><br></div><div class="col-md-3">Yes				
						  <input type="radio"  value="Yes" id="defaultChecked" name="photo_3_text_div_radio" onclick="upload_files(this)" /></div><div class="col-md-2">No<input type="radio" onclick="upload_files(this)" value="No"  name="photo_3_text_div_radio" checked/>
						</div>
						</div>




<div class="form-action">
					<!-- <a href="home" id="show-signin" class="btn btn-rounded btn-login mr-3" style="background-color: #E4002B;color: white;">Cancel</a>-->
					<input type="submit"  name="submit" value="Save" class="btn btn-rounded btn-login"  style="background-color: #E4002B;color: white;">
					<input type="submit"  name="submit" value="Save & Continue" class="btn btn-rounded btn-login"  style="background-color: #012169;color: white;">
				</div>
				</div>
			</form:form>

		</div>
	</div>
	<script
		src="<c:url value='resources/assets/js/core/jquery.3.2.1.min.js' />"></script>
	<script
		src="<c:url value='resources//assets/js/plugin/jquery-ui-1.12.1.custom/jquery-ui.min.js' />"></script>
	<script src="<c:url value='resources/assets/js/core/popper.min.js' />"></script>
	<script src="<c:url value='resources/assets/css/bootstrap.min.css' />"></script>
	<script src="<c:url value='resources/assets/js/ready.js' />"></script>

	<!--   Core JS Files   -->



	<script
		src="<c:url value='resources/assets/js/core/jquery.3.2.1.min.js' />"></script>
	<script src="<c:url value='resources/assets/js/core/popper.min.js' />"></script>
	<script
		src="<c:url value='resources/assets/js/core/bootstrap.min.js' />"></script>

	<!-- jQuery UI -->


	<script
		src="<c:url value='resources/assets/js/plugin/jquery-ui-1.12.1.custom/jquery-ui.min.js' />"></script>
	<script
		src="<c:url value='resources/assets/js/plugin/jquery-ui-touch-punch/jquery.ui.touch-punch.min.js' />"></script>


	<!-- jQuery Scrollbar -->
	<script
		src="<c:url value='resources/assets/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js' />"></script>


	<!-- jQuery Sparkline -->

	<script
		src="<c:url value='resources/assets/js/plugin/jquery.sparkline/jquery.sparkline.min.js' />"></script>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
<script src="<c:url value='resources/js/base64js.min.js' />"></script>


</body>

</html>