<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String inventoryDetails=(String)request.getParameter("inventoryDetails"); %>
<% String ticketId=(String)request.getParameter("ticketid"); %>
<% String ticketType=(String)request.getParameter("ticketType"); %>
<% String ticketStatus=(String)request.getParameter("ticketStatus"); %>

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




$(document).ready(function(){	
	 $("#navbar").load('<c:url value="/resources/common/header.jsp" />'); 
	// $("#execSidebar").load('<c:url value="/resources/common/executiveSidebar.jsp" />'); 
	
	
	  
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
				<h3 class="text-center">Tower Audit</h3>
				<form method="post" id="inventoryForm" >
				<div class="login-form">			
					<div class="form-group ">
						<label for="towertype" class="placeholder">Tower Type</label>
						<input id="towertype" class="form-control input-full"  />					
					</div>
					<div class="form-group ">
						<label for="obnotes" class="placeholder">Observation Notes- Structures corrision,Plinth,cracking/spalling,
							<br>previous upgrade(metal jackets) or extension to top of structure
						</label>
						<input id="obnotes" class="form-control input-full"  />					
					</div>
					<div class="form-group ">
						<label for="visualinspection1" class="placeholder"> Visual inspection:Any subsidence and/or undermining the foundation
						</label>
						<input id="visualinspection1" class="form-control input-full"  />					
					</div>
					<div class="form-group ">
						<label for="visualinspection2" class="placeholder">Visual inspection:Bent,twisted,cracked or missing members </label>
						<input id="visualinspection2" class="form-control input-full"  />					
					</div>
					<div class="form-group ">
						<label for="towercondition" class="placeholder">Overall tower condition </label>
						<input id="towercondition" class="form-control input-full"  />					
					</div>
					<div class="form-group ">
						<label for="ticomments" class="placeholder">Comments on available space for additional antennae </label>
						<input id="ticomments" class="form-control input-full"  />					
					</div>
					
					<div class="form-group ">
						<label for="tirfantennae" class="placeholder">Number of RF antennae </label>
						<input id="tirfantennae" class="form-control input-full"  />					
					</div>
					<div class="form-group ">
						<label for="timwantennae" class="placeholder">Number of MW antennae </label>
						<input id="timwantennae" class="form-control input-full"  />					
					</div>
					
					<div class="form-group ">
						<label for="tirrh" class="placeholder">Number of RRH(Remote Radio Head)</label>
						<input id="tirrh" class="form-control input-full"  />					
					</div>
					
				<div class="form-group ">
				
				<label for="Upload Image" class="placeholder" >Upload Image </label>
							<input type="file"  class="form-control input-border-bottom" accept="image"  id="image1" name="file"  path="fileName" required/> 
						<!-- <span> Max Size upload 3 MB</span> -->
							
							<!--  -->
	
  
					<span class="isa_failure" id="isa_failure">${errMsg}</span>
<%-- 					        <form:errors path="fileName" cssClass="error"/>
 --%>				</div>
 	
				<div class="form-group ">
				
				<label for="Upload Image" class="placeholder" >Upload Image2 </label>
							<input type="file"  class="form-control input-border-bottom" accept="image"  id="image2" name="file"  path="fileName" required/> 
						<!-- <span> Max Size upload 3 MB</span> -->
							
							<!--  -->
	
  
					<span class="isa_failure" id="isa_failure">${errMsg}</span>
<%-- 					        <form:errors path="fileName" cssClass="error"/>
 --%>				</div>
 	
				<div class="form-group ">
				
				<label for="Upload Image" class="placeholder" >Upload Image3 </label>
							<input type="file"  class="form-control input-border-bottom" accept="image"  id="image3" name="file"  path="fileName" required/> 
						<!-- <span> Max Size upload 3 MB</span> -->
							
							<!--  -->
	
  
					<span class="isa_failure" id="isa_failure">${errMsg}</span>
<%-- 					        <form:errors path="fileName" cssClass="error"/>
 --%>				</div>
 
 					
				<div class="form-action" id="new_submit" >
				 <input type="button"  class="btn btn-rounded btn-login" value="Save" style="background-color: #012169;color: white;">  
					
 					<!-- <input type="submit"  value="Save" class="btn btn-primary btn-rounded btn-login">  -->
 				
 				
				 <input type="button" class="btn btn-rounded btn-login" value="Save & Continue" style="background-color: #012169;color: white;">  
					
 					<!-- <input type="submit"  value="Save" class="btn btn-primary btn-rounded btn-login">  -->
 				</div>
 
				</div>
				</form>			
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