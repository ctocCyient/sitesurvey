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



function getSMPSDetails(siteID)
{
	var siteID=siteID;
	
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
          		
          	}
          	else
          	{
          		$("#id").val(jsonData[0].id);
          		$("#Manufacturer").val(jsonData[0].Manufacturer);
          		$("#model").val(jsonData[0].model);
          		$("#manufacturerDate").val(jsonData[0].manufacturedDate);
          		$("#module_rating").val(jsonData[0].module_rating);
          		$("#workingModules").val(jsonData[0].number_of_working_Module_rating);
          		$("#smpsCondition").val(jsonData[0].smpsCondition);
          		$("#comments").val(jsonData[0].comments);
          		
          	}
         }					
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

.photoDiv {
   
    
  position: relative;
  float: right;
  border: 2px solid #003B62;
  font-family: verdana;
  background-color: #B5CFE0;
  
}

.button-text {
    padding:0 25px;
    line-height:56px;
    letter-spacing:3px
}

.photoLabel {
    font-weight:20px
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
				
				<label for="model" class="placeholder"><b>Model(Rack Capacity kW)</b></label> 
				<form:input id="model" path="model"  name="model"  class="form-control input-full filled" onkeypress="return isNumber(event)"  />
				<br>
				
				<label for="date" class="placeholder"><b>Date of Manufacturer/Installation</b></label>
				 <form:input type="date" id="manufacturerDate" placeholder="mm/dd/yyyy" value="" path="manufacturedDate" class="form-control input-full filled" max="9999-12-31"/>
				<br>
				
				<label for="module_rating" class="module_rating"><b>Modules Rating(kW)</b></label>
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
                              
                <label for="" class=""><b>Photo1 : GPS Accuracy of Photo</b></label>
               <input type="file" id="photos"  name="file"  class="form-control input-full filled"  onchange="ValidateFileUpload(this.id)"/>
                <br>
                               
<<<<<<< HEAD
              	<label for="" class="photoLabel">Photo 2 : GPS Accuracy of Photo</label>
=======
              	<label for="" class=""><b>Photo 2 : GPS Accuracy of Photo</b></label>
>>>>>>> branch 'master' of https://github.com/ctocCyient/sitesurvey
               <input type="file"  id="photos"  name="file"  class="form-control input-full filled"  onchange="ValidateFileUpload(this.id)"/>
                <br>
                
                
                              
				<div class="form-action">
					<!-- <a href="home" id="show-signin" class="btn btn-rounded btn-login mr-3" style="background-color: #E4002B;color: white;">Cancel</a>-->
					<input type="submit"  name="submit" value="Save" class="btn btn-rounded btn-login" style="background-color: #E4002B;color: white;">
					<input type="submit"  name="submit" value="Save & Continue" class="btn btn-rounded btn-login" style="background-color: #012169;color: white;">

				</div>
			</div>
			</form:form>			
			
		</div>
		
		<div class="photoDiv" style="display:none;">
                <img src="data:image/jpeg;base64,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"/>
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



</body>

</html>