<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
<% String uniqueId=(String)request.getParameter("uniqueid"); %>
<% String ticketType=(String)request.getParameter("ticketType"); %>

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

var designData,invData,customerId,customerData;
var inv,des,cus,uid
var ticketId; var uniqueId;
inv='<c:out value="${InventoryDetails}" />';
cus='<c:out value="${CustomerDetails}" />';
des='<c:out value="${DesignDetails}" />';	  




$(document).ready(function(){	
	 $("#navbar").load('<c:url value="/resources/common/header.jsp" />'); 
	 $("#execSidebar").load('<c:url value="/resources/common/executiveSidebar.jsp" />'); 
	
	 customerData =<%=custData%>;
	 designData1=<%=designData%>;
	  invData=<%=invData%>;
	  ticketId='<%=ticketId%>';
	  ticketType='<%=ticketType%>';
	  uniqueId='<%=uniqueId%>';
	   uid=uniqueId.substring(1,uniqueId.length-1);
	   console.log("UID"+uid);
	  //alert(designData1);
	  var pre_uniq=hex2a(uid);
	    //S2-E2-R2S2C2
	  var sub_preuniq=pre_uniq.substring(6,8);
	  
	  var designdetails=JSON.stringify(designData1);
	  //alert(designdetails);
	  var designJson=JSON.parse(designdetails);
		var sp=designJson.startPoint;
		var ep=designJson.endpoint;
	  
		 var customerdetails=JSON.stringify(customerData);
	  	 var customerJson=JSON.parse(customerdetails);
	  		//alert(customerdetails)	
	  	 var cid=customerJson.custId;
		 var id=sp+"-"+ep+"-"+sub_preuniq+cid;
		//alert(id);
		if(ticketType=='New')
		{	
			$('#inventoryForm :input').attr('readonly','readonly');
			document.getElementById('new_unique').style.display="none";
			document.getElementById('new_submit').style.display="";
			document.getElementById('existing_submit').style.display="none";
		 }
	  
	  else if(ticketType=='Existing')
		{
			$('#inventoryForm :input').attr('readonly','readonly');
		  	document.getElementById('new_unique').style.display="";
		  	document.getElementById('new_submit').style.display="none";
			document.getElementById('existing_submit').style.display="";
		 }
		 
	  
	  
	  //alert(sub_preuniq)
		
// 	  console.log("Customer Data"+customerData)
// 	  	  console.log("Design Data"+designData1)

// 	  	  	  console.log("Inventory Data"+invData)
// 	  	  	  console.log("Inventory Data>>>>>>>>>>"+inv)
// 	  	  	  console.log("Customer Data>>>>>>>>>>"+cus)
// 	  	  	  console.log("Design Data>>>>>>>>>>"+des)

	
	$('#inventoryForm :input').attr('readonly','readonly');
		var customerId=customerData.custId;
		var strtPoint=designData1.startPoint;
		//alert(strtPoint)
		$("#ticket_id")[0].value=ticketId;
		$("#cust_id")[0].value=customerId;
		$("#startPoint")[0].value=strtPoint;
		$("#tag_unique_id")[0].value=pre_uniq;
		$("#new_tag_unique_id")[0].value=id;
		$("#invdata")[0].value=invData;
		
		$("#cusdata")[0].value=customerData;
		$("#desdata")[0].value=designData1;

		//alert(JSON.stringify(customerData.custId))

	 
});

function hex2a(uid) {
    var str_uniq = '';
    for (var i = 0; i < uid.length; i += 2) str_uniq += String.fromCharCode(parseInt(uid.substr(i, 2), 16));
    return str_uniq;
}


function saveTagInfo(){
    
	if( document.getElementById("browse").files.length == 0 ){
        console.log("no files selected");
        $("#isa_failure")[0].innerHTML=" Please upload the image";  
    }

    
    var formData = new FormData();
   formData.append('file', browse.files[0]);    
   var fileType = browse.files[0]['type'];
   //alert("filetype"+fileType)
   var validImageTypes = ["image/gif", "image/jpeg", "image/png"];
   if ($.inArray(fileType, validImageTypes) < 0) {
    // invalid file type code goes here.
   $("#isa_failure")[0].innerHTML=" Uploaded file Must be Image format";    
}
else{
var ticketid=$("#ticket_id")[0].value;
var customerid=    $("#cust_id")[0].value;
var startpoint=    $("#startPoint")[0].value;
var unique=    $("#tag_unique_id")[0].value;
var pre_unique= " ";
taginformation={ticket_id:ticketid,customer_id:customerid,startPoint:startpoint,unique_id:unique,pre_unique_id:pre_unique,invdata:invData,cusdata:customerData,desdata:designData1}
formData.append('taginfo',JSON.stringify(taginformation));
//alert(JSON.stringify(taginformation))
$.ajax({
type: "post",
url:"fetchtaginfo",
contentType: false,
data:formData,
processData: false,
success: function(result) {
     if(result =="fail"){
    	$("#isa_failure")[0].innerHTML="Max Upload Size is 3 MB";     
     }
     else{
    	 swal({
				//title: 'Are you sure?',
				text: "Details confirmed and closed Successfully",
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
			});
    	 //alert("Details Saved Successfully");
  		
   // window.location.href = '/RFIDAssetTracking/home?succMsg="Details Saved Successfully"';                      
     }
  
}                     
});
}
}

