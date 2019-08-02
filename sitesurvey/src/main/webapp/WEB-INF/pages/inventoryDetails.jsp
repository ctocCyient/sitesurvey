<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String inventoryDetails=(String)request.getParameter("inventoryDetails"); %>
<% String ticketId=(String)request.getParameter("ticketid"); %>
<% String ticketType=(String)request.getParameter("ticketType"); %>
<% String ticketStatus=(String)request.getParameter("ticketStatus"); %>

<!DOCTYPE html >
<html lang="en">

<head>

<spring:url value="resources/css/styling.css" var="mainCss" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<link rel="icon" href="<c:url value='resources/assets/img/icon.ico' />" type="image/x-icon"/>
<title>RFID</title>
	<meta content='width=device-width, initial-scale=1.0, shrink-to-fit=no' name='viewport' />

	<link href="${mainCss}" rel="stylesheet" />

<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
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

<script type="text/javascript">


WebFont.load({
	google: {"families":["Open+Sans:300,400,600,700"]},
	custom: {"families":["Flaticon", "Font Awesome 5 Solid", "Font Awesome 5 Regular", "Font Awesome 5 Brands"], urls: ["<c:url value='resources/assets/css/fonts.css' />"]},
	active: function() {
		sessionStorage.fonts = true;
	}
});

var inventoryData;
var ticketId,ticketType;
var ticketStatus;




$(document).ready(function(){	
	 $("#navbar").load('<c:url value="/resources/common/header.jsp" />'); 
	 $("#execSidebar").load('<c:url value="/resources/common/executiveSidebar.jsp" />'); 
	
	  inventoryData=<%=inventoryDetails%>;	 
	  ticketId='<%=ticketId%>';
	  ticketType='<%=ticketType%>';
	  ticketStatus='<%=ticketStatus%>';
	  //console.log("Satus"+ticketType);
	  
	  $("#equiment_id")[0].value=inventoryData[0].equipmentId;
	  $("#exchange_name")[0].value=inventoryData[0].exchangeName;
	  $("#shelf_name")[0].value=inventoryData[0].shelfName;
	  $("#length")[0].value=inventoryData[0].length;
	  $("#inv_status_code")[0].value=inventoryData[0].inventoryStatusCode;
	  
	 
       

	 
	  
	  $("#owner_type_code")[0].value=inventoryData[0].ownershipTypeCode;
	  $("#site_name")[0].value=inventoryData[0].siteName;
	  //$("#installed_date")[0].value=inventoryData[0].installedDate;
	  
	  $("#operational_state")[0].value=inventoryData[0].operationalState;
	  
	  if(ticketType=='New')
		{
			$('#inventoryForm :input').attr('readonly','readonly');
			$('#inventoryBtn')[0].value="Confirm";
			document.getElementById('typeDiv').style.display="";
			document.getElementById('statusDiv').style.display="none";
			
			 document.getElementById('exchangeNewDiv').style.display="";
			 document.getElementById('exchangeExistDiv').style.display="none";
			 document.getElementById('shelfNewDiv').style.display="";
			 document.getElementById('shelfExistDiv').style.display="none";
			 document.getElementById('invStatusNewDiv').style.display="";
			 document.getElementById('invStatusExistDiv').style.display="none";
			 document.getElementById('ownerTypeNewDiv').style.display="";
			 document.getElementById('ownerTypeExistDiv').style.display="none";
			 document.getElementById('operNewDiv').style.display="";
			 document.getElementById('operExistDiv').style.display="none";
		 }
	  
	  else if(ticketType=='Existing')
		{
		  	 getExchanges();
		 	 document.getElementById('typeDiv').style.display="";
			 document.getElementById('statusDiv').style.display="none";
			 
		 	 document.getElementById('exchangeNewDiv').style.display="none";
			 document.getElementById('exchangeExistDiv').style.display="";
			 $('#site_name,#length,#equiment_id,#installed_date').attr('readonly','readonly');
			 
			 $('#ownerStatus').val(inventoryData[0].ownershipTypeCode);
			 $('#operStatus').val(inventoryData[0].operationalState);
			 $('#invCode').val(inventoryData[0].inventoryStatusCode);
			 
			 document.getElementById('shelfNewDiv').style.display="none";
			 document.getElementById('shelfExistDiv').style.display="";
			 document.getElementById('invStatusNewDiv').style.display="none";
			 document.getElementById('invStatusExistDiv').style.display="";
			 document.getElementById('ownerTypeNewDiv').style.display="none";
			 document.getElementById('ownerTypeExistDiv').style.display="";
			 document.getElementById('operNewDiv').style.display="none";
			 document.getElementById('operExistDiv').style.display="";
		 }
	  
// 	  else if(ticketType=="null" && ticketStatus=='Closed')
// 		{
// 			$('#inventoryForm :input').attr('readonly','readonly');
// 			//$('#inventoryBtn')[0].value="Confirm";
// 			document.getElementById('typeDiv').style.display="none";
// 			document.getElementById('statusDiv').style.display="";
// 			 document.getElementById('exchangeNewDiv').style.display="";
// 			 document.getElementById('exchangeExistDiv').style.display="none";
			 
// 			 document.getElementById('shelfNewDiv').style.display="";
// 			 document.getElementById('shelfExistDiv').style.display="none";
// 			 document.getElementById('invStatusNewDiv').style.display="";
// 			 document.getElementById('invStatusExistDiv').style.display="none";
// 			 document.getElementById('ownerTypeNewDiv').style.display="";
// 			 document.getElementById('ownerTypeExistDiv').style.display="none";
// 			 document.getElementById('operNewDiv').style.display="";
// 			 document.getElementById('operExistDiv').style.display="none";
// 		 }
	  
// 	  $("#length").keydown(function (e){		
// 	 		var k = e.keyCode || e.which;		
// 	 		var ok = k >= 65 && k <= 90 || 		
// 	 			k >= 96 && k <= 105 || 		
// 	 			k >= 35 && k <= 40 || 		
// 	 			k == 9 || 		
// 	 			k == 46 || 		
// 	 			k == 8 || 		
// 	 			k == 190 || 		
// 	 			k == 189 ||		
// 	 			(!e.shiftKey && k >= 48 && k <= 57); 		
// 	 		if(!ok || (e.ctrlKey && e.altKey)){		
// 	 			e.preventDefault();		
// 	 		}		
// 	 	});
	  
// 	  Date date1=new Date(inventoryData[0].installedDate);
// 	  $('#installed_date').datepicker({ dateFormat: 'yy/mm/dd' });
	 
// 	      $('#installed_date').datepicker('setDate', new Date());

var now = new Date(inventoryData[0].installedDate);

var day = ("0" + now.getDate()).slice(-2);
var month = ("0" + (now.getMonth() + 1)).slice(-2);

var today = now.getFullYear()+"-"+(month)+"-"+(day) ;

//$('#datePicker').val(today);

    $('#installed_date').val(today);
    
// $('#installed_date').value(inventoryData[0].installedDate);
	  
});



	
function populateDropdown(data,id)
{
	var	catOptions;
 	for (i in data) {
 		
   	 	 catOptions += "<option>" + data[i] + "</option>";
 		}
 		document.getElementById(id).innerHTML = catOptions;

}


