
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<spring:url value="resources/css/styling.css" var="mainCss" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>RFID</title>
	<link href="${mainCss}" rel="stylesheet" />
</head>

	<link rel="icon" href="<c:url value='resources/assets/img/icon.ico' />" type="image/x-icon"/>

	<!-- Fonts and icons -->
	<script src="<c:url value='resources/assets/js/plugin/webfont/webfont.min.js' />"></script>
	
	<script src="<c:url value='resources/js/jquery.min.js' />"></script>
	
	<script src="<c:url value='resources/js/jquery-ui.min.js' />"></script>
	<script src="<c:url value='resources/js/validations.js' />"></script>
	
	<link rel="stylesheet" href="<c:url value='resources/css/jquery-ui.css' />">
	
     
     <!-- CSS Files -->	
	<link rel="stylesheet" href="<c:url value='resources/assets/css/bootstrap.min.css' />">
	<link rel="stylesheet" href="<c:url value='resources/assets/css/azzara.min.css' />">

<script type="text/javascript">


function validatePassword()
{
	if(document.getElementById('pwd').value==document.getElementById('cpwd').value)
		{}
	else {
		swal("Please Check", {
			text : "warning",
			buttons: {        			
				confirm: {
					className : 'btn btn-warning'
				}
			},
		});
		$('#cpwd').val('');
	}

}

$(document).ready(function(){	
	dateFun();
		$("#username,#emailId,#mobileNum,#pwd,#cpwd").attr('required', '');  
});

function dateFun()
{
	var today = new Date();
	document.getElementById('createdDate').value=today;
}


</script>
<body  class="login">
<div class="wrapper wrapper-login">
  <div class="container container-signup animated fadeIn">
			<h3 class="text-center">Sign Up</h3>
			<form:form action="saveUser" method="post" modelAttribute="User">
			<div class="login-form">
			
				<div class="form-group form-floating-label">
				<form:input id="username" path="username" class="form-control input-border-bottom"/>
					
					<label for="username" class="placeholder">Username</label>
				</div>
				<div class="form-group form-floating-label">
				<form:input id="emailId" path="emailId" class="form-control input-border-bottom"  onchange="validateEmailId(this.value,this.id)"  />
					<!-- <input  id="email" name="email" type="email" class="form-control input-border-bottom" required>-->
					<label for="email" class="placeholder">Email</label>
				</div>
				<div class="form-group form-floating-label">
				<form:input id="mobileNum" path="mobileNumber" onkeypress="return isNumber(event);" onchange="ValidateNumber(this.id)" class="form-control input-border-bottom"  />
				<label for="mobile" class="placeholder">Mobile</label>
				</div>
				<div class="form-group form-floating-label">
				<form:password id="pwd" path="password" name="passwordsignin" class="form-control input-border-bottom"  />
					<!-- <input  id="passwordsignin" name="passwordsignin" type="password" class="form-control input-border-bottom" required>-->
					<label for="passwordsignin" class="placeholder">Password</label> 
<!-- 					<div class="show-password"> -->
<!-- 						<i class="flaticon-interface"></i> -->
<!-- 					</div> -->
				</div>
				<div class="form-group form-floating-label">
				<form:password id="cpwd" path="" onchange="validatePassword()" name="confirmpassword" class="form-control input-border-bottom"  />
					<!-- <input  id="confirmpassword" name="confirmpassword" type="password" class="form-control input-border-bottom" required> -->
					<label for="confirmpassword" class="placeholder">Confirm Password</label>
					<div class="show-password">
						<i class="flaticon-interface"></i>
					</div>
				</div>
				
				<div class="form-group form-floating-label">
				  <label for="Type" class="Type">Type of User</label>
                <form:select id="type" path="type" name="type" class="form-control input-border-bottom"  >
                	<form:option value="Admin">Admin</form:option>
                	<form:option value="SystemAdmin">System Admin</form:option>
                	<form:option value="FeildExecutive">Feild Executive</form:option>
                </form:select>
                </div>
				
				<form:hidden path="createdDate" id="createdDate" value="" />
<!-- 				<div class="row form-sub m-0"> -->
<!-- 					<div class="custom-control custom-checkbox"> -->
<!-- 						<input type="checkbox" class="custom-control-input" name="agree" id="agree"> -->
<!-- 						<label class="custom-control-label" for="agree">I Agree the terms and conditions.</label> -->
<!-- 					</div> -->
<!-- 				</div> -->
				<div class="form-action">
					<a href="/RFIDAssetTracking" id="show-signin" class="btn btn-danger btn-rounded btn-login mr-3">Cancel</a>
					<input type="submit" value="Sign Up" class="btn btn-primary btn-rounded btn-login">
				</div>
			</div>
			</form:form>			
		</div>
</div>
</body>


	
	<script src="<c:url value='resources/assets/js/core/jquery.3.2.1.min.js' />"></script>
	<script src="<c:url value='resources//assets/js/plugin/jquery-ui-1.12.1.custom/jquery-ui.min.js' />"></script>
	<script src="<c:url value='resources/assets/js/core/popper.min.js' />"></script>
	<script src="<c:url value='resources/assets/css/bootstrap.min.css' />"></script>
	<script src="<c:url value='resources/assets/js/ready.js' />"></script>
	
	</html> 