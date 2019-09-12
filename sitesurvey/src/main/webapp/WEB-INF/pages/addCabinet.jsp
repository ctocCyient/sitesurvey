<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html >
<html lang="en">

<head>

<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="icon" href="<c:url value='resources/assets/img/icon.ico' />"
	type="image/x-icon" />

<title>Site Survey</title>
<meta content='width=device-width, initial-scale=1.0, shrink-to-fit=no'
	name='viewport' />
<script src="<c:url value='resources/js/jquery.min.js' />"></script>

<script src="<c:url value='resources/js/jquery-ui.min.js' />"></script>
<script src="<c:url value='resources/js/validations.js' />"></script>

<link rel="stylesheet"
	href="<c:url value='resources/css/jquery-ui.css' />">

<!-- <script type="text/javascript">
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




<script
	src="<c:url value='resources/assets/js/plugin/webfont/webfont.min.js' />"></script>
<link rel="stylesheet"
	href="<c:url value='resources/assets/css/bootstrap.min.css' />">
<link rel="stylesheet"
	href="<c:url value='resources/assets/css/azzara.min.css' />">

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

	//  getRegions();
		//getSiteId();
		//$("#type,#username,#emailId,#pwd,#cpwd,#mobileNum,#region").attr('required', '');  
		 $(".isa_success").fadeOut(10000);
		 getCabinet();
		 $("input").attr("required", "true");
		 $("select").attr("required", "true");
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



function getState(region)
{
	//alert(region)
	 $.ajax({
		 	type:"get",
		 	url:"getStates",
		 	contentType:'application/json',
		 	datatype:"json",
		 	data:{"selectedRegion":region},
		 	success:function(res){
		 		//alert(JSON.parse(res))
		 		console.log(res);
		 		jsonData=JSON.parse(res);
		 		populateDropdown(jsonData,"state");
		 	},
		 	error:function()
		 	{
		 		console.log("Error");	
		 	}
	 });
}
	
function getDistrict(state)
{ 
	var selectedRegion=$("#regions").val();
	 $.ajax({
	         type:"get",
	         url:"getDistricts",
	         contentType: 'application/json',
	         datatype : "json",
	         data:{"selectedRegion":selectedRegion,"selectedState":state},
	         success:function(data1) {
	         	jsonData = JSON.parse(data1);
	         	populateDropdown(jsonData,"districts");
	         },
	         error:function()
	         {
	         	console.log("Error");
	         }
	 	});
}
function getCity(district)
{ 
	
	var selectedRegion=$("#regions").val();
	var selectedState=$("#state").val();
	 $.ajax({
	         type:"get",
	         url:"getCities",
	         contentType: 'application/json',
	         datatype : "json",
	         data:{"selectedRegion":selectedRegion,"selectedState":selectedState,"selectedDistrict":district},
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
//		        	alert(jsonArr)
		        	 if(jsonArr.length==0){
			        		jsonArr1="IND001";
			        	}  	
		        	 else{
			        	var dataSplit=jsonArr[0].split("D");
			        	console.log(dataSplit[0]);
			        	var dataSplitInt=parseInt(dataSplit[1]);
			        	console.log(dataSplitInt+1);
			        	dataSplitInt=dataSplitInt+1;
			        	
			        	if(dataSplitInt>0&&dataSplitInt<=9)
			        		jsonArr1="IND00"+dataSplitInt;
			        	else if(dataSplitInt>9&&dataSplitInt<99)
			        		jsonArr1="IND0"+dataSplitInt;
			        	else if(dataSplitInt>99)
			        		jsonArr1="IND"+dataSplitInt;        	
	        		}	        	
		        	$('#siteid').val(jsonArr1);	 
		        	$('#siteid').attr('readonly', true);
		        },
		        error:function()
		        {
		        	console.log("Error");
		        }
			});
	}
	
	
	


	 
	 
	 function getCabinet()
	 {
	 	 $.ajax({
	 		 	type:"get",
	 		 	url:"getCabinetData",
	 		 	contentType:'application/json',
	 		 	datatype:"json",
	 		 	data:{"siteid":"IND001"},
	 		 	success:function(res){
	 	         	jsonData = JSON.parse(res)[0];
	 	         	if(JSON.parse(res).length==0)
	 	         		{
		 	         	document.getElementById("updatetype").value="New;"+"1";
	 	         		}
	 		 		//alert(jsonData.id)	
	 		 		else
	 		 			{
	 	         	document.getElementById("siteid").value=jsonData.siteid.siteid;
	 	         	document.getElementById("cabinetManufacturer").value=jsonData.cabinetManufacturer;
	 	         	document.getElementById("type").value=jsonData.type;
	 	         	document.getElementById("dimensions").value=jsonData.dimensions;
	 	         	document.getElementById("cabinetCondition").value=jsonData.cabinetCondition;
 	 	         	document.getElementById("comments").value=jsonData.comments;
	 	         	document.getElementById("updatetype").value="Existing;"+jsonData.id;	 	         	
	 		 			}
	 		 	},
	 		 	error:function()
	 		 	{
	 		 		console.log("Error");	
	 		 	}
	 	 });
	 }	
	 
	 
	 
	 function isNumber(evt) {
		    evt = (evt) ? evt : window.event;
		    var charCode = (evt.which) ? evt.which : evt.keyCode;
		    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
		        return false;
		    }
		    return true;
		}
