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
			  getTicketId();
			  getRegion();
			  dateFun();
			 // $("select option[value='Select']").attr('disabled',true);
			  
		});
		WebFont.load({
			google: {"families":["Open+Sans:300,400,600,700"]},
			custom: {"families":["Flaticon", "Font Awesome 5 Solid", "Font Awesome 5 Regular", "Font Awesome 5 Brands"], urls: ["<c:url value='resources/assets/css/fonts.css' />"]},
			active: function() {
				sessionStorage.fonts = true;
			}
		});
		
var jsonData=[];

		function populateDropdown(data,id)
		{
			var	catOptions="<option>Select</option>";
         	for (i in data) {
         		
           	 	 catOptions += "<option>" + data[i] + "</option>";
         		}
         		document.getElementById(id).innerHTML = catOptions;
	
		}

		 function getTicketId()
			{
				var jsonArr1;
					$.ajax({
				        type:"get",
				        url:"getLastTicketId",
				        contentType: 'application/json',
				        datatype : "json",
				        success:function(data) {
				        	var jsonArr=JSON.parse(data);	        	
				        	 if(jsonArr.length==0){
					        		jsonArr1="TKT-PL-100";

					        	}  	
				        	 else{
					        	var dataSplit=jsonArr[0].split("L-");
					        	console.log(dataSplit[0]);
					        	var dataSplitInt=parseInt(dataSplit[1]);
					        	console.log(dataSplitInt+1);
					        	dataSplitInt=dataSplitInt+1;
					        	
					        	if(dataSplitInt>0&&dataSplitInt<=9)
					        		jsonArr1="TKT-PL-10"+dataSplitInt;
					        	else if(dataSplitInt>9&&dataSplitInt<99)
					        		jsonArr1="TKT-PL-1"+dataSplitInt;
					        	else if(dataSplitInt>99)
					        		jsonArr1="TKT-PL-"+dataSplitInt;        	
			        		}	        	
				        	$('#ticketId').val(jsonArr1);	        	
				        },
				        error:function()
				        {
				        	console.log("Error");
				        }
					});
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
		 
		 
		 function getExchange(value)
		 { 
			 	var selectedRegion=value;
			 	
			 	$.ajax({
			         type:"get",
			         url:"getExchange",
			         contentType: 'application/json',
			         datatype : "json",
			         data:{"selectedRegion":selectedRegion},
			         success:function(data1) {
			        	 jsonData = JSON.parse(data1);
				         populateDropdown(jsonData,"exchange");
			         },
			         error:function()
			         {
			         	console.log("Error");
			         }
			 	});
			 }
		 
		 function getFloor(value)
		 { 
			 	var selectedExchange=value;
			 	
			 	$.ajax({
			         type:"get",
			        url:"getFloor",
			         contentType: 'application/json',
			         datatype : "json",
			         data:{"selectedExchange":selectedExchange},
			         success:function(data1) {
			        	 jsonData = JSON.parse(data1);
				         populateDropdown(jsonData,"floor");	
			         },
			         error:function()
			         {
			         	console.log("Error");
			         }
			 	});
			 }
		 
		 function getSuite()
		 { 
			 	var selectedExchange=$("#exchange").val();
			 	var selectedFloor=$("#floor").val(); 
			 	
			 	$.ajax({
			         type:"get",
			         url:"getSuite",
			         contentType: 'application/json',
			         datatype : "json",
			         data:{"selectedExchange":selectedExchange,"selectedFloor":selectedFloor},
			         success:function(data1) {
			        	 jsonData = JSON.parse(data1);
				         populateDropdown(jsonData,"suite");	
			         },
			         error:function()
			         {
			         	console.log("Error");
			         }
			 	});
			 }
		 
		 function getRack()
		 { 
			 	var selectedExchange=$("#exchange").val();
			 	var selectedFloor=$("#floor").val(); 
			 	var selectedSuite=$("#suite").val(); 
			 	
			 	$.ajax({
			         type:"get",
			         url:"getRack",
			         contentType: 'application/json',
			         datatype : "json",
			         data:{"selectedExchange":selectedExchange,"selectedFloor":selectedFloor,"selectedSuite":selectedSuite},
			         success:function(data1) {
			        	 jsonData = JSON.parse(data1);
				         populateDropdown(jsonData,"rack");	
			         },
			         error:function()
			         {
			         	console.log("Error");
			         }
			 	});
			 }
		 
		 function getSubRack()
		 { 
			 	var selectedExchange=$("#exchange").val();
			 	var selectedFloor=$("#floor").val(); 
			 	var selectedSuite=$("#suite").val(); 
			 	var selectedRack=$("#rack").val();
			 	
			 	$.ajax({
			         type:"get",
			         url:"getSubRack",
			         contentType: 'application/json',
			         datatype : "json",
			         data:{"selectedExchange":selectedExchange,"selectedFloor":selectedFloor,"selectedSuite":selectedSuite,"selectedRack":selectedRack},
			         success:function(data1) {
			        	 jsonData = JSON.parse(data1);
				         populateDropdown(jsonData,"sub_rack");
			         },
			         error:function()
			         {
			         	console.log("Error");
			         }
			 	});
			 }
		 
		 function getCustomerId()
		 { 
			 	var selectedExchange=$("#exchange").val();
			 	var selectedFloor=$("#floor").val(); 
			 	var selectedSuite=$("#suite").val(); 
			 	var selectedRack=$("#rack").val();
			 	var selectedSubRack=$("#sub_rack").val();
			 	
			 	$.ajax({
			         type:"get",
			         url:"getCustomerId",
			         contentType: 'application/json',
			         datatype : "json",
			         data:{"selectedExchange":selectedExchange,"selectedFloor":selectedFloor,"selectedSuite":selectedSuite,"selectedRack":selectedRack,"selectedSubRack":selectedSubRack},
			         success:function(data1) {
			        	 jsonData = JSON.parse(data1);
				         populateDropdown(jsonData,"customerId");
			         },
			         error:function()
			         {
			         	console.log("Error");
			         }
			 	});
			 }
		 
		
		 
	
		
			 function getUniqueId()
				{
				var selectedCustomerId=$("#customerId").val();
					var jsonArr1;
						$.ajax({
					        type:"get",
					        url:"getLastUniqueId",
					        contentType: 'application/json',
					        datatype : "json",
					        success:function(data) {
					        	var jsonArr=JSON.parse(data);	        	
					        	 if(jsonArr.length==0){
						        		jsonArr1=selectedCustomerId+"_001";
						        	}  	
					        	 else{
						        	var dataSplit=jsonArr[0].split("K");
						        	console.log(dataSplit[0]);
						        	var dataSplitInt=parseInt(dataSplit[1]);
						        	console.log(dataSplitInt+1);
						        	dataSplitInt=dataSplitInt+1;
						        	
						        	if(dataSplitInt>0&&dataSplitInt<=9)
						        		jsonArr1=selectedCustomerId+"_00"+dataSplitInt;
						        	else if(dataSplitInt>9&&dataSplitInt<99)
						        		jsonArr1=selectedCustomerId+"_0"+dataSplitInt;
						        	else if(dataSplitInt>99)
						        		jsonArr1=selectedCustomerId+"_"+dataSplitInt;        	
				        		}	        	
					        	$('#uniqueId').val(jsonArr1);	        	
					        },
					        error:function()
					        {
					        	console.log("Error");
					        }
						});
				}
			 
			 function dateFun()
				{
					var today = new Date();
				 	var dd = today.getDate();
				 	var mm = today.getMonth() + 1;
				 	var yyyy = today.getFullYear();

				 	if (dd < 10) {
				 	  dd = '0' + dd;
				 	}

				 	if (mm < 10) {
				 	  mm = '0' + mm;
				 	} 

				 	today = yyyy + '-' + mm + '-' + dd;
					document.getElementById('openDate').value=today;
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
			<h3 class="text-center">Add Ticket</h3>
        <form:form action="saveCreatedTicket" method="post" modelAttribute="Ticketing">
        <div class="login-form">
        		<form:hidden path="openDate" id="openDate"/>
				<div class="form-group form-floating-label">
            	<form:select id="region" path="" name="region" class="form-control input-border" onchange="getExchange(this.value);" />
            	<label for="region" class="placeholder">Region</label>
            	</div>
            	<div class="form-group form-floating-label">
                <form:select id="exchange" path="" name="exchange" class="form-control input-border" onchange="getFloor(this.value);" />
                <label for="exchange" class="placeholder">Exchange</label>
            	</div>
            	<div class="form-group form-floating-label">
                <form:select id="floor" path="" name="floor" class="form-control input-border" onchange="getSuite();" />
                <label for="floor" class="placeholder">Floor</label>
            	</div>
            	<div class="form-group form-floating-label">
                <form:select id="suite" path="" name="suite" class="form-control input-border" onchange="getRack();"/>
                <label for="suite" class="placeholder">Suite</label>
            	</div>
            	<div class="form-group form-floating-label">
                <form:select id="rack" path="" name="rack" class="form-control input-border"  onchange="getSubRack();"/>
                <label for="rack" class="placeholder">Rack</label>
            	</div>    
            	 <div class="form-group form-floating-label">
                <form:select id="sub_rack" path="" name="sub_rack" class="form-control input-border" onchange="getCustomerId()"/>
                <label for="sub_rack" class="placeholder">Sub Rack
            	</div>  
            	<div class="form-group form-floating-label">
                <form:select id="customerId" path="customerId" name="customerId" class="form-control input-border"  onchange="getUniqueId();"/>
            	<label for="customerId" class="placeholder">Customer ID</label>
            	</div>
            	<div class="form-group form-floating-label">
                <form:input id="uniqueId" path="uniqueId" name="uniqueId" class="form-control input-solid"  />
            	<label for="uniqueId" class="placeholder">Unique ID</label>
            	</div>
               	<div class="form-group">
					<label for="ticketDescription">Ticket Description</label>
					<textarea class="form-control" id="ticketDescription" path="ticketDescription" rows="5">
					</textarea>
				</div>
            	 	
            	<div class="form-action">
            	<input type="submit" value="Create" class="btn btn-primary btn-rounded btn-login">
					<a href="home" id="show-signin" class="btn btn-danger btn-rounded btn-login mr-3">Cancel</a>
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