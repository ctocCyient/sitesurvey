<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html >
<html lang="en">

<head>

	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="icon" href="<c:url value='resources/assets/img/icon.ico' />" type="image/x-icon"/>

<title>Site Survey</title>
	<meta content='width=device-width, initial-scale=1.0, shrink-to-fit=no' name='viewport' />
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
				
			   }
		


</script>

<script src="<c:url value='resources/js/jquery.min.js' />"></script>
	
	<script src="<c:url value='resources/js/jquery-ui.min.js' />"></script>
	<script src="<c:url value='resources/js/validations.js' />"></script>
	
	<link rel="stylesheet" href="<c:url value='resources/css/jquery-ui.css' />">	
		

     
<script src="<c:url value='resources/assets/js/plugin/webfont/webfont.min.js' />"></script>
<link rel="stylesheet" href="<c:url value='resources/assets/css/bootstrap.min.css' />">
	<link rel="stylesheet" href="<c:url value='resources/assets/css/azzara.min.css' />">
  <script src="<c:url value='resources/js/base64js.min.js' />"></script>
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
	  $("#technicianSidebar").load('<c:url value="/resources/common/technicianSidebar.jsp" />'); 
	  $("#addSMPS :input").attr("required", '');
	  var siteID=siteId;	 
	$("#siteId").val(siteID);
	$(".isa_success").fadeOut(10000);
	getSMPSDetails(siteID);
	
	$(".photoLabel").hover(function(){
		$(".photoDiv").show();
	/*},function(){
		$(".photoDiv").hide('slow');*/
	});
	
});


function ValidateImage(id){
	var i=id[id.length-1];
	  var fuData = document.getElementById(id);
  var FileUploadPath = fuData.value;
//To check if user upload any file
  if (FileUploadPath == '') {
	  
      alert("Please upload an image");
 } else {
      var Extension = FileUploadPath.substring(
              FileUploadPath.lastIndexOf('.') + 1).toLowerCase();
//The file uploaded is an image
if (Extension == "gif" || Extension == "png" || Extension == "bmp"|| Extension == "jpeg" || Extension == "jpg") {
//To Display
		  $("#image"+i)[0].innerHTML="";
          if (fuData.files && fuData.files[0]) {
             var reader = new FileReader();
             reader.onload = function(e) {
                 // $('#blah').attr('src', e.target.result);
              }
             reader.readAsDataURL(fuData.files[0]);
          }
     }
//The file upload is NOT an image
else {
       //  alert("Photo only allows file types of GIF, PNG, JPG, JPEG and BMP. ");
         $("#image"+i)[0].innerHTML="Uploaded file must be Image Format";  
       document.getElementById(id).value="";
      }
  }
}
var base64_1,jsonData;




function getSMPSDetails(siteID)
{
	 $.ajax({
         type: "get",
         url: "getSMPSDetails",
         contentType: 'application/json',
         data:{"siteId":siteID},
         datatype: "json",
         success: function(result) {
            jsonData = JSON.parse(result);
            if(jsonData.length==0)
            {
            	 $("#imagediv1").hide();
                 $("#imagediv2").hide();
                 $("#fileupload1").show();
                 $("#fileupload2").show();
	             $("#cnfrmr1").hide();
                 $("#cnfrmr2").hide();
                
            }
            else
            {
            	$("#imagediv1").show();
                $("#imagediv2").show();
                $("#fileupload1").hide();
                $("#fileupload2").hide();
                
                $("#id").val(jsonData[0].id);
          		$("#Manufacturer").val(jsonData[0].Manufacturer);
          		$("#model").val(jsonData[0].model);
          		$("#manufacturerDate").val(jsonData[0].manufacturedDate);
          		$("#module_rating").val(jsonData[0].module_rating);
          		$("#workingModules").val(jsonData[0].number_of_working_Module_rating);
          		$("#smpsCondition").val(jsonData[0].smpsCondition);
          		$("#comments").val(jsonData[0].comments);
            	$("#imaget1").val(jsonData[0].Observation_1_Name);
            	$("#imaget2").val(jsonData[0].observation_2_Name);
            	
            	$("#addSMPS :input").removeAttr('required');
            }
         }					
		 }); 
}


