<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html >
<html lang="en">

<head>

	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="icon" href="<c:url value='resources/assets/img/icon.ico' />" type="image/x-icon"/>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<title>Site Survey</title>
	<meta content='width=device-width, initial-scale=1.0, shrink-to-fit=no' name='viewport' />
	<script type="text/javascript">
	
	   if(sessionStorage.getItem("username")==null)
   	{
		   url = "/sitesurvey/";
		      $( location ).attr("href", url);
   	}
	 
	   else
		   {
		   role=sessionStorage.getItem("role");
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
	  $("#addGenerator :input").attr("required", '');
		 $(".isa_success").fadeOut(10000);
		getGeneratorDetails();
		 
});


function getGeneratorDetails()
{
	//var siteId=$("#siteId").val();
	siteId='IND005';
	$("#siteId").val(siteId);
	 $.ajax({
         type: "get",
         url: "getGeneratorDetails",
         contentType: 'application/json',
         data:{"siteId":siteId},
         datatype: "json",
         success: function(result) {
            jsonData = JSON.parse(result);
            if(jsonData.length==0)
            {
            	
            }
            else
            {
            	$("#id").val(jsonData[0].id);
            	$("#dgManufacturer").val(jsonData[0].dgManufacturer);
            	$("#date").val(jsonData[0].manufacturedDate);
            	$("#capacity").val(jsonData[0].capacity);
            	$("#DGrunhours").val(jsonData[0].DGrunhours);
            	$("#fuellevel").val(jsonData[0].fuellevel);
            	$("#assettagnumber").val(jsonData[0].assettagnumber);
            	$("#generatorCondition").val(jsonData[0].generatorCondition);
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

.error {
	color: #ff0000;
	font-style: italic;
	font-weight: bold;
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
    <div align="center"><span class="isa_success" style="color:#35B234;font-size:20px">${status}</span></div>	<br><br>
    
			<h3 class="text-center">Add Generator</h3>${siteId}
				<span id="msg" style="color:red;font-size:12px;">*All Fields are Mandatory*</span><br><br>
				
			<form:form action="saveGenerator" id="addGenerator"  method="post" modelAttribute="Site_Generator" enctype = 'multipart/form-data' >
			<div class="login-form">
			<!-- <span id="addMsg" style="font-size:18px;margin-left:221px;"><b>Add New</b><button type="submit" value="Add" name="submit"><i class="fa fa-plus-square" aria-hidden="true"></i></button></span><br><br>-->
			 <form:hidden path="id" id="id"/>
			<label for="siteid" class="placeholder">Site Id</label>
				<form:input id="siteId" path="siteid.siteid" name="siteId" class="form-control input-full filled" />
				<form:errors path="siteid.siteid" cssClass="error"/>
			
				 <br>
				<form:hidden path="" id="ticketId" name="ticketId" />
				<label for="Manufacturer" class="placeholder">Manufacturer</label>
				<form:input id="dgManufacturer" path="dgManufacturer" class="form-control input-full filled" onkeypress="return isCharacters(event);"/>
				<form:errors path="dgManufacturer" cssClass="error"/>
				
				<br>
				<label for="date" class="placeholder">Date of Manufacturer/Installation</label>
				 <form:input id="date" type="date"  placeholder="mm/dd/yyyy" value="" path="manufacturedDate" class="form-control input-full filled" max="9999-12-31"/>
				 <form:errors path="manufacturedDate" cssClass="error"/>
				<br>
				
				<label for="capacity" class="placeholder">Generator Capacity Rating(kVA)</label> 
				<form:input id="capacity" path="capacity"  name="capacity"  class="form-control input-full filled" onkeypress="return isNumber(event)" />
				<form:errors path="capacity" cssClass="error"/>
				<br>
               
				<label for="DGrunhours" class="DGrunhours">DG Run hours(hrs)</label>
               <form:input id="DGrunhours" path="DGrunhours"  name="DGrunhours"  class="form-control input-full filled"  onkeypress="return isNumber(event)"/>
               <form:errors  path="DGrunhours" cssClass="error" />
               
                <br>
                <span class="isa_failure" style="color:red">${errMsg}</span>
                <label for="" class="">Photos of Generator Control Unit(GCU)</label>
               <input type="file" id="GCUPhoto"  name="file"  class="form-control input-full filled" onchange="ValidateFileUpload(this.id)"/>
                <br>
                
                <label for="fuellevel" class="fuellevel">Fuel Level at Site(%)</label>
                	 <form:input id="fuellevel" path="fuellevel"  name="fuellevel"  class="form-control input-full filled"  onkeypress="return isNumber(event)"/>
               	<br>
              
           	 	<label for="" class="">Photos of Fuel Level Sensor</label>
               	<input type="file" id="FLSPhoto"  name="file"  class="form-control input-full filled" onchange="ValidateFileUpload(this.id)" />
                <br> 
              
              	<label for="" class="">Photo1 of the site(Which is not in proper condition)</label>
               	<input type="file" id="photo1"  name="file"  class="form-control input-full filled" onchange="ValidateFileUpload(this.id)" />
                <br> 
                
                <label for="" class="">Photo2 of the site(Which is not in proper condition)</label>
               	<input type="file" id="photo2"  name="file"  class="form-control input-full filled"  onchange="ValidateFileUpload(this.id)"/>
                <br> 
              
              	<label for="tagNumber" class="placeholder">Asset Tag Number</label>
				<!--<form:input id="assettagnumber" path="assettagnumber"  name="assettagnumber"  class="form-control input-full filled"  />-->
				 <form:radiobutton path="assettagnumber" value="Yes"/> Yes 
        		 <form:radiobutton path="assettagnumber" value="No"/>  No
				<br>
				<br>
				<label for="" class="">Asset Tag Photo</label>
               	<input type="file" id="tagPhoto"  name="file"  class="form-control input-full filled"  />
                <br> 
				
              	<label for="Condition" class="Condition">Condition</label>
              	 <form:select id="generatorCondition" path="generatorCondition"  name="generatorCondition"  class="form-control input-full filled" >
              	 <form:option value="Select">Select</form:option>
              	 <form:option value="Not assessed">Not assessed (Note why not assessed in observation)</form:option>
              	 <form:option value="Very Poor">Very Poor. Burnt,needing urgent repairs cannablised</form:option>
              	 <form:option value="Poor">Poor (Broken down condition needing replacement)</form:option>
              	 <form:option value="Fair">Fair (Working without any major issues)</form:option>
              	 <form:option value="Good">Good (Working with no issues at all)</form:option>
              	 <form:option value="Very Good">Very good (Looks as good as new)</form:option>
              	 <form:option value="Not Applicable">Not Applicable</form:option>
              	 </form:select>
                <br>
                
                <label for="comments" class="placeholder">Comments</label> 
				<form:input id="comments" path="comments"  name="comments"  class="form-control input-full filled"  />
				<br>
                
				<div class="form-action">
					<!-- <a href="home" id="show-signin" class="btn btn-rounded btn-login mr-3" style="background-color: #E4002B;color: white;">Cancel</a>-->
					<input type="submit" value="Save" name="submit" class="btn btn-rounded btn-login" style="background-color: #012169;color: white;">
					<input type="submit" value="Save & Continue" name="submit" class="btn btn-rounded btn-login" style="background-color: #012169;color: white;">
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