function updateTagInfo(){
   
	if( document.getElementById("browse").files.length == 0 ){
        console.log("no files selected");
        $("#isa_failure")[0].innerHTML=" Please upload the image";  
    }

	var formData = new FormData();
    formData.append('file', browse.files[0]);    
    var fileType = browse.files[0]['type'];
    //alert("filetype"+fileType)
    var validImageTypes = ["image/gif", "image/jpeg", "image/png"];
    if ($.inArray(fileType, validImageTypes) < 0) {
     // invalid file type code goes here.
    $("#isa_failure")[0].innerHTML=" Uploaded file Must be Image format";    
	 }
 	else{
			 var ticketid=$("#ticket_id")[0].value;
			 var customerid=    $("#cust_id")[0].value;
			 var startpoint=    $("#startPoint")[0].value;
			 var unique=    $("#new_tag_unique_id")[0].value;
			 var pre_unique= $("#tag_unique_id")[0].value;
			 taginformation={ticket_id:ticketid,customer_id:customerid,startPoint:startpoint,unique_id:unique,pre_unique_id:pre_unique,invdata:invData,cusdata:customerData,desdata:designData1}
			 formData.append('taginfo',JSON.stringify(taginformation));
			 //alert(JSON.stringify(taginformation))
			 $.ajax({
			 type: "post",
			 url:"savetaginfo",
			 contentType: false,
			 data:formData,
			 processData: false,
			 success: function(result) {
				 //alert(result);
			      if(result =="fail"){
			     	$("#isa_failure")[0].innerHTML="Max Upload Size is 3 MB";     
			      }else if(result == "No tag information  found for selected customer"){
			    	  	 swal({
			  				//title: 'Are you sure?',
			  				text: result,
			  				type: 'info',
			  				buttons:{
			  					confirm: {
			  						text : 'Ok',
			  						className : 'btn btn-success'
			  					}
			  				}
			  			});
			    	
			      }
			      else{
			     	 swal({
 				//title: 'Are you sure?',
 				text: "Details updated and closed successfully",
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
 			});
     	 //alert("Details Saved Successfully");
   		
    // window.location.href = '/RFIDAssetTracking/home?succMsg="Details Saved Successfully"';                      
      }
   
 }                     
 });
 }
}


</script>
<style>
.isa_failure{
    color:red;
}
 .error {
            color: red;
        }
        
        .fa-bars,		
.fa-ellipsis-v		
{		
color: #fff!important;		
}		
        
        
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
			<h3 class="text-center">Tagging Information</h3>
			<form:form method="post" id="inventoryForm" modelAttribute="taginformation" action="saveTagInformation" enctype="multipart/form-data" >
			<div class="login-form">	
			<form:hidden path="id"/>	
			
						<input type=hidden  id="invdata" name="Invdata" />		
						<input type=hidden  id="cusdata" name="cusdata" />	
						<input type=hidden  id="desdata" name="desdata" />	
			
						
				
				<div class="form-group ">
					<label for="Ticket Id" class="placeholder">Ticket Id</label>
					<form:input id="ticket_id" class="form-control input-border-bottom" path="ticketid"  enctype="multipart/form-data" />
					<!-- <input  id="fullname" name="fullname" type="text" class="form-control input-border-bottom" required> -->
					
					
				</div>
				<div class="form-group ">
				<label for="Customer Id" class="placeholder">Customer Id</label>
				<form:input id="cust_id"  class="form-control input-border-bottom" path="customerid"   />
					<!-- <input  id="email" name="email" type="email" class="form-control input-border-bottom" required>-->
					
				</div>
				<div class="form-group ">
				<label for="Start Point" class="placeholder">Start Point</label>
				<form:input id="startPoint" class="form-control input-border-bottom"  path="startpoint"   />
					<!-- <input  id="email" name="email" type="email" class="form-control input-border-bottom" required>-->
					
				</div>
				<div class="form-group ">
				<label for="Tag Unique Id Name" class="placeholder">Tag Unique Id</label>
				<form:input id="tag_unique_id" class="form-control input-border-bottom"  path="taguniqueid" />
					<!-- <input  id="email" name="email" type="email" class="form-control input-border-bottom" required>-->
					
				</div>
				<div class="form-group " id="new_unique" style="display:none">
				<label for=" New Tag Unique Id Name" class="placeholder">New Tag Unique Id</label>
				<form:input id="new_tag_unique_id" class="form-control input-border-bottom"  path="taguniqueid" />
					<!-- <input  id="email" name="email" type="email" class="form-control input-border-bottom" required>-->
					
				</div>
				
		
				
				<div class="form-group ">
				
				<label for="Upload Image" class="placeholder" >Upload Image</label>
							<input type="file"  class="form-control input-border-bottom"  id="browse" name="file"  path="fileName" required/> 
						<!-- <span> Max Size upload 3 MB</span> -->
							
							<!--  -->
	
  
					<span class="isa_failure" id="isa_failure">${errMsg}</span>
<%-- 					        <form:errors path="fileName" cssClass="error"/>
 --%>				</div>	
					
				</div>
				
				<div class="form-action" id="new_submit" style="display:none">
				 <input type="button" onclick="saveTagInfo()" class="btn btn-rounded btn-login" value="Write To Tag" style="background-color: #012169;color: white;">  
					
 					<!-- <input type="submit"  value="Save" class="btn btn-primary btn-rounded btn-login">  -->
 				</div>
 				<div class="form-action" id="existing_submit" style="display:none"  >
				 <input type="button" onclick="updateTagInfo()" class="btn btn-rounded btn-login" value="Fix the issue" style="background-color: #012169;color: white;">  
					
 					<!-- <input type="submit"  value="Save" class="btn btn-primary btn-rounded btn-login">  -->
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