function upload_files(id){
	
	var rdBtnid=id.id
	var i=rdBtnid[rdBtnid.length-1];
	
	if(id.value=="Yes"){
		$("#imagediv"+i).hide();
		$("#fileupload"+i).show();
		
	}else if(id.value=="No"){
		$("#imagediv"+i).show();
		$("#fileupload"+i).hide();
		
	}

}
 
function ViewImage(pid){
	
	console.log(jsonData[0].pid);
	console.log(jsonData[0].tower_photo1)
	var imageData= base64js.fromByteArray(jsonData[0][pid])
	
	var imageNum="Photo"+i;
	  var htmlstring = "<img id='ItemPreview' 'src=data:image/jpeg;base64,"+imageData+"' width='104' height='142'>";
    
       Swal.fire({
                title: "<i>"+imageNum+"</i>",
                html: "<center><table border='0'><tr><td><img id='ItemPreview' src='data:image/jpeg;base64,"+imageData+"' width='300' height='300'></td></tr></table><center>", 
                timer: 1000,
              });  
}
	
</script>
<style>
.fa-bars,
.fa-ellipsis-v
{
color: #fff!important;
}
label {
    color: #495057!important;
    font-size: 13px!important;
}


.login .wrapper.wrapper-login .container-login, .login .wrapper.wrapper-login .container-signup {
    width: 700px;
    background: #fff;
    padding: 74px 40px ;
   
    border-radius: 5px;
    -webkit-box-shadow: 0 0.75rem 1.5rem rgba(18,38,63,.03);
    -moz-box-shadow: 0 .75rem 1.5rem rgba(18,38,63,.03);
    box-shadow: 0 0.75rem 1.5rem rgba(18,38,63,.03);
    border: 1px solid #ebecec;
}


</style>
<body  class="login">

    <div class="main-header" style="background-color: #00B1BF;">
			<!-- Logo Header -->
			<div class="logo-header">
				
				<a href="home" class="logo">
				
					<img src="<c:url value='resources/assets/img/logo.png' />" alt="navbar brand" class="navbar-brand">
				</a>
				<button class="navbar-toggler sidenav-toggler ml-auto" type="button" data-toggle="collapse" data-target="collapse" aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon">
						<i class="fa fa-bars"></i>
					</span>
				</button>
				<button class="topbar-toggler more"><i class="fa fa-ellipsis-v"></i></button>
				<div class="navbar-minimize">
					<button class="btn btn-minimize btn-rounded">
						<i class="fa fa-bars"></i>
					</button>
				</div>
			</div>
			<!-- End Logo Header -->

			<!-- Navbar Header -->
			<div  id="navbar">	
			</div>
			<!-- End Navbar -->
		</div>

		<!-- Sidebar -->
<div id="technicianSidebar">
</div>
		<!-- End Sidebar -->
		
<div class="wrapper wrapper-login">
  <div class="container container-login animated fadeIn">
