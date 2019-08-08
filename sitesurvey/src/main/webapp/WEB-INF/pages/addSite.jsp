<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
	  //getRegions();
		
		//$("#type,#username,#emailId,#pwd,#cpwd,#mobileNum,#region").attr('required', '');  
		 $(".isa_success").fadeOut(10000);
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


	
	function getStates()
	{	
		selectedRegion=$('#regions').val();
	
		$.ajax({
		         type:"get",
		         url:"getStates",
		         contentType: 'application/json',
		         datatype : "json",
		         data:{"selectedRegion":selectedRegion},
		         success:function(data1) {
// 		         	jsonData = JSON.parse(data1);
// 		         	populateDropdown(jsonData,"states");
					var select = document.getElementById("states");
					for(index in data1) {
					    select.options[select.options.length] = new Option(data1[index], index);
					}
				},
		         error:function()
		         {
		         	console.log("Error");
		         }
		 	});	
	}
	
	
	function getDistricts()
	{	
		selectedRegion=$('#regions').val();
		selectedstate=$('#states').val();
		
		$.ajax({
		         type:"get",
		         url:"getDistricts",
		         contentType: 'application/json',
		         datatype : "json",
		         data:{"selectedRegion":selectedRegion,"selectedstate":selectedstate},
		         success:function(data1) {
// 		         	jsonData = JSON.parse(data1);
// 		         	populateDropdown(jsonData,"states");
					var select = document.getElementById("districts");
					for(index in data1) {
					    select.options[select.options.length] = new Option(data1[index], index);
					}
				},
		         error:function()
		         {
		         	console.log("Error");
		         }
		 	});	
	}
	
	function getCities()
	{	
		selectedRegion=$('#regions').val();
		selectedstate=$('#states').val();
		selectedDistrict=$('#districts').val();
		$.ajax({
		         type:"get",
		         url:"getCities",
		         contentType: 'application/json',
		         datatype : "json",
		         data:{"selectedRegion":selectedRegion,"selectedstate":selectedstate,"selectedDistrict":selectedDistrict},
		         success:function(data1) {
// 		         	jsonData = JSON.parse(data1);
// 		         	populateDropdown(jsonData,"states");
					var select = document.getElementById("cities");
					for(index in data1) {
					    select.options[select.options.length] = new Option(data1[index], index);
					}
				},
		         error:function()
		         {
		         	console.log("Error");
		         }
		 	});	
	}
	
	function getSiteId()
	{
		var jsonArr1;
			$.ajax({
		        type:"get",
		        url:"getLastSiteId",
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
		        	$('#siteId').val(jsonArr1);	        	
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
    
			<h3 class="text-center">Add Site</h3>
				<span id="msg" style="color:red;font-size:12px;">*All Fields are Mandatory*</span><br><br>
			<form:form action="saveSite" method="post" modelAttribute="Site" >
			<div class="login-form">
			
				
				 <br>
				<label for="Site ID" class="placeholder">Site ID</label>
				<form:input id="siteid" path="siteid" class="form-control input-full filled" />
				<br>
				<label for="latitude" class="placeholder">latitude</label>
				<form:input id="latitude" path="latitude" class="form-control input-full filled"     />
				<br>
				
				<label for="longitude" class="placeholder">longitude</label> 
				<form:input id="longitude" path="longitude" autocomplete="new-password" name="longitude"  class="form-control input-full filled"  />
				<br>
               
				<label for="Region" class="region">Region</label>
                <form:select id="regions" path="region" name="regions" class="form-control input-full filled" onchange="getStates()">
                <form:option value = "NONE" label = "Select"/>
                 <form:options items = "${regionsList}"></form:options>
                </form:select>
                <br>
                
                <label for="State" class="state">State</label>
                <form:select id="states" path="state" name="states" class="form-control input-full filled" onblur="getDistricts()">
                </form:select>
              <br>
              <label for="District" class="district">District</label>
                <form:select id="districts" path="district" name="districts" class="form-control input-full filled" onblur="getCities()">
                </form:select>
                <br>
                <label for="cities" class="city">City</label>
                <form:select id="cities" path="city" name="cities" class="form-control input-full filled" >
                </form:select>
               
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