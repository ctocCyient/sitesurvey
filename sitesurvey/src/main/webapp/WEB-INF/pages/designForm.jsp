<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%String designData= (String)request.getParameter("Designdetails"); %>
<%String inventoryData= (String)request.getParameter("InventoryDetails"); %>
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
	
	
	<script >
	var designData1,invData,customerId,ticketId,ticketType;
	var ticketStatus;
	//console.log("Design"+designData);

		$(document).ready(function() {			
			  $("#navbar").load('<c:url value="/resources/common/header.jsp" />'); 
			  $("#execSidebar").load('<c:url value="/resources/common/executiveSidebar.jsp" />'); 
			  
			  designData1=<%=designData%>;
			  invData=<%=inventoryData%>;
			  ticketId='<%=ticketId%>';
			  ticketType='<%=ticketType%>';
			  ticketStatus='<%=ticketStatus%>';
				//alert(ticketId);
			  
			  console.log("jsonData"+designData1[0]);
			 $('#tagId')[0].value=designData1[0].tagId;
			 $('#exchanges')[0].value=designData1[0].exchangeName;
			 $('#shelfName')[0].value=designData1[0].shelfName;
			 $('#startPoint')[0].value=designData1[0].startPoint;
			 $('#endPoint')[0].value=designData1[0].endPoint;
			 $('#length')[0].value=designData1[0].length;
			 $('#address')[0].value=designData1[0].address;
			 $('#floors')[0].value=designData1[0].floor;
			 $('#suites')[0].value=designData1[0].suite;
			 $('#vertIn')[0].value=designData1[0].vertIn;
			 
			 if(ticketType=='New')
				{
			 		$('#designForm :input').attr('readonly','readonly');
			 		$('#designBtn')[0].value="Confirm";
			 		document.getElementById('typeDiv').style.display="";
					document.getElementById('statusDiv').style.display="none";
					
			 		document.getElementById('exchangeNewDiv').style.display="";
					 document.getElementById('exchangeExistDiv').style.display="none";
		 			 document.getElementById('shelfNewDiv').style.display="";
		 			 document.getElementById('shelfExistDiv').style.display="none";
			 		 document.getElementById('floorNewDiv').style.display="";
					 document.getElementById('floorExistDiv').style.display="none";
					 document.getElementById('suiteNewDiv').style.display="";
					 document.getElementById('suiteExistDiv').style.display="none";
				}
			 else if(ticketType=='Existing')
				{
				  getDesignExchanges();
				  document.getElementById('typeDiv').style.display="";
					document.getElementById('statusDiv').style.display="none";	
					
					 $('#tagId,#address,#length').attr('readonly','readonly');
					 
					document.getElementById('exchangeNewDiv').style.display="none";
					 document.getElementById('exchangeExistDiv').style.display="";
		 			 document.getElementById('shelfNewDiv').style.display="none";
		 			 document.getElementById('shelfExistDiv').style.display="";
			 		 document.getElementById('floorNewDiv').style.display="none";
					 document.getElementById('floorExistDiv').style.display="";
					 document.getElementById('suiteNewDiv').style.display="none";
					 document.getElementById('suiteExistDiv').style.display="";
					 
				 }
// 			 else if(ticketType=="null" && ticketStatus=='Closed')
// 				{
// 				 $('#designForm :input').attr('readonly','readonly');	
// 				 document.getElementById('typeDiv').style.display="none";
// 					document.getElementById('statusDiv').style.display="";
// 			 		document.getElementById('exchangeNewDiv').style.display="";
// 					 document.getElementById('exchangeExistDiv').style.display="none";
// 			 		 document.getElementById('floorNewDiv').style.display="";
// 					 document.getElementById('floorExistDiv').style.display="none";
// 					 document.getElementById('suiteNewDiv').style.display="";
// 					 document.getElementById('suiteExistDiv').style.display="none";
					 
// 				 }
			 
		});
		
		
		function populateDropdown(data,id)
		{
			var	catOptions;
		 	for (i in data) {
		 		
		   	 	 catOptions += "<option>" + data[i] + "</option>";
		 		}
		 		document.getElementById(id).innerHTML = catOptions;

		}


		function getDesignExchanges()
		{ 			 	
			 	$.ajax({
			         type:"get",
			         url:"getDesignExchanges",
			         contentType: 'application/json',
			         datatype : "json",
			         success:function(data1) {
			        	var jsonData = JSON.parse(data1);
				         populateDropdown(jsonData,"exchanges1");
				         $('#exchanges1').val(designData1[0].exchangeName);
				         getDesignShelf();
				         getFloor();
			         },
			         error:function()
			         {
			         	console.log("Error");
			         }
			 	});
			 }
		
		 function getFloor()
		 { 
			 	var selectedExchange=$("#exchanges").val();
			 	
			 	$.ajax({
			         type:"get",
			        url:"getFloors",
			         contentType: 'application/json',
			         datatype : "json",
			         data:{"selectedExchange":selectedExchange},
			         success:function(data1) {
			        	 var jsonData = JSON.parse(data1);
				         populateDropdown(jsonData,"floors1");
				         $('#floors1').val(designData1[0].floor);
// 				         document.getElementById('floorNewDiv').style.display="none";
// 						 document.getElementById('floorExistDiv').style.display="";
				         getSuite();
			         },
			         error:function()
			         {
			         	console.log("Error");
			         }
			 	});
			 }
		 
		 function getSuite()
		 { 
			 	var selectedExchange=$("#exchanges").val();
			 	var selectedFloor=$("#floors").val(); 
			 	
			 	$.ajax({
			         type:"get",
			         url:"getSuites",
			         contentType: 'application/json',
			         datatype : "json",
			         data:{"selectedExchange":selectedExchange,"selectedFloor":selectedFloor},
			         success:function(data1) {
			        	 var jsonData = JSON.parse(data1);			        	
				         populateDropdown(jsonData,"suites1");
				         $('#suites1').val(designData1[0].suite);
// 				         document.getElementById('suiteNewDiv').style.display="none";
// 						 document.getElementById('suiteExistDiv').style.display="";
			         },
			         error:function()
			         {
			         	console.log("Error");
			         }
			 	});
			 }
		 
		 
		 function getDesignShelf()
		 { 
		 	 	
		 	 selectedExchange=$('#exchanges').val();
		 	 	$.ajax({
		 	         type:"get",
		 	         url:"getDesignShelf",
		 	         contentType: 'application/json',
		 	         datatype : "json",
		 	         data:{"exchangeName":selectedExchange},
		 	         success:function(data1) {
		 	        	 jsonData = JSON.parse(data1);
		 		         populateDropdown(jsonData,"shelves");
		 		         $('#shelves').val(designData1[0].shelfName);
		 	         },
		 	         error:function()
		 	         {
		 	         	console.log("Error");
		 	         }
		 	 	});
		 	 }
		 
		 


		 
		WebFont.load({
			google: {"families":["Open+Sans:300,400,600,700"]},
			custom: {"families":["Flaticon", "Font Awesome 5 Solid", "Font Awesome 5 Regular", "Font Awesome 5 Brands"], urls: ["<c:url value='resources/assets/css/fonts.css' />"]},
			active: function() {
				sessionStorage.fonts = true;
			}
		});
	
		
		function saveDesignData(){
			customerId=designData1[0].customerId.customerId;
			var tagIdData=$('#tagId')[0].value;
			 if(ticketType=='New'){
				 var exchangenameData= $('#exchanges')[0].value;
			 	var floorData= $('#floors')[0].value;
				 var suiteData= $('#suites')[0].value;
			 }
			 else if(ticketType=='Existing'){
				 var floorData= $('#floors1')[0].value;
			 	var suiteData= $('#suites1')[0].value;
			 	var exchangenameData= $('#exchanges1')[0].value;
			 } 	
				 
			 var shelfNameData= $('#shelfName')[0].value;
			 var startPointData= $('#startPoint')[0].value;
			 var endpointData= $('#endPoint')[0].value;
			 var lengthData= $('#length')[0].value;
			 var addressData= $('#address')[0].value;
			
			var vertInData= $('#vertIn')[0].value;
						
			var designJson = { tagId:tagIdData, exchangename:exchangenameData, shelfName:shelfNameData, startPoint:startPointData,
				endpoint:endpointData, length:lengthData, address:addressData, floor:floorData, suite:suiteData, vertIn:vertInData};
					
			console.log("designJSON"+designJson);
			
			 $.ajax({
                 type: "get",
                 url: "getCustomerData",
                 contentType: 'application/json',
                 datatype: "json",
                 data:{"customerId":customerId},
                 success: function(result) {
                     customerList = JSON.parse(result);                      
                     console.log("customerList",customerList);
                     window.location.href = '/RFIDAssetTracking/customerDetails?ticketType='+ticketType+'&ticketid='+window.encodeURIComponent(ticketId)+'&customerData='+ window.encodeURIComponent(JSON.stringify(customerList))+'&InventoryDetails='+ window.encodeURIComponent(JSON.stringify(invData))+'&Designdetails='+ window.encodeURIComponent(JSON.stringify(designJson))+'&ticketStatus='+ticketStatus;                         
                 }                     
            });
		}
		
		
		  function blockSpecialChar(e) {
	            var k = e.keyCode;
	            if ((k > 64 && k < 91) || (k > 95 && k < 123)  || (k >= 48 && k <= 57)){
	            	 
					   return true;
					  }
					else
					  { 
						$('#vertMsg').css("display","block");
					   return false; 
					  }

	        }
	
		  
		  function endSpecialChar(event) {
	            //var k = e.keyCode;
	            if ((event.charCode >= 49 && event.charCode <= 57) || (event.charCode >=65 && event.charCode <=90)){
	            	 
					   return true;
					  }
					else
					  { 
						$('#endMsg').css("display","block");
					   return false; 
					  }

	        }
		  
		  function startSpecialChar(event) {
	           // var k = e.keyCode;
	            if ((event.charCode >= 49 && event.charCode <= 57) || (event.charCode >=65 && event.charCode <=90)){
	            	 
					   return true;
					  }
					else
					  { 
						$('#startMsg').css("display","block");
					   return false; 
					  }

	        }
		  
		  
		
		
	</script>
	<style>
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
			<h3 class="text-center">Design Details</h3>
        <form method="post" id="designForm" >
       
	           <div class="login-form">
		<div class="form-group ">
				<label for="tagId" class="placeholder" >Tag ID</label>	
                <input id="tagId" name="tagId" class="form-control input-full" />
            	</div>
            	<div  id="exchangeNewDiv" style="display:none">
	            	<label for="exchanges" class="placeholder">Exchange Name</label>
	            	<input id="exchanges"  name="exchanges" class="form-control input-full"  />
            	</div>
            	
            	<div class="form-group " id="exchangeExistDiv" style="display:none">									
					<label for="exchanges1" class="placeholder">Exchange Name</label>
	                <select id="exchanges1" name="exchanges1" class="form-control input-border" onchange="getDesignShelf(); getFloor();"></select>	                
            	</div>
            	<div id="shelfNewDiv" style="display:none">
	            	<label for="shelfName" class="placeholder">Shelf Name</label>
	                <input id="shelfName"  name="shelfName" class="form-control input-full" />
                </div>
               <div class="form-group " id="shelfExistDiv" style="display:none">
					<label for="shelves" class="placeholder">Shelf Name</label>
	                <select id="shelves" name="shelves" class="form-control input-border" ></select>	                
            	</div>
            	<div class="form-group ">
            	<label for="startPoint" class="placeholder">Start Point</label>
            	<input id="startPoint" name="startPoint" class="form-control input-full" onkeypress="return startSpecialChar(event)" maxlength="2" onfocus="$('#startMsg').css('display','none')" />
            	<span id="startMsg" style="color:red;display:none;font-size:15px">Allows only S1 to S9</span> 
            	</div>
            	<div class="form-group ">
           		<label for="endPoint" class="placeholder" >End Point</label>	
                <input id="endPoint"  name="endPoint" class="form-control input-full" onkeypress="return endSpecialChar(event)" maxlength="2" onfocus="$('#endMsg').css('display','none')" />
            	<span id="endMsg" style="color:red;display:none;font-size:15px">Allows only S1 to S9</span> 
            	</div>
            	<div class="form-group ">
            	<label for="length" class="placeholder">Length</label>
            	<input id="length" name="length" class="form-control input-full"  />
            	</div>
            	<div class="form-group ">
            	<label for="address" class="placeholder">Address</label>
                <input id="address" name="address" class="form-control input-full" />
               </div>
               
            	<div id="floorNewDiv" style="display:none">
            	<label for="floors" class="placeholder">Floor</label>
            	<input id="floors" name="floors" class="form-control input-full" />
            	</div>
            	<div class="form-group " id="floorExistDiv" style="display:none">
						
					<label for="floors1" class="placeholder">Floor</label>		
	                <select id="floors1" name="floors1" class="form-control input-border" ></select>
	              
            	</div>
            	<div id="suiteNewDiv" style="display:none">
	            	<label for="suites" class="placeholder">Suite</label>
	            	<input id="suites" name="suites" class="form-control input-full"  />
            	</div>
            	<div class="form-group " id="suiteExistDiv" style="display:none">
            	 <label for="suites1" class="placeholder">Suite</label>
	                <select id="suites1" name="suites1" class="form-control input-border" ></select>
	               
            	</div>
            	<div class="form-group ">
            	<label for="vertIn" class="placeholder">Vert_In</label>
                <input id="vertIn" name="vertIn" class="form-control input-full" onkeypress="return blockSpecialChar(event)" onfocus="$('#vertMsg').css('display','none')"/>
                     <span id="vertMsg" style="color:red;display:none;font-size:15px">Allows only AlphaNumeric</span>   
                    </div>                          
                <div class="form-action" id="typeDiv" style="display:none">	
                <a href="home" id="" class="btn btn-rounded btn-login mr-3" style="background-color: #E4002B;color: white;">Cancel</a>				
					<input type="button" onclick="saveDesignData()" id="designBtn" value="Update" class="btn btn-rounded btn-login" style="background-color: #012169;color: white;">
				</div>
				<div class="form-action" id="statusDiv" style="display:none">	
                <input type="button" onclick="window.history.back();" value="Prev" class="btn btn-rounded btn-login mr-3" style="background-color: #E4002B;color: white;">				
					<input type="button" onclick="saveDesignData()" value="Next" class="btn btn-rounded btn-login" style="background-color: #012169;color: white;">
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