<%--     <div align="center"><span class="isa_success" style="color:#35B234;font-size:20px">${status}</span></div>	<br><br> --%>
    
			<h3 class="text-center">Add SMPS</h3>
				<span id="msg" style="color:red;font-size:12px;">*All Fields are Mandatory*</span><br><br>
			<form:form action="saveSMPS" id="addSMPS" method="post" modelAttribute="Site_SMPS" enctype="Multipart/form-data">
			<div class="login-form">
				 <br>
				 <form:hidden path="id" id="id"/>
				<label for="siteId" class=siteId><b>Site Id</b></label>
				<form:input id="siteId" path="siteid.siteid" class="form-control input-full filled" readonly="true"/>
				<br>
				
				 <br>
				<label for="Manufacturer" class="placeholder"><b>Manufacturer</b></label>
				<form:input id="Manufacturer" path="Manufacturer" class="form-control input-full filled" onkeypress="return isCharacters(event);"/>
				<br>
				
				<label for="model" class="placeholder"><b>Model (Rack Capacity kW)</b></label> 
				<form:input id="model" path="model"  name="model"  class="form-control input-full filled" onkeypress="return isNumber(event)"  />
				<br>
				
				<label for="date" class="placeholder"><b>Date of Manufacturer/Installation</b></label>
				 <form:input type="date" id="manufacturerDate" placeholder="mm/dd/yyyy" value="" path="manufacturedDate" class="form-control input-full filled" max="9999-12-31"/>
				<br>
				
				<label for="module_rating" class="module_rating"><b>Modules Rating (kW)</b></label>
               <form:input id="module_rating" path="module_rating"  name="module_rating"  class="form-control input-full filled"  onkeypress="return isNumber(event)" />
                <br>
                
                 <label for="fuellevel" class="fuellevel"><b>Number of Working modules available</b></label>
                	 <form:input id="workingModules" path="number_of_working_Module_rating"  name="number_of_working_Module_rating"  class="form-control input-full filled" onkeypress="return isNumber(event)"  />
              	<br>
              	
              	<label for="smpsCondition" class="smpsCondition"><b>Overall Condition of SMPS Equipment</b></label>
              	 <form:input id="smpsCondition" path="smpsCondition"  name="smpsCondition"  class="form-control input-full filled"  />
                <br>
                
                <label for="comments" class="comments"><b>Observation/Comments</b></label>
              	 <form:input id="comments" path="comments"  name="comments"  class="form-control input-full filled"  />
                <br>
                              
              <!-- 
                   <label for="" class=""><b>Photo1 : GPS Accuracy of Photo</b></label>
               <input type="file" id="photos"  name="file"  class="form-control input-full filled"  onchange="ValidateFileUpload(this.id)"/>
                <br> -->
                
              
                <div  id="fileupload1">
				<label for="Upload Image" class="placeholder" ><b>Photo1 : GPS Accuracy of Photo</b></label>
				<input type="file"  class="form-control input-border-bottom"  id="img1" name="file" onchange="ValidateImage(this.id);"  /> 
				<span class="isa_failure" id="image0">${errMsg}</span>
  				</div>
  				<div id="imagediv1">
 					<div  >
  						<label for="Site photo1" class="placeholder" ><b>Photo1 : GPS Accuracy of Photo</b></label>
  						<div class="row mt-1" >
  						<div class="col-md-9">
  						<form:input type="text" id="imaget1" path="" class="form-control input-full"   readonly="true"  />
  						</div>	
  						<div class="col-md-3 " >
  						<form:input type="button" id="observation_1" path="" value="View Image " onclick="ViewImage(this.id)"  class="form-control input-full btn btn-info"   />	
  						</div>
  						</div>
  					</div>
  				</div>
  				<div id="cnfrmr1">
  				   <div class="row mt-1">   
  				 	<div class="col-md-7">
                  		<label for="Radio_1" class="placeholder" ><b>Do you want to upload Image</b></label><br>
                  	</div>
                  		<div class="col-md-3">Yes<input type="radio"  value="Yes" id="rdyes1" name="rdbtn1" onclick="upload_files(this)" />
                  	</div>
                  	<div class="col-md-2">No<input type="radio" onclick="upload_files(this)" id="rdno1"  value="No"  name="rdbtn1" checked/>
                 	</div>
                  </div>
 	
 				</div>
                 
                 <!--               
              	<label for="" class=""><b>Photo 2 : GPS Accuracy of Photo</b></label>
               <input type="file"  id="photos"  name="file"  class="form-control input-full filled"  onchange="ValidateFileUpload(this.id)"/>-->
                <br> 
                
                	<div  id="fileupload2">
				<label for="Upload Image" class="placeholder" ><b>Photo 2 : GPS Accuracy of Photo</b></label>
				<input type="file"  class="form-control input-border-bottom"  id="img2" name="file" onchange="ValidateImage(this.id);"  /> 
				<span class="isa_failure" id="image1">${errMsg}</span>
  				</div>
  				<div id="imagediv2">
 					<div  >
  						<label for="Site photo2" class="placeholder" ><b>Photo 2 : GPS Accuracy of Photo</b></label>
  						<div class="row mt-1" >
  						<div class="col-md-9">
  						<form:input type="text" id="imaget2" path="" class="form-control input-full"   readonly="true"  />
  						</div>	
  						<div class="col-md-3 " >
  						<form:input type="button" id="observation_2" path="" value="View Image " onclick="ViewImage(this.id)"  class="form-control input-full btn btn-info"   />	
  						</div>
  						</div>
  					</div>
  				</div>
  				<div id="cnfrmr2">
  				   <div class="row mt-1">   
  				 	<div class="col-md-7">
                  		<label for="Radio_2" class="placeholder" ><b>Do you want to upload Image</b></label><br>
                  	</div>
                  		<div class="col-md-3">Yes<input type="radio"  value="Yes" id="rdyes2" name="rdbtn2" onclick="upload_files(this)" />
                  	</div>
                  	<div class="col-md-2">No<input type="radio" onclick="upload_files(this)" id="rdno2"  value="No"  name="rdbtn2" checked/>
                 	</div>
                  </div>
 				</div>
                              
				<div class="form-action">
					<!-- <a href="home" id="show-signin" class="btn btn-rounded btn-login mr-3" style="background-color: #E4002B;color: white;">Cancel</a>-->
					<input type="submit"  name="submit" value="Save for Later" class="btn btn-rounded btn-login" style="background-color: #E4002B;color: white;">
					<input type="submit"  name="submit" value="Next" class="btn btn-rounded btn-login" style="background-color: #012169;color: white;">

				</div>
			</div>
			</form:form>			
		</div>
