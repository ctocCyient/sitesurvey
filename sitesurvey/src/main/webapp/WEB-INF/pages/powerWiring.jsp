<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html >
<html lang="en">
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

.error {
	color: #ff0000;
	font-style: italic;
	font-weight: bold;
}
</style>
<head>

<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="icon" href="<c:url value='resources/assets/img/icon.ico' />" type="image/x-icon"/>

<title>Site Survey</title>

	<meta content='width=device-width, initial-scale=1.0, shrink-to-fit=no' name='viewport' />
	<script src="<c:url value='resources/js/jquery.min.js' />"></script>
	
	<script src="<c:url value='resources/js/jquery-ui.min.js' />"></script>
	<script src="<c:url value='resources/js/validations.js' />"></script>
	
	<link rel="stylesheet" href="<c:url value='resources/css/jquery-ui.css' />">	
</head>
<!--	<script type="text/javascript">
	role=sessionStorage.getItem("role");
	   if(sessionStorage.getItem("username")==null)
   	{
		//window.location.href = "/sitesurvey/";
		//alert(sessionStorage.getItem("username"));
		   url = "/sitesurvey/";
		      $( location ).attr("href", url);
   	}
	   else if(role=="Admin" | role=="SuperAdmin")
		   {
		   
		   }
	   else
		   {
		   url = "/sitesurvey/";
		      $( location ).attr("href", url);
		   }
	   

</script>-->


		

     
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
	  //document.getElementById("accesstypespan").style.display = "none";
	  //document.getElementById("roadcondspan").style.display = "none";
	  //document.getElementById("commntsspan").style.display = "none";
	  //document.getElementById("image1sspan").style.display = "none";
	  //document.getElementById("image2sspan").style.display = "none";
	//  getRegions();
		//getSiteId();
		//$("#type,#username,#emailId,#pwd,#cpwd,#mobileNum,#region").attr('required', '');  
		 $(".isa_success").fadeOut(10000);
		 $("input").attr("required", "true");
		
		 $("select").attr("required","true");
		 $("select option:contains('Select')").attr("disabled","disabled");
		
});

function redirectToOther()
{
	window.location.href = "/sitesurvey/siteArea";
} 

/*function validate(){
	var accesstype=document.getElementById("accesstype").value;
	var roadcond=document.getElementById("condition").value;
	alert(roadcond);
	var commnts=document.getElementById("obsrvcommnts").value;
	 
	var image1=document.getElementById("photo1up").value;
	var image2=document.getElementById("photo2up").value;
	
	if(accesstype ==="Select"){
		 document.getElementById("accesstypespan").style.display = "block";
		 return false;
   }
	else{
		 document.getElementById("accesstypespan").style.display = "none";
		 
	}
	
	if(roadcond ==="Select"){
		 document.getElementById("roadcondspan").style.display = "block";
		 return false;
  }
	else{
		 document.getElementById("roadcondspan").style.display = "none";
		 
	}

	if(commnts ===""){
		 document.getElementById("commntsspan").style.display = "block";
		 return false;
 }
	else{
		 document.getElementById("commntsspan").style.display = "none";
		 
	}
	if(image1 ===""){
		 document.getElementById("image1span").style.display = "block";
		 return false;
}
	else{
		 document.getElementById("image1sspan").style.display = "none";
		 
	}
	if(image2 ===""){
		 document.getElementById("image2span").style.display = "block";
		 return false;
 }
	else{
		 document.getElementById("image2sspan").style.display = "none";
		 
	}
}*/


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
<%--   <body  class="login">

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
    
			<h3 class="text-center">ACCESS</h3>
				<span id="msg" style="color:red;font-size:12px;">*All Fields are Mandatory*</span><br><br>
			<form action="saveAccess" method="post" modelAttribute="Site_Access" >
			<div class="login-form">
			
				
				 <br>
				<label for="AccessType" class="placeholder">Access Type</label>
				<input id="accesstype" path="accessType" class="form-control input-full filled" />
				<br>
				<label for="Condition" class="placeholder">Condition</label>
				<input id="condition" path="roadCondition" class="form-control input-full filled"     />
				<br>
				
				<label for="ObservationComments" class="placeholder">Observation/Comments</label> 
				<input id="obsvcommnts" path="comments"  name="obsvcommnts"  class="form-control input-full filled"  />
				<br>
               
				
               <!-- href="home" -->
				<div class="form-action">
					
