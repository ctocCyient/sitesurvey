<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html >
<html lang="en">

<head>

<spring:url value="resources/css/styling.css" var="mainCss" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />


<title>RFID</title>
	<meta content='width=device-width, initial-scale=1.0, shrink-to-fit=no' name='viewport' />

	<link href="${mainCss}" rel="stylesheet" />


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

<script type="text/javascript">

// createFolder("C:\\TEST\\")
// function createFolder(folder){
// makeDir(folder)
// }


WebFont.load({
	google: {"families":["Open+Sans:300,400,600,700"]},
	custom: {"families":["Flaticon", "Font Awesome 5 Solid", "Font Awesome 5 Regular", "Font Awesome 5 Brands"], urls: ["<c:url value='resources/assets/css/fonts.css' />"]},
	active: function() {
		sessionStorage.fonts = true;
	}
});

function validatePassword()
{
	if(document.getElementById('pwd').value==document.getElementById('cpwd').value)
		{}
	else {
		alert("Please Check");
		$('#cpwd').val('');
	}

}

$(document).ready(function(){	
	 $("#navbar").load('<c:url value="/resources/common/header.jsp" />'); 
	  $("#sidebar").load('<c:url value="/resources/common/sidebar.jsp" />'); 
	dateFun();
		$("#username,#emailId,#mobileNum,#pwd,#cpwd").attr('required', '');  
		 $(".isa_success").fadeOut(5000);
});

function populateDropdown(data,id)
{
	var	catOptions="<option value='Select'>Select</option>";
 	for (i in data) {
 		
   	 	 catOptions += "<option>" + data[i] + "</option>";
 		}
 		document.getElementById(id).innerHTML = catOptions;
 		 $("select option[value='Select']").attr('disabled','disabled');
}

	function dateFun()
	{
		var today = new Date();
		document.getElementById('createdDate').value=today;
	}

	function getRegion(value)
	{	
	
		var name=$("#name").val();
		
			$.ajax({
		         type:"get",
		         url:"getRegion",
		         contentType: 'application/json',
		         datatype : "json",
		         success:function(data1) {
		         	jsonData = JSON.parse(data1);
		         	populateDropdown(jsonData,"region");
		         },
		         error:function()
		         {
		         	console.log("Error");
		         }
		 	});	
	}
	
function getUsername()
{
	var name=$("#name").val();
	$("#username").val(name);
}

	

</script>
<style>
.fa-bars,
.fa-ellipsis-v
{
color: #fff!important;
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
<div id="sidebar">
</div>
		<!-- End Sidebar -->
		
<div class="wrapper wrapper-login">
  <div class="container container-login animated fadeIn">
    <div align="center"><span class="isa_success" style="color:#012169;font-size:20px">${status}</span></div>	<br><br>
			<h3 class="text-center">Add User</h3>
			<form:form action="saveUser" method="post" modelAttribute="User">
			<div class="login-form">
			<div class="form-group form-floating-label">
				<label for="Type" class="Type">Role</label>
                <form:select id="type" path="type" name="type" class="form-control" onchange="getRegion(this.value);">
                <form:option value="Select">Select</form:option>
                	<form:option value="Admin">Admin</form:option>
                	<form:option value="Manager">Manager</form:option>
                </form:select>
                </div>			
				<div class="form-group "> 
				<label for="name" class="placeholder">Name</label>
				<form:input id="name" path="name" class="form-control input-border-bottom" onkeypress="return isCharacters(event);"/>
					<!-- <input  id="fullname" name="fullname" type="text" class="form-control input-border-bottom" required> -->
					
				</div>
				
				<form:hidden path="username" id="username" value="" />
				
				<div class="form-group ">
				<label for="email" class="placeholder">Email ID</label>
				<form:input id="emailId" path="emailId" class="form-control input-border-bottom"   onchange="validateEmailId(this.value,this.id)"  />
					<!-- <input  id="email" name="email" type="email" class="form-control input-border-bottom" required>-->
					
				</div>
				
				<div class="form-group ">
				<label for="passwordsignin" class="placeholder">Password</label> 
				<form:password id="pwd" path="password" name="passwordsignin"  class="form-control input-border-bottom"  />
					<!-- <input  id="passwordsignin" name="passwordsignin" type="password" class="form-control input-border-bottom" required>-->
					
				</div>
				<div class="form-group ">
				<label for="confirmpassword" class="placeholder">Confirm Password</label>
				<form:password id="cpwd" path="" onchange="validatePassword()" name="confirmpassword" class="form-control input-border-bottom"  />
					<!-- <input  id="confirmpassword" name="confirmpassword" type="password" class="form-control input-border-bottom" required> -->
					
				</div>
				<div class="form-group ">
				<label for="mobile" class="placeholder">Mobile</label>
				<form:input id="mobileNum" path="mobileNumber" onkeypress="return isNumber(event);" onchange="ValidateNumber(this.id)" class="form-control input-border-bottom"  />
				
				</div>
                <div class="form-group " id="regionDiv" onchange="getUsername();">
				<label for="Type" class="Type">Region</label>
                <form:select id="region" path="region" name="region" class="form-control" >
                
                </form:select>
                 <!-- <span id="regionIdMsg" style="color:red;display:none;font-size:15px">Region Already Exists</span>--> 
                </div>
				<form:hidden path="createdDate" id="createdDate" value="" />
				<div class="form-action">
					<a href="home" id="show-signin" class="btn btn-rounded btn-login mr-3" style="background-color: #E4002B;color: white;">Cancel</a>
					<input type="submit" id="submit" value="Add" class="btn btn-rounded btn-login" style="background-color: #012169;color: white;">
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