</div>
   <script src="<c:url value='resources/assets/js/core/jquery.3.2.1.min.js' />"></script>
	<script src="<c:url value='resources//assets/js/plugin/jquery-ui-1.12.1.custom/jquery-ui.min.js' />"></script>
	<script src="<c:url value='resources/assets/js/core/popper.min.js' />"></script>
	<script src="<c:url value='resources/assets/css/bootstrap.min.css' />"></script>
	<script src="<c:url value='resources/assets/js/ready.js' />"></script>
	
	<!--   Core JS Files   -->



<script src="<c:url value='resources/assets/js/core/jquery.3.2.1.min.js' />"></script>
<script src="<c:url value='resources/assets/js/core/popper.min.js' />"></script>
<script src="<c:url value='resources/assets/js/core/bootstrap.min.js' />"></script>

<!-- jQuery UI -->


<script src="<c:url value='resources/assets/js/plugin/jquery-ui-1.12.1.custom/jquery-ui.min.js' />"></script>
<script src="<c:url value='resources/assets/js/plugin/jquery-ui-touch-punch/jquery.ui.touch-punch.min.js' />"></script>


<!-- jQuery Scrollbar -->
<script src="<c:url value='resources/assets/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js' />"></script>



<!-- jQuery Sparkline -->

<script src="<c:url value='resources/assets/js/plugin/jquery.sparkline/jquery.sparkline.min.js' />"></script>

<!-- Sweet Alert -->

<script src="<c:url value='resources/assets/js/plugin/sweetalert/sweetalert.min.js' />"></script>
<!-- jQuery Sparkline -->

<script src="<c:url value='resources/assets/js/plugin/jquery.sparkline/jquery.sparkline.min.js' />"></script>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>



</body>

</html>