</script>
<style>
.fa-bars, .fa-ellipsis-v {
	color: #fff !important;
}

label {
	color: #495057 !important;
	font-size: 13px !important;
}
</style>
<body class="login">

	<div class="main-header" style="background-color: #00B1BF;">
		<!-- Logo Header -->
		<div class="logo-header">

			<a href="home" class="logo"> <img
				src="<c:url value='resources/assets/img/logo.png' />"
				alt="navbar brand" class="navbar-brand">
			</a>
			
			<button class="navbar-toggler sidenav-toggler ml-auto" type="button"
				data-toggle="collapse" data-target="collapse" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"> <i class="fa fa-bars"></i>
				</span>
			</button>
			<button class="topbar-toggler more">
				<i class="fa fa-ellipsis-v"></i>
			</button>
			<div class="navbar-minimize">
				<button class="btn btn-minimize btn-rounded">
					<i class="fa fa-bars"></i>
				</button>
			</div>
		</div>
		<!-- End Logo Header -->

		<!-- Navbar Header -->
		<div id="navbar"></div>
		<!-- End Navbar -->
	</div>

	<!-- Sidebar -->
	<div id="superAdminSidebar"></div>
	<!-- End Sidebar -->

	<div class="wrapper wrapper-login">
		<div class="container container-login animated fadeIn">
			<div align="center">
				<span class="isa_success" style="color: #35B234; font-size: 20px">${status}</span>
			</div>
			<br> <br>

			<h3 class="text-center">Add Cabinet</h3>
			<span id="msg" style="color: red; font-size: 12px;">*All
				Fields are Mandatory*</span><br> <br>
			<form:form action="saveCabinet" method="post"
				modelAttribute="Site_Cabinet" enctype="multipart/form-data">
				<div class="login-form">
							<input type="hidden" id="updatetype" name="updatetype"/>
				

					<br> <label for="Site ID" class="placeholder">Site ID</label>
					<form:input id="siteid" path="siteid.siteid"
						class="form-control input-full filled" value="IND001" />
					<br> <label for="cabinetManufacturer" class="placeholder">Cabinet
						Manufacturer</label>
					<form:select id="cabinetManufacturer" path="cabinetManufacturer"
						name="cabinetManufacturer" class="form-control input-full filled">
						<form:option value="">Select</form:option>
						<form:options items="${CabinetManufacturer}"></form:options>
					</form:select>
					<br> <label for="type" class="placeholder">Type</label>
					<form:select id="type" path="type" name="type"
						class="form-control input-full filled">
						<form:option value="">Select</form:option>
						<form:options items="${CabinetType}"></form:options>
					</form:select>

					<br> <label for="dimensions" class="placeholder">Dimensions</label>
					<form:input id="dimensions" path="dimensions" name="dimensions" onkeypress="return isNumber(event)"
						class="form-control input-full filled" />

					<br> <label for="cabinetCondition" class="placeholder">Cabinet
						Condition</label>
					<form:select id="cabinetCondition" path="cabinetCondition"
						name="cabinetCondition" class="form-control input-full filled">
						<form:option value="">Select</form:option>
						<form:option value="Not assessed">Not assessed </form:option>
						<form:option
							value="very poor- Broken batteries, liquid / gel leackage,building out">very poor- Broken batteries, liquid / gel leackage,building out</form:option>
						<form:option value="Poor - No breakages but bulging out">Poor - No breakages but bulging out</form:option>
						<form:option value="Fair - Only sulfation on terminals">Fair - Only sulfation on terminals</form:option>
						<form:option
							value="Good - No issues and locks to be in good condition">Good - No issues and locks to be in good condition</form:option>
						<form:option value="Very good - Looks almost new">Very good - Looks almost new</form:option>
						<form:option value="Not applicable">Not applicable</form:option>
					</form:select>

					<br> <label for="comments" class="placeholder">Observation/Comments</label>
					<form:input id="comments" path="comments" name="comments" onkeypress="return isCharacters(event)" 
						class="form-control input-full filled" />
					<br> <label for="Photo_1" class="placeholder">photo_1</label>
					<%--                <form:input id="tag_photo" path="tag_photo"  name="tag_photo"  class="form-control input-full filled"  /> --%>
					<input type="file" id="photo_1" path="photo_1" name="tag_photo"
						class="form-control input-full filled" accept="image/*"
						onchange="return ValidateFileUpload(this.id)" /> <br> <br>
					<label for="photo_2" class="placeholder">photo_2</label>
					<%--                <form:input id="tag_photo" path="tag_photo"  name="tag_photo"  class="form-control input-full filled"  /> --%>
					<input type="file" id="photo_2" path="photo_2" name="tag_photo"
						onchange="return ValidateFileUpload(this.id)" accept="image/*"
						class="form-control input-full filled" /> <br>


					<div class="form-action">

						<!--  <a href="home" id="show-signin"
							class="btn btn-danger"
							style="background-color: #E4002B; color: white;">Cancel</a>-->

						<input type="submit" id="submit" value="Save" class="btn btn" name="submit"
							style="background-color: #012169; color: white;"> <input
							type="submit" id="submit" value="Save & Continue" name="submit"
							class="btn btn" style="background-color: #012169; color: white;">
					</div>
				</div>
			</form:form>

		</div>
	</div>
	<script
		src="<c:url value='resources/assets/js/core/jquery.3.2.1.min.js' />"></script>
	<script
		src="<c:url value='resources//assets/js/plugin/jquery-ui-1.12.1.custom/jquery-ui.min.js' />"></script>
	<script src="<c:url value='resources/assets/js/core/popper.min.js' />"></script>
	<script src="<c:url value='resources/assets/css/bootstrap.min.css' />"></script>
	<script src="<c:url value='resources/assets/js/ready.js' />"></script>

	<!--   Core JS Files   -->



	<script
		src="<c:url value='resources/assets/js/core/jquery.3.2.1.min.js' />"></script>
	<script src="<c:url value='resources/assets/js/core/popper.min.js' />"></script>
	<script
		src="<c:url value='resources/assets/js/core/bootstrap.min.js' />"></script>

	<!-- jQuery UI -->


	<script
		src="<c:url value='resources/assets/js/plugin/jquery-ui-1.12.1.custom/jquery-ui.min.js' />"></script>
	<script
		src="<c:url value='resources/assets/js/plugin/jquery-ui-touch-punch/jquery.ui.touch-punch.min.js' />"></script>


	<!-- jQuery Scrollbar -->
	<script
		src="<c:url value='resources/assets/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js' />"></script>



	<!-- jQuery Sparkline -->

	<script
		src="<c:url value='resources/assets/js/plugin/jquery.sparkline/jquery.sparkline.min.js' />"></script>



</body>

</html>