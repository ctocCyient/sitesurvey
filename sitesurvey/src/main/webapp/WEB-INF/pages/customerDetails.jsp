<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	String invData = (String) request.getParameter("InventoryDetails");
%>
<%
	String designData = (String) request.getParameter("Designdetails");
%>
<%
	String custData = (String) request.getParameter("customerData");
%>
<% String ticketId=(String)request.getParameter("ticketid"); %>
<% String ticketType=(String)request.getParameter("ticketType"); %>
<% String ticketStatus=(String)request.getParameter("ticketStatus"); %>


<!DOCTYPE html>
<html lang="en">
<head>
<spring:url value="resources/css/styling.css" var="mainCss" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="icon" href="<c:url value='resources/assets/img/icon.ico' />" type="image/x-icon"/>

<title>RFID</title>
<meta content='width=device-width, initial-scale=1.0, shrink-to-fit=no'
	name='viewport' />

<link href="${mainCss}" rel="stylesheet" />


<spring:url value="resources/css/jquery-ui.css" var="jqueryCss" />
<spring:url value="/resources/js/jquery.min.js" var="jqueryJs" />
<spring:url value="/resources/js/jquery-ui.min.js" var="jqueryuiJs" />
<spring:url value="/resources/js/validations.js" var="validationsJs" />

<link rel="stylesheet" type="text/css"
	href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" />

<link href="${jqueryCss}" rel="stylesheet" />
<script src="${jqueryJs}"></script>
<script src="${jqueryuiJs}"></script>

<script
	src="<c:url value='resources/assets/js/plugin/webfont/webfont.min.js' />"></script>
<link rel="stylesheet"
	href="<c:url value='resources/assets/css/bootstrap.min.css' />">
<link rel="stylesheet"
	href="<c:url value='resources/assets/css/azzara.min.css' />">
	
		<style>		
.fa-bars,		
.fa-ellipsis-v		
{		
color: #fff!important;		
}		