function getExchanges()
{ 
	 	$.ajax({
	         type:"get",
	         url:"getAllExchanges",
	         contentType: 'application/json',
	         datatype : "json",
	         success:function(data1) {
	        	 jsonData = JSON.parse(data1);
		         populateDropdown(jsonData,"exchanges");
		         $('#exchanges').val(inventoryData[0].exchangeName);
		         getExchangesShelf();
	         },
	         error:function()
	         {
	         	console.log("Error");
	         }
	 	});
	 }
	 
function getExchangesShelf()
{ 
	 	
	 selectedExchange=$('#exchanges').val();
	 	$.ajax({
	         type:"get",
	         url:"getInvShelf",
	         contentType: 'application/json',
	         datatype : "json",
	         data:{"exchangeName":selectedExchange},
	         success:function(data1) {
	        	 jsonData = JSON.parse(data1);
		         populateDropdown(jsonData,"shelves");
		         $('#shelves').val(inventoryData[0].shelfName);
	         },
	         error:function()
	         {
	         	console.log("Error");
	         }
	 	});
	 }


function saveInventoryData(){
	var customerId=inventoryData[0].customerId.customerId;
	var equipData=$("#equiment_id")[0].value;
	
	if(ticketType=='New')
		{
		 var exchangeData= $("#exchange_name")[0].value;
		 var shelfData= $("#shelf_name")[0].value;
		 var ownerTypeData= $("#owner_type_code")[0].value;
		 var invStatusData= $("#inv_status_code")[0].value;
		 var opStateData= $("#operational_state")[0].value;
		 
		}
	else if(ticketType=='Existing')
	{
		var exchangeData= $("#exchanges")[0].value;
		 var shelfData= $("#shelves")[0].value;
		 var ownerTypeData= $("#ownerStatus")[0].value;
		 var invStatusData= $("#invCode")[0].value;
		 var opStateData= $("#operStatus")[0].value;
	}
	 
	 var lengthData= $("#length")[0].value;
	 var siteNameData= $("#site_name")[0].value;
	 var instDateData =$("#installed_date")[0].value;
	 //alert(instDateData);
	
		var startPointData=inventoryData[0].startPoint;
	var inventoryJson = {customerid:customerId, equipId:equipData, exchangenameId:exchangeData, shelfName:shelfData, length:lengthData,
		InvStatus:invStatusData, ownerType:ownerTypeData, siteName:siteNameData, installedDate:instDateData, operState:opStateData,startpoint:startPointData};
			//alert("inv............"+JSON.stringify(inventoryJson));
	console.log("inventoryJson"+inventoryJson);
	
	 $.ajax({
            type: "get",
            url: "getDesignData",
            contentType: 'application/json',
            datatype: "json",
            data:{"customerId":customerId},
            success: function(result) {
                designList = JSON.parse(result);	                    
                console.log("Design",designList);
                window.location.href = '/RFIDAssetTracking/designDetails?ticketType='+ticketType+'&InventoryDetails='+ window.encodeURIComponent(JSON.stringify(inventoryJson))+'&Designdetails='+ window.encodeURIComponent(JSON.stringify(designList))+'&ticketid='+window.encodeURIComponent(ticketId)+'&ticketStatus='+ticketStatus; 	                   
            }				
   	});
}


