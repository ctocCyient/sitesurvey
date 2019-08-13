<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html >
<html lang="en">
<head>


	<meta http-equiv="X-UA-Compatible" content="IE=edge" />


<title>Site Survey</title>
	<meta content='width=device-width, initial-scale=1.0, shrink-to-fit=no' name='viewport' />

		
		<link rel="stylesheet" type="text/css" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.9.1/underscore.js"></script>
<link rel="icon" href="<c:url value='resources/assets/img/icon.ico' />" type="image/x-icon"/>

     		<script src="<c:url value='resources/js/jquery.min.js' />"></script>
	
	<script src="<c:url value='resources/js/jquery-ui.min.js' />"></script>
	<script src="<c:url value='resources/js/validations.js' />"></script>
	
	<link rel="stylesheet" href="<c:url value='resources/css/jquery-ui.css' />">
	
<script src="<c:url value='resources/assets/js/plugin/webfont/webfont.min.js' />"></script>
<link rel="stylesheet" href="<c:url value='resources/assets/css/bootstrap.min.css' />">
	<link rel="stylesheet" href="<c:url value='resources/assets/css/azzara.min.css' />">
	<script src="<c:url value='resources//assets/js/plugin/jquery-ui-1.12.1.custom/jquery-ui.min.js' />"></script>
	<script src="<c:url value='resources/assets/css/bootstrap.min.css' />"></script>
	<script src="<c:url value='resources/assets/js/ready.js' />"></script>
	<script src="<c:url value='resources/assets/js/core/jquery.3.2.1.min.js' />"></script>
	<script src="<c:url value='resources/assets/js/core/popper.min.js' />"></script>
	<script src="<c:url value='resources/assets/js/core/bootstrap.min.js' />"></script>
		<style>
	
	label {
    color: #495057!important;
    font-size: 13px!important;
}
.fa-bars,
.fa-ellipsis-v
{
color: #fff!important;
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
	</head>

	<script >
		$(document).ready(function() {	
			  $("#navbar").load('<c:url value="/resources/common/header.jsp" />'); 
			  $("#adminSidebar").load('<c:url value="/resources/common/adminSidebar.jsp" />'); 
			  getTicketId();
			  dateFun();
			  $("#region,#state,#district,#city,#siteid,#ticketDescription").attr('required','');
			   $(".isa_success").fadeOut(10000);
			
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
			if(id=="siteid")
			{ 
				
			}
			else
			{
				var	catOptions="<option value=''>Select</option>";
			}
         	for (i in data) {
         		
           	 	 catOptions += "<option>" + data[i] + "</option>";
         		}
         		document.getElementById(id).innerHTML = catOptions;
         		//$("select option[value='']").attr('disabled','disabled');
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

		 function getState(region)
		 {
			
			 $.ajax({
				 	type:"get",
				 	url:"getStates",
				 	contentType:'application/json',
				 	datatype:"json",
				 	data:{"selectedRegion":region},
				 	success:function(res){
				 		console.log(res);
				 		jsonData=JSON.parse(res);
				 		populateDropdown(jsonData,"state");
				 	},
				 	error:function()
				 	{
				 		console.log("Error");	
				 	}
			 });
			 
			 populateDropdown('',"siteid");
			 $("#state").val('');
			 $("#district").val('');
			 $("#city").val('');
			 $("#siteid").val('');

		 }
	 	
	 	function getDistrict(state)
		 { 
	 		
	 		var selectedRegion=$("#region").val();
			 $.ajax({
			         type:"get",
			         url:"getDistricts",
			         contentType: 'application/json',
			         datatype : "json",
			         data:{"selectedRegion":selectedRegion,"selectedState":state},
			         success:function(data1) {
			         	jsonData = JSON.parse(data1);
			         	populateDropdown(jsonData,"district");
			         },
			         error:function()
			         {
			         	console.log("Error");
			         }
			 	});
			 
			 	 populateDropdown('',"siteid");
				 $("#district").val('');
				 $("#city").val('');
				 $("#siteid").val('');
		 }

	 	function getCity(district)
		 { 
	 		
	 		var selectedRegion=$("#region").val();
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
			 
			 populateDropdown('',"siteid");
			 $("#city").val('');
			 $("#siteid").val('');
		 }
	 	
	 	function getSiteId(city)
		 { 
	 		
	 		var selectedRegion=$("#region").val();
	 		var selectedState=$("#state").val();
	 		var selectedDistrict=$("#district").val();
			 $.ajax({
			         type:"get",
			         url:"getSiteId",
			         contentType: 'application/json',
			         datatype : "json",
			         data:{"selectedRegion":selectedRegion,"selectedState":selectedState,"selectedDistrict":selectedDistrict,"selectedCity":city},
			         success:function(data1) {
			         	jsonData = JSON.parse(data1);
			         	populateDropdown(jsonData,"siteid");
			         },
			         error:function()
			         {
			         	console.log("Error");
			         }
			 	});
			 
			 	$("#siteid").val('');
			 }

	 
			 function dateFun()
			 {
			 	var today = new Date();
			 	
			 	document.getElementById('openDate').value=today;
			 	//document.getElementById('openTime').value=today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
			 }
			 
			 function getSeverityMsg(val)
			 {
				 if(val=="")
					 $("#severityMsg").css("display","block");
				 else
					 $("#severityMsg").css("display","none");
			 }
			 
			 function textarea_validation()
			 {
				 var count = $("#ticketDescription").val().length;
				 $("#ticketDescription").keypress(function(e){
				     var keyCode = e.which;
				    if ( count > 120 ) { 
				      return false;
				    }
				  });
			 }
			 			 
			 function  onKeyDown() {
				  // current pressed key
				  var pressedKey = String.fromCharCode(event.keyCode).toLowerCase();
				  if (event.ctrlKey && (pressedKey == "c" || 
				                        pressedKey == "v")) {
				    // disable key press porcessing
				    event.returnValue = false;
				  }
		} // onKeyDown
			 
	</script>

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
<div id="adminSidebar">
</div>
		<!-- End Sidebar -->
		  <div class="wrapper wrapper-login">
		<div class="container container-login animated fadeIn">
		 <div align="center"><span class="isa_success" style="color:#35B234;font-size:20px">${status}</span></div>	<br><br>
		 <span id="errorMsg" style="color:red;display:none;font-size:15px">Please enter all details</span>
			<h3 class="text-center">Create Ticket</h3>
					<span id="msg" style="color:red;font-size:12px;">*All Fields are Mandatory*</span><br><br>
        <form:form action="saveCreatedTicket" method="post" modelAttribute="Ticketing" onsubmit="return validateTicketForm();">
        <div class="login-form">
        
      			<label for="ticketId" class="placeholder">Ticket ID</label>
                <form:input id="ticketId" path="ticketNum" name="ticketId" class="form-control input-solid"  readonly="true"/>
         		<br>  
                <label for="region" class="placeholder">Region</label>
               	<form:select id="region" path="region" name="region" class="form-control input-border" onchange="getState(this.value);"  >
            	<form:option value="">Select</form:option>
            	<form:options items="${regionsList}"></form:options>
            	</form:select>
                <br>
                 <label for="state" class="placeholder">State</label>
                	<form:select id="state" path="state" name="state" class="form-control input-full filled" onchange="getDistrict(this.value);" /> 
                <br>
                 <label for="district" class="placeholder">District</label>
                	<form:select id="district" path="district" name="district" class="form-control input-full filled"  onchange="getCity(this.value);" >
                	</form:select>
                <br>
      			<label for="city" class="placeholder">City</label>
                <form:select id="city" path="city" name="city" class="form-control input-border"  onchange="getSiteId(this.value);" />
               <br>
            	<label for="siteid" class="placeholder">Site Id</label>
	             <form:select id="siteid" path="siteid" name="siteid" class="form-control input-border" multiple="multiple"/>
     	          <span id="siteMsg" style="color:red;display:none;font-size:15px">Please select Site</span>
                 <form:hidden id="status" value="Open" path="status" name="status" />    
                 <br>          
            	<label for="ticketDescription">Ticket Description</label>
				<form:textarea path="ticketDescription" placeholder="Enter upto 120 characters" id="ticketDescription"   class="form-control" onkeypress="textarea_validation();" onkeydown = "onKeyDown()"/>
				<form:hidden path="openDate" id="openDate" value="" />
            	<div class="form-action">
            	<input type="submit" id="submit" value="Create" class="btn btn-rounded btn-login" style="background-color: #012169;color: white;">
					<a href="home" id="show-signin" class="btn btn-rounded btn-login mr-3" style="background-color: #E4002B;color: white;">Cancel</a>
				</div>
	           </div>
        </form:form>
    </div>
    </div>
</body>
</html>  