.isa_success{
    color:#10F564;
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
label {
    color: #495057!important;
    font-size: 13px!important;
}
</style>

<script>
	WebFont.load({
		google : {
			"families" : [ "Open+Sans:300,400,600,700" ]
		},
		custom : {
			"families" : [ "Flaticon", "Font Awesome 5 Solid",
					"Font Awesome 5 Regular", "Font Awesome 5 Brands" ],
			urls : [ 'resources/assets/css/fonts.css' ]
		},
		active : function() {
			sessionStorage.fonts = true;
		}
	});

	var designData,invData,customerId,customerData;
	var ticketId,ticketType,ticketStatus;
	
	console.log("Design"+designData);
	$(document).ready(function() {
		$(".isa_success").fadeOut(5000);
	
						$("#navbar").load('<c:url value="/resources/common/header.jsp" />');
						$("#execSidebar").load('<c:url value="/resources/common/executiveSidebar.jsp" />');

						customerData =<%=custData%>;
						 designData=<%=designData%>;
						  invData=<%=invData%>;
						  ticketId='<%=ticketId%>';
						  ticketType='<%=ticketType%>';
						  ticketStatus='<%=ticketStatus%>';
							//alert(ticketId);
						  
						$('#address')[0].value = customerData[0].address;
						$('#city')[0].value = customerData[0].city;
						$('#c_id')[0].value = customerData[0].customerId;
						$('#c_name')[0].value = customerData[0].customerName;
						$('#c_status')[0].value = customerData[0].customerStatus;
						$('#fax')[0].value = customerData[0].fax;
						$('#partial')[0].value = customerData[0].partial;
						$('#postal_code')[0].value = customerData[0].postalCode;
						$('#phn_no')[0].value = customerData[0].phoneNum;
						$('#surname')[0].value = customerData[0].surname;
						$('#userid')[0].value = customerData[0].userId;

						if(ticketType=='New')
						{
							 $('#custmerForm :input').attr('readonly','readonly');
							 
							 document.getElementById('custNewDiv').style.display="";
							 document.getElementById('custExistDiv').style.display="none";
							 
							 document.getElementById('newBtnDiv').style.display="";
							 document.getElementById('existingBtnDiv').style.display="none";
							 document.getElementById('statusDiv').style.display="none";						 
						}
						else if(ticketType=='Existing')
						{		
							 document.getElementById('existingBtnDiv').style.display="";
							 $('#custStatus').val(customerData[0].customerStatus);
							 $('#c_id,#address,#city,#c_name,#fax,#partial,#postal_code,#phn_no,#surname,#userid').attr('readonly','readonly');
							 document.getElementById('custNewDiv').style.display="none";
							 document.getElementById('custExistDiv').style.display="";
							 document.getElementById('newBtnDiv').style.display="none";
							 document.getElementById('statusDiv').style.display="none";
						
						}
// 						else if(ticketType=="null" && ticketStatus=='Closed')
// 						{
// 							 $('#custmerForm :input').attr('readonly','readonly');	
// 							 document.getElementById('statusDiv').style.display="";
// 							 document.getElementById('newBtnDiv').style.display="none";
// 							 document.getElementById('existingBtnDiv').style.display="none";
							
						 
							 
// 						 }
					});
	
	function saveExistingData(){
		customerId=customerData[0].customerId;

		var addressData=$('#address')[0].value ;
		var cityData=$('#city')[0].value ;
		var custIdData=$('#c_id')[0].value ;
		var custNameData=$('#c_name')[0].value; 
		var custStatusData=$('#custStatus')[0].value ;
		var faxData=$('#fax')[0].value ;
		var partialData=$('#partial')[0].value; 
		var postCodeData=$('#postal_code')[0].value;
		var phData=$('#phn_no')[0].value;
		var surnameData=$('#surname')[0].value;
		var userIdData=$('#userid')[0].value;
					
		var custJson = { address:addressData, city:cityData, custId:custIdData, custName:custNameData,
				custStatus:custStatusData, fax:faxData, partial:partialData, postCode:postCodeData, phone:phData, surname:surnameData,userId:userIdData};
				
		console.log("custJson"+custJson);
		
		 $.ajax({
             type: "get",
             url: "saveExistingData",
             contentType: 'application/json',
             datatype: "json",
             //data:{"customerId":customerId,"ticketId":ticketId,"customerJson":JSON.stringify(custJson),"inventoryJson":JSON.stringify(invData),"designJson":JSON.stringify(designData)},
             data:{"customerId":customerId,"ticketId":ticketId},
             success: function(result) {
            	 //alert(result);
              window.location.href = '/RFIDAssetTracking/updatealldetails?ticketid='+window.encodeURIComponent(ticketId)+'&ticketType='+ticketType+'&uniqueid='+window.encodeURIComponent(result)+'&ticketid='+window.encodeURIComponent(ticketId)+'&customerData='+ window.encodeURIComponent(JSON.stringify(custJson))+'&InventoryDetails='+ window.encodeURIComponent(JSON.stringify(invData))+'&Designdetails='+ window.encodeURIComponent(JSON.stringify(designData));                         
            	/* swal({
				//title: 'Are you sure?',
				text: result,
				type: 'info',
				buttons:{
					confirm: {
						text : 'Ok',
						className : 'btn btn-success'
					}
				}
			}).then((Delete) => {
				if (Delete) {
					window.location.href = '/RFIDAssetTracking/home';
				} 
			}); */
             
            	                      
              
               
             }                     
        });
	}
	
	
	function saveNewData(){
		customerId=customerData[0].customerId;

		var addressData=$('#address')[0].value ;
		var cityData=$('#city')[0].value ;
		var custIdData=$('#c_id')[0].value ;
		var custNameData=$('#c_name')[0].value; 
		var custStatusData=$('#c_status')[0].value ;
		var faxData=$('#fax')[0].value ;
		var partialData=$('#partial')[0].value; 
		var postCodeData=$('#postal_code')[0].value;
		var phData=$('#phn_no')[0].value;
		var surnameData=$('#surname')[0].value;
		var userIdData=$('#userid')[0].value;
					
		var custJson = { address:addressData, city:cityData, custId:custIdData, custName:custNameData,
				custStatus:custStatusData, fax:faxData, partial:partialData, postCode:postCodeData, phone:phData, surname:surnameData,userId:userIdData};
				
		console.log("custJson"+custJson);
		
		 $.ajax({
             type: "get",
             url: "saveNewData",
             contentType: 'application/json',
             datatype: "json",
             data:{"customerId":customerId,"ticketId":ticketId,"customerJson":JSON.stringify(custJson),"inventoryJson":JSON.stringify(invData),"designJson":JSON.stringify(designData)},
             success: function(result) {
            	 console.log(result);
             
               	window.location.href = '/RFIDAssetTracking/saveallDetails?uniqueid='+window.encodeURIComponent(result)+'&ticketid='+window.encodeURIComponent(ticketId)+'&ticketType='+ticketType+'&customerData='+ window.encodeURIComponent(JSON.stringify(custJson))+'&InventoryDetails='+ window.encodeURIComponent(JSON.stringify(invData))+'&Designdetails='+ window.encodeURIComponent(JSON.stringify(designData));                         
              
             }                     
        });
	}
	
	function validateAusMobileNo(phone_number){
        var formatted = "";
        //remove all non-digits
        phone_number = phone_number.replace(/\D/g,'');
        //if number starts with 61, replace 61 with 0
        if (phone_number.match(/^61/)){
              phone_number = "0"+phone_number.slice(2);
        }

        if (phone_number.match(/^04/)){
            if (phone_number.length === 10){
                var formatted = phone_number.replace(/(\d{4})(\d{3})(\d{3})/g,"$1 $2 $3");
            } else {
                alert('Invalid phone number');
            }
        } else if (phone_number.match(/^02|03|07|08/)){
            if (phone_number.length === 10) {
                var formatted = phone_number.replace(/(\d{2})(\d{4})(\d{4})/g,"($1) $2 $3");
            } else {
                alert('Invalid phone number');
            }
        } else if (phone_number.length === 8){
            alert('Please use Area Code for landline numbers');
        } else {

            alert('Invalid phone number');
        }
        //update
        $("#phn_no").val(formatted);
    }
	
	
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
<div id="execSidebar">
</div>
		<!-- End Sidebar -->
		
		  <div class="wrapper wrapper-login">
		<div class="container container-login animated fadeIn">
			<h3 class="text-center">Customer Details</h3>
			 <div align="center"><span class="isa_success" id="status"></span></div>
			<form method="post" id="custmerForm" >
				<div class="customerdetails-form">
					<div class="form-group ">
						<label for="address" class="placeholder">Address</label>
						<input id="address" name="address"	class="form-control input-full" /> 
					</div>

					<div class="form-group ">
						 <label for="city" class="placeholder">City</label><input id="city" name="city" class="form-control input-full" />
					</div>

					<div class="form-group ">

						 <label for="c_id"
							class="placeholder">Customer ID</label>
							<input id="c_id" name="c_id"
							class="form-control input-full"  />
							
					</div>

					<div class="form-group ">

						 <label for="c_name"
							class="placeholder">Customer Name</label>
							<input id="c_name" name="c_name"
							class="form-control input-full" />
					</div>
					<div id="custNewDiv" style="display:none">
					<div class="form-group ">

						 <label
							for="c_status" class="placeholder">Customer Status</label>
							<input id="c_status" name="c_status"
							class="form-control input-full" />
					</div>
					</div>
				<div id="custExistDiv" style="display:none">
					<div class="form-group">
					<label for="custStatus" class="placeholder">Customer Status</label>
	                <select id="custStatus" name="custStatus" class="form-control input-border" >
	                	<option value="Active">Active</option>
	                	<option value="Presence Unknown">Presence Unknown</option>	                	
	                </select>	                
	            	</div>
            	</div>
					<div class="form-group ">
						 <label for="fax"
							class="placeholder">Fax</label>
							<input id="fax" name="fax"
							class="form-control input-full" />
					</div>
					<div class="form-group ">
						 <label for="partial"
							class="placeholder">Partial</label>
							<input id="partial" name="partial"
							class="form-control input-full" />
					</div>
					<div class="form-group ">
						 <label for="phn_no"
							class="placeholder">Phone Number</label>
							<input id="phn_no" name="phn_no"
							class="form-control input-full" />
					</div>
					<div class="form-group ">
						 <label
							for="postal_code" class="placeholder">Postal Code</label>
							<input id="postal_code" name="postal_code"
							class="form-control input-full" />
					</div>
					<div class="form-group ">
						 <label for="surname"
							class="placeholder">Surname</label>
							<input id="surname" name="surname"
							class="form-control input-full" />
					</div>
					<div class="form-group ">
						<label for="userid"
							class="placeholder">User ID</label>
							<input id="userid" name="userid"
							class="form-control input-full" /> 
					</div>
					<div class="form-action mb-3" id="newBtnDiv" style="display:none">
						<a href="home" id="" class="btn btn-rounded btn-login mr-3" style="background-color: #E4002B;color: white;">Cancel</a>
						<input type="button" onclick="saveNewData()" class="btn btn-rounded btn-login" value="Confirm" style="background-color: #012169;color: white;">
					</div>
					<div class="form-action mb-3" id="existingBtnDiv" style="display:none">
						<a href="home" id="" class="btn btn-danger btn-rounded btn-login mr-3" style="background-color: #E4002B;color: white;">Cancel</a>
						<input type="button" onclick="saveExistingData()" class="btn  btn-rounded btn-login" value="Update" style="background-color: #012169;color: white;">
					</div>
					<div class="form-action" id="statusDiv" style="display:none">	
                		<input type="button" onclick="window.history.back();" value="Prev" class="btn btn-rounded btn-login mr-3" style="background-color: #E4002B;color: white;">				
						<a href="home" class="btn btn-rounded btn-login" style="background-color: #012169;color: white;">Ok</a>
					</div>

				</div>
			</form>
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