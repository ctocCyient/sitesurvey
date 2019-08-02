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
	<script >
		$(document).ready(function() {			
			  $("#navbar").load('<c:url value="/resources/common/header.jsp" />'); 
			  $("#sidebar").load('<c:url value="/resources/common/sidebar.jsp" />');
			  dateFun();
			  //getExecutiveId();
			  getRegion();
			  $(".isa_success").fadeOut(5000);
			
		});
		WebFont.load({
			google: {"families":["Open+Sans:300,400,600,700"]},
			custom: {"families":["Flaticon", "Font Awesome 5 Solid", "Font Awesome 5 Regular", "Font Awesome 5 Brands"], urls: ["<c:url value='resources/assets/css/fonts.css' />"]},
			active: function() {
				sessionStorage.fonts = true;
			}
		});
	
		function dateFun()
		{
			var today = new Date();
			document.getElementById('createdDate').value=today;
		}
		
		function populateDropdown(data,id)
		{
			var	catOptions="<option value='Select'>Select</option>";
         	for (i in data) {
         		
           	 	 catOptions += "<option>" + data[i] + "</option>";
         		}
         		document.getElementById(id).innerHTML = catOptions;
         		$("select option[value='Select']").attr('disabled','disabled');
		}
		
		function getRegion()
		 { 
			 	
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
		
		function getManager()
		{
			var execName=$("#executiveName").val();
			$("#executiveID").val(execName);
			var selectedRegion=$("#region").val();
			$.ajax({
		         type:"get",
		         url:"getManager",
		         contentType: 'application/json',
		         datatype : "json",
		         data:{"selectedRegion":selectedRegion},
		         success:function(data1) {
		         	jsonData = JSON.parse(data1);
		         	$("#manager").val(jsonData[0]);
		         	getCity(selectedRegion);
		         	if(jsonData.length==0)
		         	{
		         		$("#managerIdMsg").css("display","block");
		         		$("#submit").attr('disabled',true);
		         	}
		         	else
		         	{
		         		$("#managerIdMsg").css("display","none");
		         		$("#submit").attr('disabled',false);
		         	}
		         	
		         },
		         error:function()
		         {
		         	console.log("Error");
		         }
		 	});
		}
		
		function getCity(selectedRegion)
		 { 
			
			 $.ajax({
			         type:"get",
			         url:"getCity",
			         contentType: 'application/json',
			         datatype : "json",
			         data:{"selectedRegion":selectedRegion},
			         success:function(data1) {
			         	jsonData = JSON.parse(data1);
			         	populateDropdown(jsonData,"city");
			         },
			         error:function()
			         {
			         	console.log("Error");
			         }
			 	});
			
			}
		 
		
	 	function getExecutiveId()
		{
			var jsonArr1;
				$.ajax({
			        type:"get",
			        url:"getLastExecutiveId",
			        contentType: 'application/json',
			        datatype : "json",
			        success:function(data) {
			        	var jsonArr=JSON.parse(data);	        	
			        	 if(jsonArr.length==0){
				        		jsonArr1="TECH001";
				        	}  	
			        	 else{
				        	var dataSplit=jsonArr[0].split("H");
				        	console.log(dataSplit[0]);
				        	var dataSplitInt=parseInt(dataSplit[1]);
				        	console.log(dataSplitInt+1);
				        	dataSplitInt=dataSplitInt+1;
				        	
				        	if(dataSplitInt>0&&dataSplitInt<=9)
				        		jsonArr1="TECH00"+dataSplitInt;
				        	else if(dataSplitInt>9&&dataSplitInt<99)
				        		jsonArr1="TECH0"+dataSplitInt;
				        	else if(dataSplitInt>99)
				        		jsonArr1="TECH"+dataSplitInt;        	
		        		}	        	
			        	$('#executiveID').val(jsonArr1);	        	
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
</style>
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
		  <div align="center"><span class="isa_success" style="color:#012169;font-size:20px">${status}</span></div>	<br><br>
			<h3 class="text-center">Add Field Technician</h3>	
				
        <form:form action="saveExecutive" method="post" modelAttribute="Executive">
       
               <div class="login-form">
				
                <form:hidden id="executiveID" path="executiveId" name="executiveID" class="form-control input-solid" readonly="true" />
            	
            	<label for="executiveName" class="placeholder">Technician Name</label>
            	<form:input id="executiveName" path="executiveName" name="executiveName" class="form-control input-border-bottom"  />
            	<label for="emailID" class="placeholder">Email ID</label>
            	<form:input id="emailID" path="emailId" name="emailID" class="form-control input-border-bottom" /> 
            	<label for="password" class="placeholder">Password</label>
            	<form:input type="password" id="password" path="password" name="password" class="form-control input-border-bottom"  />
            	
            	<label for="mobile" class="placeholder">Mobile</label>
                <form:input id="mobile" path="mobile" name="mobile" class="form-control input-border-bottom" />
                            	
            	           	
            	
           		 <label for="region" class="placeholder">Region</label>
                <form:select id="region" path="region" name="region" class="form-control input-border" onchange="getManager();" />
                
                 <label for="city" class="placeholder">City</label>
                <form:select id="city" path="city" name="city" class="form-control input-border"  />
               
                <label for="region" class="placeholder">Manager</label>
                <form:input id="manager" path="manager" name="manager" class="form-control input-border" readonly="true" />
				 <span id="managerIdMsg" style="color:red;display:none;font-size:15px">Assign Manager to that Region</span> 
					<form:hidden path="createdDate" id="createdDate" value="" />                           
                          
                <div class="form-action">
					<a href="home" id="" class="btn btn-rounded btn-login mr-3" style="background-color: #E4002B;color: white;">Cancel</a>
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