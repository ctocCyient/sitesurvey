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
				<script type="text/javascript">
	   if(sessionStorage.getItem("username")==null)
   	{
		   url = "/sitesurvey/";
		  $( location ).attr("href", url);
   	}	
	</script>
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

function validatePassword()
{
	if(document.getElementById('pwd').value==document.getElementById('cpwd').value)
	{
		  $("#pwdIdMsg").css("display","none");
	}
	else {
		  $("#pwdIdMsg").css("display","block");
		$('#cpwd').val('');
	}
}

$(document).ready(function(){	
	 $("#navbar").load('<c:url value="/resources/common/header.jsp" />'); 
	  $("#superAdminSidebar").load('<c:url value="/resources/common/superAdminSidebar.jsp" />'); 
	  //getRegions();
		dateFun();
		$("#type,#username,#name,#emailId,#pwd,#cpwd,#mobileNum").attr('required', '');  
		 $(".isa_success").fadeOut(10000);
		 
		 
		 //$('#type').attr('readonly',true); 
     	$('#type').addClass('input-disabled');
         $("select option:contains('Select')").attr("disabled","disabled");
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

	function dateFun()
	{
		var today = new Date();
		document.getElementById('createdDate').value=today;
	}

/*	function getRegions()
	{	
		$.ajax({
		         type:"get",
		         url:"getRegions",
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
	}*/
	

	function getUserName(){

		var username=$("#username").val();
		var role=$("#type").val();
		$.ajax({
	        type:"get",
	        url:"getUserName",
	        contentType: 'application/json',
	        datatype : "json",
	        data:{"username":username,"role":role},
	        success:function(data1) {
	        	if(data1=="Exists")
	        	{
	        		$("#unameMsg").css("display","block");
	        		$("#unameMsg").val('');
	        		$("#submit").attr('disabled',true);
	        	}
	        	else
	        	{
	        		$("#unameMsg").css("display","none");
	        		$("#name").val(username);
	        		$("#submit").attr('disabled',false);
	        	}
	        },
	        error:function()
	        {
	        	console.log("Error");
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

.login .wrapper.wrapper-login .container-login, .login .wrapper.wrapper-login .container-signup {
    width: 700px;
    background: #fff;
    padding: 74px 40px;
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
<div id="superAdminSidebar">
</div>
		<!-- End Sidebar -->
		
<div class="wrapper wrapper-login">
  <div class="container container-login animated fadeIn">
    <div align="center"><span class="isa_success" style="color:#35B234;font-size:20px">${status}</span></div>	<br><br>
    
			<h3 class="text-center">Add User</h3>
				<span id="msg" style="color:red;font-size:12px;">*All Fields are Mandatory*</span><br><br>
			<form:form action="saveUser" method="post" modelAttribute="User" >
			<div class="login-form">
			
				<label for="Type" class="Type">Role</label>
                <form:select id="type" path="role" name="type" class="form-control">
                <form:option value="Select">Select</form:option>
                	<form:option value="Admin">Admin</form:option>
                	<form:option value="Manager">Manager</form:option>
                </form:select>
              
				 <br>
				<label for="username" class="placeholder">User Name</label>
				<form:input id="username" path="username" class="form-control input-full filled" onkeypress="return isCharacters(event);" onblur="getUserName();"/>
				<span id="unameMsg" style="color:red;display:none;font-size:15px">Username already Exists</span>
				 <br>
				<label for="name" class="placeholder">Full Name</label>
				<form:input id="name" path="name" class="form-control input-full filled" onkeypress="return isCharacters(event);"/>
				<span id="unameMsg" style="color:red;display:none;font-size:15px">Username already Exists</span>				
				<br>
				<label for="email" class="placeholder">Email ID</label>
				<form:input id="emailId" path="emailId" class="form-control input-full filled"   onchange="validateEmailId(this.value,this.id,'emailIdMsg')"  />
				<span id="emailIdMsg" style="color:red;display:none;font-size:15px">Please enter valid Email Id</span>
				<br>
				<label for="passwordsignin" class="placeholder">Password</label> 
				<form:password id="pwd" path="password" autocomplete="new-password" name="passwordsignin"  class="form-control input-full filled"  />
					<!-- <input  id="passwordsignin" name="passwordsignin" type="password" class="form-control input-border-bottom" required>-->
				<br>
				<label for="confirmpassword" class="placeholder">Confirm Password</label>
				<form:password id="cpwd" path="" onchange="validatePassword()" name="confirmpassword" class="form-control input-full filled"  />
					<!-- <input  id="confirmpassword" name="confirmpassword" type="password" class="form-control input-border-bottom" required> -->
					<span id="pwdIdMsg" style="color:red;display:none;font-size:15px">Password must be same</span>
				<br>
				<label for="mobile" class="placeholder">Mobile</label>
				<form:input id="mobileNum" path="mobileNumber" onkeypress="return isNumber(event);" onchange="ValidateNumber(this.id,'mobileIdMsg')" class="form-control input-full filled"  />
				<span id="mobileIdMsg" style="color:red;display:none;font-size:15px">Please enter valid Mobile Number</span>
				<br>
                <div  id="regionDiv" >
				<label for="Type" class="Type">Region</label>
                <form:select id="region" path="region" name="region" class="form-control input-full filled" >
                <form:option value="Select">Select</form:option>
          	   <form:options items="${regionsList}"></form:options>
                </form:select>
                <!--  <span id="regionIdMsg" style="color:red;display:none;font-size:15px">Please Select Region</span>  -->
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