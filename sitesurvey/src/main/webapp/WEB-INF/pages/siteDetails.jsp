<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ticketDetails=(String)request.getParameter("ticketDetails"); %>
<% String status=(String)request.getAttribute("status"); %>
<% String btnClick=(String)request.getAttribute("btnClick"); %>
<!DOCTYPE html >
<html lang="en">

<head>

	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="icon" href="<c:url value='resources/assets/img/icon.ico' />" type="image/x-icon"/>

<title>Site Survey</title>
	<meta content='width=device-width, initial-scale=1.0, shrink-to-fit=no' name='viewport' />
	<script src="<c:url value='resources/js/jquery.min.js' />"></script>
	
	<script src="<c:url value='resources/js/jquery-ui.min.js' />"></script>
	<script src="<c:url value='resources/js/validations.js' />"></script>
	
	<link rel="stylesheet" href="<c:url value='resources/css/jquery-ui.css' />">	
		

     
<script src="<c:url value='resources/assets/js/plugin/webfont/webfont.min.js' />"></script>
<link rel="stylesheet" href="<c:url value='resources/assets/css/bootstrap.min.css' />">
	<link rel="stylesheet" href="<c:url value='resources/assets/css/azzara.min.css' />">
	<script type="text/javascript">
	role=sessionStorage.getItem("role");
	siteId=sessionStorage.getItem("siteId");
	ticketId=sessionStorage.getItem("ticketId");
	   if(sessionStorage.getItem("username")==null)
   	{
		//window.location.href = "/sitesurvey/";
		//alert(sessionStorage.getItem("username"));
		   url = "/sitesurvey/";
		      $( location ).attr("href", url);
   	}
	
</script>



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

		
		// $(".isa_success").fadeOut(10000);
		 var siteDetails=<%=ticketDetails%>;
<%-- 		 var status='<%=status%>'; --%>
<%-- 		 var btnClick='<%=btnClick%>'; --%>
		
		 console.log("site"+JSON.stringify(siteDetails));
		 if(siteDetails!=null){
			 $('#siteId,#latitude,#longitude,#state').attr('readonly','readonly');
// 			 $('#state').val(siteDetails[0].state);
			  $("#state")[0].value=siteDetails[0].state;
			  $("#siteId")[0].value=siteDetails[0].siteid;			  
			  $("#latitude")[0].value=siteDetails[0].latitude;
			  $("#longitude")[0].value=siteDetails[0].longitude;
		 }
		 
// 		 if(status=='Saved')
// 		{
// 			 	var nextUrl;
// 			  if(btnClick=="Save"){
// 				  nextUrl="/sitesurvey/home";
// 			  }
// 			  else if(btnClick=="Save & Continue"){
// 				  nextUrl="/sitesurvey/surveyTeamPPE";
// 			  }
// 			  swal({
// 					//title: 'Are you sure?',
// 					text: "Details Saved Successfully",
// 					type: 'info',
// 					buttons:{
// 						confirm: {
// 							text : 'Ok',
// 							className : 'btn btn-success'
// 						}
// 					}
// 				}).then((Delete) => {
// 					if (Delete) {
// 						window.location.href = nextUrl;
// 					} 
// 				});
// 			}
});

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
<div id="technicianSidebar">
</div>
		<!-- End Sidebar -->
		
<div class="wrapper wrapper-login">
  <div class="container container-login animated fadeIn">
  
    
			<h3 class="text-center">Site Details</h3>
				
			<form:form action="saveSiteDetails" method="post" modelAttribute="SiteDetails">
			<div class="login-form">
			
				 <br>
<!-- 				 	<label for="state" class="state">State</label> -->
<%--               	 <form:select id="state" path="state"  name="state"  class="form-control input-full filled" > --%>
<%--               	<form:options items = "${statesList}" />              	 --%>
<%--               	 </form:select> --%>
				<label for="state" class="placeholder">State</label>
				<form:input id="state" path="state" class="form-control input-full filled" />
              	 <br>
				<label for="siteId" class="placeholder">Site Id</label>
				<form:input id="siteId" path="siteid" class="form-control input-full filled" />
				<br>
				<label for="latitude" class="placeholder">Latitude</label>
				<form:input id="latitude" path="latitude" class="form-control input-full filled" />
				<br>
				<label for="longitude" class="placeholder">Longitude</label> 
				<form:input id="longitude" path="longitude"  name="longitude"  class="form-control input-full filled"  />
				<br>
                       
				<div class="form-action">
				
<!-- 					<input type="submit" id="clickBtn" value="Save" class="btn btn-rounded btn-login" name="clickBtn" style="background-color: #E4002B;color: white;"> -->
<!--  					<input type="submit" id="clickBtn1" value="Save & Continue" class="btn btn-rounded btn-login" name="clickBtn" style="background-color: #012169;color: white;">  -->
					<a href="surveyTeamPPE" class="btn btn-rounded btn-login" style="background-color: #E4002B;color: white;">Next</a> 
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


<!-- Sweet Alert -->

<script src="<c:url value='resources/assets/js/plugin/sweetalert/sweetalert.min.js' />"></script>

<!-- jQuery Sparkline -->

<script src="<c:url value='resources/assets/js/plugin/jquery.sparkline/jquery.sparkline.min.js' />"></script>



</body>

</html>