<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String jsondetails=(String)request.getParameter("ticketDetails"); 
   System.out.println("json>>>>>>>"+jsondetails);%>

<!DOCTYPE html >
<html lang="en">

<head>

<spring:url value="resources/css/styling.css" var="mainCss" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<link rel="icon" href="<c:url value='resources/assets/img/icon.ico' />" type="image/x-icon"/>
<title>RFID</title>
	<meta content='width=device-width, initial-scale=1.0, shrink-to-fit=no' name='viewport' />

	<link href="${mainCss}" rel="stylesheet" />

<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
<spring:url value="resources/css/jquery-ui.css" var="jqueryCss" />
<spring:url value="/resources/js/jquery.min.js" var="jqueryJs" />
	<spring:url value="/resources/js/jquery-ui.min.js" var="jqueryuiJs" />
		<spring:url value="/resources/js/validations.js" var="validationsJs" />
		
	<link rel="stylesheet" type="text/css" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" />

	<link href="${jqueryCss}" rel="stylesheet" />
	<script src="${jqueryJs}"></script>
    <script src="${jqueryuiJs}"></script>
    <script src="${validationsJs}"></script>
     
<script src="<c:url value='resources/assets/js/plugin/webfont/webfont.min.js' />"></script>
<link rel="stylesheet" href="<c:url value='resources/assets/css/bootstrap.min.css' />">
	<link rel="stylesheet" href="<c:url value='resources/assets/css/azzara.min.css' />">
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

<script type="text/javascript">


WebFont.load({
	google: {"families":["Open+Sans:300,400,600,700"]},
	custom: {"families":["Flaticon", "Font Awesome 5 Solid", "Font Awesome 5 Regular", "Font Awesome 5 Brands"], urls: ["<c:url value='resources/assets/css/fonts.css' />"]},
	active: function() {
		sessionStorage.fonts = true;
	}
});

var inventoryData;
var ticketId,ticketType;
var ticketStatus;



var jsonDetails;
$(document).ready(function(){	
	 $("#navbar").load('<c:url value="/resources/common/header.jsp" />'); 
	// $("#execSidebar").load('<c:url value="/resources/common/executiveSidebar.jsp" />'); 
	 jsonDetails='<%=jsondetails%>';
	
	var ticketDetails=JSON.parse(jsonDetails);
	//alert(ticketDetails);
	$("#siteid")[0].value=ticketDetails.split(",")[1];
	//alert(ticketDetails.split(",")[1]);
	  
	
});


function ValidateImage(id){
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
             alert("Photo only allows file types of GIF, PNG, JPG, JPEG and BMP. ");
             document.getElementById(id).value="";
          }
      }
  }

</script>
<style>
.isa_failure{
    color:red;
}
.error {
 color: #ff0000;
 font-style: italic;
 font-weight: bold;
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
<div id="execSidebar">
</div>
		<!-- End Sidebar -->
		
	<div class="wrapper wrapper-login">
	  <div class="container container-login animated fadeIn">
	   <div align="center"><span class="isa_success" style="color:#35B234;font-size:20px">${suuccMsg}</span></div>	<br><br>
				<h3 class="text-center">Security</h3>
				<form:form method="post" id="securityform" modelAttribute="Site_Security" action="sitesecurity" enctype="multipart/form-data"   >
				
				
				<form:input type="hidden" path="siteid.siteid" id="siteid" />	
				
				<div class="form-group ">
						<label for="obnotes" class="placeholder">Observation / Comment - Presence of fence,locks,alarm system, other security.
				
						</label>
						
						<form:input id="obnotes" path="observations" class="form-control input-full"  />				
						<form:errors path="observations" cssClass="error" />	
					</div>
				<div class="form-group ">
						<label for="securitycondition" class="placeholder">What is the overall security Condition? </label>
						<form:select id="securitycondition" path="securityCondition"  name="overallconditon"  class="form-control input-full filled" >
		                <form:option value="Select">Select</form:option>
		                <form:option value="Not assessed">Not assessed (Note why not assessed in observation)</form:option>
		                <form:option value="Very Poor">very poor- Fencing,locks,alarm system are non existent/broken</form:option>
		                <form:option value="Poor">Poor - Fencing,locks,alarm system are in place, need significant work</form:option>
		                <form:option value="Fair"> Fair - Fencing,locks,alarm systems, need light maintenance</form:option>
		                <form:option value="Good">Good - Fencing, locks, alarm systems good condition</form:option>
		                <form:option value="Very Good">Very good - Fencing locks, alarm systems good new condition</form:option>
		                <form:option value="Not Applicable">Not Applicable</form:option>
		                </form:select>
								<form:errors path="securityCondition" cssClass="error" />
										
					</div>
						
				<div class="form-group ">
				<label for="Upload Image" class="placeholder" >Upload Image </label>
				<input type="file"   path="security_photo1" class="form-control input-border-bottom"  id="img1" name="file" onchange="return ValidateImage(this.id);"  /> 
				<span class="isa_failure" id="image0">${errMsg}</span>
  				</div>
 				<div class="form-group ">
				<label for="Upload Image" class="placeholder" >Upload Image2 </label>
				<input type="file" path="security_photo2"  class="form-control input-border-bottom"  id="img2"  name="file"  onchange="return ValidateImage('img2');"/> 
					<span class="isa_failure" id="image1">${errMsg}</span>
  				</div>
  				
 						<div class="form-action" id="new_submit" >
				 		<input type="submit"  class="btn btn-rounded btn-login" value="Save" name="btn" style="background-color: #012169;color: white;">  
					
 						<!-- <input type="submit"  value="Save" class="btn btn-primary btn-rounded btn-login">  -->
 				
 				
				 		<input type="submit" class="btn btn-rounded btn-login" value="Save & Continue" name="btn" style="background-color: #012169;color: white;">  
					
 							<!-- <input type="submit"  value="Save" class="btn btn-primary btn-rounded btn-login">  -->
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