<!-- 					<input type="submit" id="submit" value="Save" class="btn btn-rounded btn-login" style="background-color: #012169;color: white;"> -->
					<input type="submit" id="submit" value="Save and Continue" class="btn btn-rounded btn-login" style="background-color: #012169;color: white;">
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



</body>  --%>
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
  <span class="isa_success" style="color:green;font-size:14px;">${status}</span>
			<h3 class="text-center">Power Wiring</h3>
			
			<form:form method="post" action="saveWiring"  id="siteWiring" modelAttribute="Site_Wiring" enctype="multipart/form-data" >
			<div class="login-form">	

					                
	          <div id="exchangeExistDiv">
	          <form:hidden path="id"/>
					<div class="form-group">
					<label for="siteid" class="placeholder">Site ID</label>
	                <form:input id="siteid" path="siteid.siteid" name="siteid" class="form-control input-border "  />	
	                         
	            	</div>
            	</div>
          		

				  <div id="exchangeExistDiv" >
					<div class="form-group">
					<label for="condition" class="placeholder">Condition</label>
	                <form:select id="wiringCondition"  path="wiringCondition" name="wiringCondition" class="form-control input-border " >
	                <form:option  value="" >Select</form:option>
	                <form:option value="Notassessed">Not assessed</form:option>
	                <form:option value="VeryPoor">Very Poor(Safety risk, major fault risk, poor operation)</form:option>
	                <form:option value="Poor">Poor</form:option>
	                <form:option value="Fair"> Fair(Wiring on routes and in boxes/DBboarads needs work through is operational)</form:option>
	                <form:option value="Good">Good</form:option>
	                <form:option value="VeryGood">Very good</form:option>
	                <form:option value="Notapplicable">Not applicable</form:option>
	                </form:select>	  
	                 <!--<span id="roadcondspan" style="color:red">*Please Select Road Condition*</span> -->            
	            	</div>
            	</div>
				
				<div id="exchangeExistDiv">
					<div class="form-group">
					<label for="obsrvcommnts" class="placeholder">Observations/Comments</label>
	                <form:input id="obsrvcommnts" path="comments" name="obsrvcommnts" class="form-control input-border " />	   
	                <!-- <span id="commntsspan" style="color:red">*Please Enter Comments*</span>-->                  
	            	</div>
            	</div>
                
                <div id="exchangeExistDiv">
					<div class="form-group">
					<label for="photo1up" class="placeholder">Upload Image1(Photo 1) </label>
	                <input type="file" id="site_photo1" name="file" accept="image/*" class="form-control input-border" />	
	                <!--<span id="image1sspan" style="color:red">*Please Upload Image*</span> -->         
	            	</div>
	            
            	</div>
				 <div id="exchangeExistDiv">
					<div class="form-group">
					<label for="photo2up" class="placeholder">Upload Image2(Photo 2) </label>
	                <input type="file" id="site_photo1" name="file" accept="image/*" class="form-control input-border" />	
	                <!--<span id="image2sspan" style="color:red">*Please Upload Image*</span> -->              
	            	</div>
	            
            	</div>
				
                 
				<div class="form-action" id="typeDiv">	
				    <input type="submit" id="submit" name="clickBtn" value="Save" class="btn btn-rounded btn-login" style="background-color: #E4002B;color: white;">
<!-- 					<input  type="submit" id="submit1" name="clickBtn" value="Save & Continue" class="btn btn-rounded btn-login"  style="background-color: #012169;color: white;"> -->
<a href="newGenerator">Next</a>
					
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