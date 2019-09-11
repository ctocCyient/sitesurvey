<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html >
<html lang="en">

<head>

<spring:url value="resources/css/styling.css" var="mainCss" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<link rel="icon" href="<c:url value='resources/assets/img/icon.ico' />" type="image/x-icon"/>
<title>Site Survey</title>
	<meta content='width=device-width, initial-scale=1.0, shrink-to-fit=no' name='viewport' />

	


	<script src="<c:url value='resources/js/jquery.min.js' />"></script>
	
	<script src="<c:url value='resources/js/jquery-ui.min.js' />"></script>
	<script src="<c:url value='resources/js/validations.js' />"></script>
	
	<link rel="stylesheet" href="<c:url value='resources/css/jquery-ui.css' />">
	
	
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>

		
	<link rel="stylesheet" type="text/css" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" />

     
<script src="<c:url value='resources/assets/js/plugin/webfont/webfont.min.js' />"></script>

	<!-- <script type="text/javascript">
	role=sessionStorage.getItem("role"); 
   if(sessionStorage.getItem("username")==null) 
   	{ 
		//window.location.href = "/sitesurvey/";
	//alert(sessionStorage.getItem("username"));
		   url = "/sitesurvey/"; 
		      $( location ).attr("href", url);
  	}
   else if(role=="Admin" || role=="SuperAdmin")
		   { 
		   
		   } 
 	   else 
 		   { 
 		   url = "/sitesurvey/"; 
 		      $( location ).attr("href", url);
		   } 

 </script> -->
 
 
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


            p {
                padding-left: 10px;
/*                 background-color: #00ae42; */
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

$(document).ready(function(){	
	$("#navbar").load('<c:url value="/resources/common/header.jsp" />'); 
	 $("#technicianSidebar").load('<c:url value="/resources/common/technicianSidebar.jsp" />'); 

		
		 $(".isa_success").fadeOut(10000);
	
});


</script>
<style>
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


input[type=file]::-webkit-file-upload-button {
  border: 1px solid grey;
  background: #FFFAAA;
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
    
			<h3 class="text-center">PPE(PERSONAL PROTECTIVE EQUIPMENT)</h3>
				
			<form:form action="saveSurveyPPE" method="post" modelAttribute="SurveyTeamPPE">
			<div class="login-form">
			
				 <br>
				<label for="ppe" class="placeholder"><b>All members of survey team wearing PPE(safety boots, high visibility vest, hard hat)</b></label>
				<form:input id="ppe" path="ppe" class="form-control input-full filled" />
				<br>
				<label for="photoSurveyTeam" class="placeholder"><b>Photo of survey team</b></label>
				<input type="file"  class="form-control input-border-bottom"  id="photoSurveyTeam" name="photoSurveyTeam"  path="photoSurveyTeam" required/> 
				<br>
				<label for="technicianName" class="placeholder"><b>Technician name/s</b></label> 
				<form:input id="technicianName" path="technicianName"  name="technicianName"  class="form-control input-full filled"  />
				<br>
               
				<label for="technicianWearing" class="placeholder"><b>Technician/s wearing PPE</b></label><br><br>
				<form:checkboxes items="${PPEList}" path="technicianWearing" id="technicianWearing"  element="p" name="technicianWearing"/><br>
<%--                <form:input id="technicianWearing" path="technicianWearing"  name="technicianWearing"  class="form-control input-full filled"  /> --%>
				
                <br>
                
                <label for="photoTechnicianTeam" class="placeholder"><b>Photo of technician/s</b></label>            
				<input type="file"  class="form-control input-border-bottom"  id="photoTechnicianTeam" name="photoTechnicianTeam"  path="photoTechnicianTeam" required/> 
                <br>
          
				<label for="rigger_Name" class="placeholder"><b>Rigger Name/s</b></label>
				<form:input id="rigger_Name" path="rigger_Name" class="form-control input-full filled" />
				<br>
				<label for="rigger_Wearing" class="placeholder"><b>Rigger/s wearing PPE</b></label><br><br>
<%-- 				<form:input id="rigger_Wearing" path="rigger_Wearing" class="form-control input-full filled" /> --%>
				<form:checkboxes items="${riggerPPEList}" path="rigger_Wearing" id="rigger_Wearing"  element="p" name="rigger_Wearing"/><br>
				<br>
				<label for="photoRiggerTeam" class="placeholder"><b>Photo of Rigger/s</b></label>
				<input type="file"  class="form-control input-border-bottom"  id="photoRiggerTeam" name="photoRiggerTeam"  path="photoRiggerTeam" required/> 
				<br>
				<div class="form-action">
					<input type="submit" id="submit" value="Save" class="btn btn-rounded btn-login" style="background-color: #E4002B;color: white;">
<!-- 					<input type="submit" id="submit" value="Save & Continue" class="btn btn-rounded btn-login" style="background-color: #012169;color: white;"> -->
<a href="siteAccess" class="btn btn-rounded btn-login" >Next</a>
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