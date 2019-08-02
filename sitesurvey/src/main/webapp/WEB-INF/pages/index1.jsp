<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<title>RFID</title>
	<meta content='width=device-width, initial-scale=1.0, shrink-to-fit=no' name='viewport' />
	<script src="<c:url value='resources/js/jquery.min.js' />"></script>
	
	<script src="<c:url value='resources/js/jquery-ui.min.js' />"></script>
	<script src="<c:url value='resources/js/validations.js' />"></script>
	
	<link rel="stylesheet" href="<c:url value='resources/css/jquery-ui.css' />">
	
	<link rel="icon" href="<c:url value='resources/assets/img/icon.ico' />" type="image/x-icon"/>

	<!-- Fonts and icons -->
	<script src="<c:url value='resources/assets/js/plugin/webfont/webfont.min.js' />"></script>
	<script>
		WebFont.load({
			google: {"families":["Open+Sans:300,400,600,700"]},
			custom: {"families":["Flaticon", "Font Awesome 5 Solid", "Font Awesome 5 Regular", "Font Awesome 5 Brands"], urls: ['../assets/css/fonts.css']},
			active: function() {
				sessionStorage.fonts = true;
			}
		});
	</script>
	
	<script>
 	$(document).ready(function(){	
		 $("select option[value='Select']").attr('disabled','disabled');
 		// 		dateFun();
// // 		$("#userName,#emailId,#mobileNum,#pwd,#cpwd").attr('required', '');  
 	});

// 	function dateFun()
// 	{
// 	var today = new Date();
// 		document.getElementById('createdDate').value=today;
// 	}


	
	</script>
	<style>
.fa-bars,
.fa-ellipsis-v
{
color: #fff!important;
}
.bg
{

background-image:url("<c:url value='resources/assets/img/rfid3.jpg' />");
background-repeat: no-repeat;
background-size: 100%;

  

}
div.absolute {
  position: absolute;
  top: 50px;
  right: 50px;
  border: 3px solid #73AD21;
  
}
.fa-bars,
.fa-ellipsis-v
{
color: #fff!important;
}
.login .wrapper1.wrapper-login
{
display: flex;
    justify-content: center;
    align-items: center;
    height: unset;
    padding: 15px;
}
.wrapper1
{
	
    min-height: 84vh;
    position: relative;
    top: 0;
}
.login .wrapper1.wrapper-login .container-login, .login .wrapper1.wrapper-login .container-signup {
    width: 400px;
    background: #fff;
    padding: 60px 25px;
    border-radius: 5px;
    -webkit-box-shadow: 0 0.75rem 1.5rem rgba(18,38,63,.03);
    -moz-box-shadow: 0 .75rem 1.5rem rgba(18,38,63,.03);
    box-shadow: 0 0.75rem 1.5rem rgba(18,38,63,.03);
    border: 1px solid #ebecec;
}
 .login .wrapper1.wrapper-login .container-login .form-action, .login .wrapper1.wrapper-login .container-signup .form-action {
    text-align: center;
    padding: 25px 10px 0;
}
.login .wrapper1.wrapper-login .container-login .btn-login, .login .wrapper1.wrapper-login .container-signup .btn-login {
    padding: 10px 0;
    width: 100px;
    font-size: 17px;
    
}
.btn-primary1
{
background:#0645ad!important;
border-color:#0645ad!important;
color:#ffffff;
}
.login .wrapper1.wrapper-login .loginNmsDet {
    position: absolute;
    
    left: 2%;
    width: 750px;
    font-size: 13px;
    color: #555;
}

</style>
	<!-- CSS Files -->	
	<link rel="stylesheet" href="<c:url value='resources/assets/css/bootstrap.min.css' />">
	<link rel="stylesheet" href="<c:url value='resources/assets/css/azzara.min.css' />">

</head>
<body class="login " >
<div class="logo-header"  >
				&nbsp;&nbsp;
				<a  class="logo" >
				
					<img src="<c:url value='resources/assets/img/logo.png' />" alt="navbar brand" class="navbar-brand">
				</a>
				
				
				
			</div>
<!-- <div style="width:100%;height:35%"> -->
<%-- <img style="width:100%;height:100%" src="<c:url value='resources/assets/img/rfid3.jpg' />" /> --%>
<!-- </div> -->

	<div class="bg wrapper1 wrapper-login  " >
		<div  class="absolute container container-login animated fadeIn ">
			<h3 class="text-center">Login</h3>
			        <form:form action="validateUser" method="post" modelAttribute="User">
			<div class="login-form">
				<div class="form-group form-floating-label">
				
				<form:input  path="username" id="username" name="username"  class="form-control input-border-bottom" />
				
				<!-- 	<input id="username" name="username" type="text" class="form-control input-border-bottom" required> -->
					<label for="username" class="placeholder">Username</label>
				</div>
				<div class="form-group form-floating-label">
				<form:password path="password" id="password" name="password" class="form-control input-border-bottom" />
					<!--  <input id="password" name="password" type="password" class="form-control input-border-bottom" required>-->
					<label for="password" class="placeholder">Password</label>
					<div class="show-password">
						<i class="flaticon-interface"></i>
					</div>
				</div>
				
				<div class="form-group form-floating-label">
				<label for="Type" class="Type"> Role</label>
                <form:select id="type" path="type" name="type" class="form-control"  >
                <form:option value="Select">Select</form:option>
                	<form:option value="SuperAdmin">SuperAdmin</form:option>
                	<form:option value="Admin">Admin</form:option>
                	<form:option value="Manager">Manager</form:option>
                	<form:option value="FeildExecutive">Field Technician</form:option>                	
                </form:select>
                </div>

				<div class="form-action mb-3">
				<input  type="submit" class="btn btn-primary1 btn-rounded btn-login" value="Sign In">
				
				</div>
				
			</div>
						
			        </form:form>
			    
		</div>
		 
		
	</div>
	<div class="loginNmsDet">
			<b>Cyient TOC Platform</b> is an award-winning platform with open APIs that facilitates developers to build rapid IoT solutions. It is build over the strong WebNMS framework which is deployed more than 25,000 times worldwide. The powerful blend of an advanced rules engine, SDK, and web service APIs facilitates rapid construction of secure, scalable, and cost-effective enterprise IoT applications.
		</div>
	
	
	<script src="<c:url value='resources/assets/js/core/jquery.3.2.1.min.js' />"></script>
	<script src="<c:url value='resources//assets/js/plugin/jquery-ui-1.12.1.custom/jquery-ui.min.js' />"></script>
	<script src="<c:url value='resources/assets/js/core/popper.min.js' />"></script>
	<script src="<c:url value='resources/assets/css/bootstrap.min.css' />"></script>
	<script src="<c:url value='resources/assets/js/ready.js' />"></script>
</body>
</html>