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
<script src="<c:url value='resources/js/base64js.min.js' />"></script>


<link rel="stylesheet"
	href="<c:url value='resources/css/jquery-ui.css' />">
<script type="text/javascript">
	
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
	
</script>



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



$(document).ready(function(){	
	
	
	 $("#navbar").load('<c:url value="/resources/common/header.jsp" />'); 
	  $("#superAdminSidebar").load('<c:url value="/resources/common/superAdminSidebar.jsp" />'); 
		 $(".isa_success").fadeOut(10000);
	  $("#technicianSidebar").load('<c:url value="/resources/common/technicianSidebar.jsp" />'); 

		// $(".isa_success").fadeOut(10000);
		 getCabinet();
		 $("input").attr("required", "true");
		 $("select").attr("required", "true");
         $("select option:contains('Select')").attr("disabled","disabled");
         $('#photo_1_checkbox').prop('checked', true);
         $('#photo_2_checkbox').prop('checked', true);
    	 $("#photo_1_checkbox").removeAttr("required");                    	 
    	 $("#photo_2_checkbox").removeAttr("required");                    	 
    	 $("#photo_1").attr("disabled","disabled");
    	 $("#photo_2").attr("disabled","disabled");


                 
         $('#photo_1_checkbox').change(function() {       	 
             if(this.checked) {
            	 $("#photo_1").attr("disabled","disabled");
             }
             else
            	 {
            	 $("#photo_1").removeAttr("disabled");                    	 
            	 }        
         });
         
         
         $('#photo_2_checkbox').change(function() {       	 
                 if(this.checked) {
                	 $("#photo_2").attr("disabled","disabled");

                 }
                 else
                	 {
                	 $("#photo_2").removeAttr("disabled");                    	 
                	 }        
             });
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
	 function getCabinet()
	 {
	 	 $.ajax({
	 		 	type:"get",
	 		 	url:"getCabinetData",
	 		 	contentType:'application/json',
	 		 	datatype:"json",
	 		 	data:{"siteid":siteId},
	 		 	success:function(res){
	 		 		
	 		 	console.log(res);
	 	         	jsonData = JSON.parse(res)[0];
	 	         	jsonLen=JSON.parse(res).length;
	 	         	if(JSON.parse(res).length==0)
	 	         		{
		 	         	document.getElementById("siteid").value=siteId;
		 	         	document.getElementById("updatetype").value="New;"+"1";
			 	           $('#photo_1_checkbox').prop('checked', false);
				 	          $('#photo_2_checkbox').prop('checked', false);
				 	         	$("#photo_1").removeAttr("disabled");     
				 	         	$("#photo_2").removeAttr("disabled"); 
			 	 	         	$("#photo_1_div").show();
			 	 	         	$("#photo_2_div").show();
	 	         		}
	 		 		//alert(jsonData.id)	
	 		 		else
	 		 			{
	 		 			$('[data-toggle="tooltip"]').tooltip();
	 	         	document.getElementById("siteid").value=jsonData.siteid.siteid;
	 	         	Unqid = jsonData.id;
	 	         	document.getElementById("cabinetManufacturer").value=jsonData.cabinetManufacturer;
	 	         	document.getElementById("type").value=jsonData.type;
	 	         	document.getElementById("dimensions").value=jsonData.dimensions;
	 	         	document.getElementById("cabinetCondition").value=jsonData.cabinetCondition;
 	 	         	document.getElementById("comments").value=jsonData.comments;
	 	         	document.getElementById("updatetype").value="Existing;"+jsonData.id;
	 	         	document.getElementById("photo_1_text").value=jsonData.Photo_1_Name;
	 	         	document.getElementById("photo_2_text").value=jsonData.Photo_2_Name;

	 	         	
 	 	         	//document.getElementById("photo_1").value='data:image/jpeg;base64,' + base64;
 	 	         	$("#photo_1_div").hide();
 	 	         	$("#photo_2_div").hide();
 	 	         	$("#photo_1_text_div").show();
 	 	         	$("#photo_2_text_div").show();
 	 	         	$("#photo_1_text").attr("disabled","disabled");
 	 	     	    $("#photo_2_text").attr("disabled","disabled");

	 	         	
	 	         	//document.getElementById("ItemPreview").src = "data:image/png;base64," + jsonData.photo_1;
	 	         	
 base64_1 = base64js.fromByteArray(jsonData.photo_1);
 base64_2 = base64js.fromByteArray(jsonData.photo_2);

//console.log(base64);
//$("#ItemPreview").attr('src', 'data:image/jpeg;base64,' + base64);


//image_popup(base64);


	 		 			}
	 		 	},
	 		 	error:function()
	 		 	{
	 		 		console.log("Error");	
	 		 	}
	 	 });
	 }	
	 

function submit_logic()
{
	var updatetype= $('#updatetype').val();
	$('#updatetype').val(" ");
	filestate = ";"+$("input[name='photo_1_text_div_radio']:checked").val()+";"+$("input[name='photo_2_text_div_radio']:checked").val();
	if(jsonLen==0)
		{
		$('#updatetype').val("New;1"+filestate);		
		}
	else
		{
		$('#updatetype').val("Existing;"+Unqid+filestate);		
		}
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
		image_popup("Photo_1",base64_1);
		}
	else
		{
		image_popup("Photo_2",base64_2);
		}
}



function outmouse(obj)
{
	swal.close();
}

function upload_files(id)
{
	var Value = $("input[name='"+id.name+"']:checked").val();
	var name = $("input[name='"+id.name+"']:checked").val();	
	//split text field file_
	 //$(#id)).show();
    if(Value=="Yes"){ 
    	switch(id.name) {
    	  case "photo_1_text_div_radio":
    	    $("#photo_1_div").show();
   	        $("#photo_1").removeAttr("disabled"); 
         	$("#photo_1_text_div").hide();
    	    break;   
    	    
    	  case "photo_2_text_div_radio":     	    
     	    $("#photo_2").removeAttr("disabled"); 
           	$("#photo_2_text_div").hide();
           	$("#photo_2_div").show();
      	    break;     

    	  default:
    	    // code block
    	}
    	}
    
    if(Value=="No"){ 
    	switch(id.name) {    	   
    	 case "photo_1_text_div_radio":
      	    $("#photo_1_div").hide();
     	    $("#photo_1").removeAttr("disabled"); 
           	$("#photo_1_text_div").show();
      	    break;    
      	    
    	  case "photo_2_text_div_radio":
        	    $("#photo_2_div").hide();
       	        $("#photo_2").removeAttr("disabled"); 
             	$("#photo_2_text_div").show();
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
<!-- 			<br> <br> -->

			<h3 class="text-center">Add Cabinet</h3>
			<span id="msg" style="color: red; font-size: 12px;">*All
				Fields are Mandatory*</span><br>
				
			<form:form action="saveCabinet" method="post"
				modelAttribute="Site_Cabinet" enctype="multipart/form-data">
				<div class="login-form">
							<input type="hidden" id="updatetype" name="updatetype"/>
				

					<br><label for="Site ID" class="placeholder"> <b>Site ID</b></label>
					<form:input id="siteid" path="siteid.siteid" readonly="true"
						class="form-control input-full filled"  />
					<br> <label for="cabinetManufacturer" class="placeholder"><b>Cabinet
						Manufacturer</b></label>
					<form:select id="cabinetManufacturer" path="cabinetManufacturer"
						name="cabinetManufacturer" class="form-control input-full filled">
						<form:option value="">Select</form:option>
						<form:options items="${CabinetManufacturer}"></form:options>
					</form:select>
					<br> <label for="type" class="placeholder"><b>Type</b></label>
					<form:select id="type" path="type" name="type"
						class="form-control input-full filled">
						<form:option value="">Select</form:option>
						<form:options items="${CabinetType}"></form:options>
					</form:select>

					<br> <label for="dimensions" class="placeholder"><b>Dimensions</b></label>
					<form:input id="dimensions" path="dimensions" name="dimensions" onkeypress="return isNumber(event)"
						class="form-control input-full filled" />

					<br> <label for="cabinetCondition" class="placeholder"><b>Cabinet
						Condition</b></label>
					<form:select id="cabinetCondition" path="cabinetCondition"
						name="cabinetCondition" class="form-control input-full filled">
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

					<br> <label for="comments" class="placeholder"><b>Observation/Comments</b></label>
					<form:input id="comments" path="comments" name="comments" onkeypress="return isCharacters(event)" 
						class="form-control input-full filled" />
					
					<div id="photo_1_div">
					<br>
					 <label for="Photo_1" class="placeholder" style="float:left" id="picture_1"  ><b>photo 1</b></label>
					<%--                <form:input id="tag_photo" path="tag_photo"  name="tag_photo"  class="form-control input-full filled"  /> --%>
					<input type="file" id="photo_1" name="tag_photo" 
						class="form-control input-full filled" accept="image/*" 
						onchange="ValidateFileUpload(this.id)" />
												<div class="row mt-1">	<div class="col-md-7">
						<!--  <label for="Radio_1" class="placeholder" ><b>Do you want to upload Image</b></label><br></div><div class="col-md-3">Yes				
						  <input type="radio"  value="Yes"  name="photo_1_text_div_radio_update" onclick="upload_files(this)" checked/></div><div class="col-md-2">No<input type="radio"  onclick="upload_files(this)" value="No"  name="photo_1_text_div_radio_update" />-->
						</div>
						</div>
						</div>
						 

						
						
				
											
					<div id="photo_1_text_div">
					<br>
					 <label for="Photo_1" class="placeholder" style="float:left" ><b>photo 1</b></label><br>
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
						</div>
						</div>
						
<br>
						 <div id="photo_2_div">
					<label for="photo_2" class="placeholder" id="picture_2"><b>photo 2</b></label>
					<input type="file" id="photo_2" name="tag_photo"
						onchange="ValidateFileUpload(this.id)" accept="image/*"
						class="form-control input-full filled" /> 
											<!--  	<div class="row mt-1">	<div class="col-md-7">
						<label for="Radio_2" class="placeholder" ><b>Do you want to upload Image</b></label><br></div><div class="col-md-3">Yes				
						  <input type="radio"  value="Yes" onclick="upload_files(this)" name="photo_2_text_div_radio_update"  checked/></div><div class="col-md-2">No<input type="radio" value="No" onclick="upload_files(this)" name="photo_2_text_div_radio_update" />
						</div>-->
						</div>
						</div>
<div id="photo_2_text_div">
					 <label for="Photo_2" class="placeholder" style="float:left" ><b>photo 2</b></label><br>
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
						<label for="Radio_2" class="placeholder" ><b>Do you want to upload Image</b></label><br></div><div class="col-md-3">Yes				
						  <input type="radio"  value="Yes" onclick="upload_files(this)" name="photo_2_text_div_radio"  /></div><div class="col-md-2">No<input type="radio" value="No" onclick="upload_files(this)" name="photo_2_text_div_radio" checked/>
						</div>
						</div>	

<!--  <img id="ItemPreview">-->
						


<div class="form-action">
					<!-- <a href="home" id="show-signin" class="btn btn-rounded btn-login mr-3" style="background-color: #E4002B;color: white;">Cancel</a>-->
					<input type="submit"  name="submit" value="Save" class="btn btn-rounded btn-login" onclick="submit_logic()" style="background-color: #E4002B;color: white;">
					<input type="submit"  name="submit" value="Save & Continue" class="btn btn-rounded btn-login" onclick="submit_logic()" style="background-color: #012169;color: white;">
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
		src="<c:url value='resources/assets/js/plugin/jquery.sparkline/jquery.sparkline.min.js' />">
		</script>
		
<!--  <script src="<c:url value='resources/assets/js/plugin/sweetalert/sweetalert.min.js' />"></script> --> 


<script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>

</body>

</html>