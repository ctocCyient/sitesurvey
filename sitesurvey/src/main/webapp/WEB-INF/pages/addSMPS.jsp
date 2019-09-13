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
	  $("#superAdminSidebar").load('<c:url value="/resources/common/superAdminSidebar.jsp" />'); 
	  $("#addSMPS :input").attr("required", '');
	  var siteID=siteId;	 
	$("#siteId").val(siteID);
	$(".isa_success").fadeOut(10000);
	getSMPSDetails(siteID);
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
<div id="superAdminSidebar">
</div>
		<!-- End Sidebar -->
		
<div class="wrapper wrapper-login">
  <div class="container container-login animated fadeIn">
    <div align="center"><span class="isa_success" style="color:#35B234;font-size:20px">${status}</span></div>	<br><br>
    
			<h3 class="text-center">Add SMPS</h3>
				<span id="msg" style="color:red;font-size:12px;">*All Fields are Mandatory*</span><br><br>
			<form:form action="saveSMPS" id="addSMPS" method="post" modelAttribute="Site_SMPS" enctype="Multipart/form-data">
			<div class="login-form">
				 <br>
				 <form:hidden path="id" id="id"/>
				<label for="siteId" class=siteId>Site Id</label>
				<form:input id="siteId" path="siteid.siteid" class="form-control input-full filled" readonly="true"/>
				<br>
				
				 <br>
				<label for="Manufacturer" class="placeholder">Manufacturer</label>
				<form:input id="Manufacturer" path="Manufacturer" class="form-control input-full filled" onkeypress="return isCharacters(event);"/>
				<br>
				
				<label for="model" class="placeholder">Model(Rack Capacity kW)</label> 
				<form:input id="model" path="model"  name="model"  class="form-control input-full filled" onkeypress="return isNumber(event)"  />
				<br>
				
				<label for="date" class="placeholder">Date of Manufacturer/Installation</label>
				 <form:input type="date" id="manufacturerDate" placeholder="mm/dd/yyyy" value="" path="manufacturedDate" class="form-control input-full filled" max="9999-12-31"/>
				<br>
				
				<label for="module_rating" class="module_rating">Modules Rating(kW)</label>
               <form:input id="module_rating" path="module_rating"  name="module_rating"  class="form-control input-full filled"  onkeypress="return isNumber(event)" />
                <br>
                
                 <label for="fuellevel" class="fuellevel">Number of Working modules available</label>
                	 <form:input id="workingModules" path="number_of_working_Module_rating"  name="number_of_working_Module_rating"  class="form-control input-full filled" onkeypress="return isNumber(event)"  />
              	<br>
              	
              	<label for="smpsCondition" class="smpsCondition">Overall Condition of SMPS Equipment</label>
              	 <form:input id="smpsCondition" path="smpsCondition"  name="smpsCondition"  class="form-control input-full filled"  />
                <br>
                
                <label for="comments" class="comments">Observation/Comments</label>
              	 <form:input id="comments" path="comments"  name="comments"  class="form-control input-full filled"  />
                <br>
                              
                <label for="" class="">Photo1 : GPS Accuracy of Photo</label>
               <input type="file" id="photos"  name="file"  class="form-control input-full filled"  onchange="ValidateFileUpload(this.id)"/>
                <br>
                               
              	<label for="" class="">Photo 2 : GPS Accuracy of Photo</label>
               <input type="file"  id="photos"  name="file"  class="form-control input-full filled"  onchange="ValidateFileUpload(this.id)"/>
                <br>
                              
				<div class="form-action">
					<!-- <a href="home" id="show-signin" class="btn btn-rounded btn-login mr-3" style="background-color: #E4002B;color: white;">Cancel</a>-->
					<input type="submit"  name="submit" value="Save" class="btn btn-rounded btn-login" style="background-color: #012169;color: white;">
					<input type="submit"  name="submit" value="Save & Continue" class="btn btn-rounded btn-login" style="background-color: #012169;color: white;">

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



</body>

</html>