</script>
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
<div id="execSidebar">
</div>
		<!-- End Sidebar -->
		
<div class="wrapper wrapper-login">
  <div class="container container-login animated fadeIn">
			<h3 class="text-center">Inventory Details</h3>
			<form method="post" id="inventoryForm" >
			<div class="login-form">			
				<div class="form-group ">
					<label for="equiment_id" class="placeholder">Equipment Id</label>
					<input id="equiment_id" class="form-control input-full"  />					
				</div>
				<div id="exchangeNewDiv" id="display:none">
					<div class="form-group ">
					<label for="exchange_name" class="placeholder">Exchange Name</label>
					<input id="exchange_name"  class="form-control input-full"   />						
					</div>
				</div>
				<div id="exchangeExistDiv" style="display:none">
					<div class="form-group">
					<label for="exchanges" class="placeholder">Exchange Name</label>
	                <select id="exchanges" name="exchanges" class="form-control input-border" onchange="getExchangesShelf()"></select>	                
	            	</div>
            	</div>
            	<div id="shelfNewDiv" style="display:none">
					<div class="form-group ">
						<label for="shelf Name" class="placeholder">Shelf Name</label>
						<input id="shelf_name" class="form-control input-full"   />				
					</div>
				</div>
				<div id="shelfExistDiv" style="display:none">
					<div class="form-group">
					<label for="shelves" class="placeholder">Shelf Name</label>
	                <select id="shelves" name="shelves" class="form-control input-border" ></select>	                
	            	</div>
            	</div>
				<div class="form-group ">
					<label for="Length" class="placeholder">Length</label>
					<input id="length" class="form-control input-full"  onchange="fun_AllowOnlyAmountAndDot(this.id)"/>
												
				</div>
				<div id="invStatusNewDiv" style="display:none">
					<div class="form-group">
						<label for="Inventory Status Code" class="placeholder">Inventory Status Code</label>
						<input id="inv_status_code" class="form-control input-full"  />
					</div>	
				</div>
				<div id="invStatusExistDiv" style="display:none">
					<div class="form-group ">
						<label for="invCode" class="placeholder">Inventory Status Code</label>
						<select id="invCode"  name="invCode" class="form-control input-border">                			
               		 		 <option value="reserve">reserve</option>
              				 <option value="connected">connected</option>
              				 <option value="unreserve">unreserved</option>
                		</select>
					</div>	
				</div>
				<div id="ownerTypeNewDiv" style="display:none">
					<div class="form-group ">
						<label for="OwnerShip Type Code" class="placeholder">OwnerShip Type Code</label>
						<input id="owner_type_code" class="form-control input-full" />									
					</div>
				</div>
				<div id="ownerTypeExistDiv" style="display:none">
					<div class="form-group ">
						<label for="ownerStatus" class="placeholder">OwnerShip Type Code</label>
						<select id="ownerStatus"  name="ownerStatus" class="form-control input-border">                			
               		 		 <option value="3rd party">3rd party</option>
              				 <option value="NBN Cable">NBN Cable</option>
              				 <option value="Telstra">Telstra</option>
                		</select>
					</div>	
				</div>
				<div class="form-group ">
					<label for="Site Name" class="placeholder">Site Name</label>
					<input id="site_name" class="form-control input-full"   />
										
				</div>
				<div class="form-group ">
				<label for="Installed Date" class="placeholder">Installed Date</label>
				<input id="installed_date" type="date" value="" class="form-control input-full"  />
									
				</div>
				<div id="operNewDiv" style="display:none">
				<div class="form-group ">
					<label for="Operational State" class="placeholder">Operational State</label>
					<input id="operational_state" class="form-control input-full"  />								
				</div>	
				</div>
				<div id="operExistDiv" style="display:none">
					<div class="form-group ">
						<label for="operStatus" class="placeholder">Operational State</label>
						<select id="operStatus"  name="operStatus" class="form-control input-border">                			
               		 		 <option value="Working">Working</option>
              				 <option value="Not Working">Not Working</option>
                		</select>
					</div>	
				</div>	
				
				<div class="form-action" id="typeDiv" style="display:none">	
					<a href="home" id="" class="btn  btn-rounded btn-login mr-3" style="background-color: #E4002B;color: white;">Cancel</a>				
					<input type="button" onclick="saveInventoryData()" id="inventoryBtn" value="Update" class="btn  btn-rounded btn-login"  style="background-color: #012169;color: white;">
				</div>
				<div class="form-action" id="statusDiv" style="display:none">			
					<input type="button" onclick="window.history.back();" value="Prev" class="btn btn-rounded btn-login mr-3" style="background-color: #E4002B;color: white;">								
					<input type="button" onclick="saveInventoryData()" id="inventoryBtn" value="Next" class="btn btn-rounded btn-login"  style="background-color: #012169;color: white;">
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



</body>

</html>