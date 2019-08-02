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
     
<script src="<c:url value='resources/assets/js/plugin/webfont/webfont.min.js' />"></script>
<link rel="stylesheet" href="<c:url value='resources/assets/css/bootstrap.min.css' />">
	<link rel="stylesheet" href="<c:url value='resources/assets/css/azzara.min.css' />">
	<script >
		$(document).ready(function() {			
			  $("#navbar").load('<c:url value="/resources/common/header.jsp" />'); 
			  $("#sidebar").load('<c:url value="/resources/common/sidebar.jsp" />'); 
		});
		WebFont.load({
			google: {"families":["Open+Sans:300,400,600,700"]},
			custom: {"families":["Flaticon", "Font Awesome 5 Solid", "Font Awesome 5 Regular", "Font Awesome 5 Brands"], urls: ["<c:url value='resources/assets/css/fonts.css' />"]},
			active: function() {
				sessionStorage.fonts = true;
			}
		});
	
	</script>
	</head>
<body class="login">


  
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
			<h3 class="text-center">Add Exchange</h3>
        <form:form action="saveExchange" method="post" modelAttribute="Exchange">
        <div class="login-form">
        		<form:hidden path="id"/>
				<div class="form-group form-floating-label">
                <form:select id="region" path="region" name="region" class="form-control input-border-bottom"/>
            	<label for="region" class="placeholder">Region</label>
            	</div>
				<div class="form-group form-floating-label">
            	<form:select id="district" path="district" name="district" class="form-control input-border-bottom"  />
            	<label for="district" class="placeholder">District</label>
            	</div>
            	<div class="form-group form-floating-label">
                <form:select id="city" path="city" name="city" class="form-control input-border-bottom" />
                <label for="city" class="placeholder">City</label>
            	</div>
            	<div class="form-group form-floating-label">
            	<form:input id="area" path="area" name="area" class="form-control input-border-bottom" />
            	<label for="area" class="placeholder">Area</label>
            	</div>
           		<div class="form-group form-floating-label">
                <form:input id="exchangeName" path="exchangeName" name="exchangeName" class="form-control input-border-bottom"  />
                <label for="exchangeName" class="placeholder">Exchange Name</label>
                </div>        
                <div class="form-action">
					<a href="home" id="" class="btn btn-danger btn-rounded btn-login mr-3">Cancel</a>
					<input type="submit" value="Add" class="btn btn-primary btn-rounded btn-login">
				</div>
                
	           
	           </div>
       
        </form:form>
    </div>
    </div>
    
    
	<script src="<c:url value='resources//assets/js/plugin/jquery-ui-1.12.1.custom/jquery-ui.min.js' />"></script>
	<script src="<c:url value='resources/assets/css/bootstrap.min.css' />"></script>
	<script src="<c:url value='resources/assets/js/ready.js' />"></script>
	<script src="<c:url value='resources/assets/js/core/jquery.3.2.1.min.js' />"></script>
	<script src="<c:url value='resources/assets/js/core/popper.min.js' />"></script>
	<script src="<c:url value='resources/assets/js/core/bootstrap.min.js' />"></script>
</body>
</html>