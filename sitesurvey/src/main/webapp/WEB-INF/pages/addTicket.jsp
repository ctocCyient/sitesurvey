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
<script src="https://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.9.1/underscore.js"></script>
<link rel="icon" href="<c:url value='resources/assets/img/icon.ico' />" type="image/x-icon"/>
	
	<link href="${jqueryCss}" rel="stylesheet" />
	<script src="${jqueryJs}"></script>
    <script src="${jqueryuiJs}"></script>
     
<script src="<c:url value='resources/assets/js/plugin/webfont/webfont.min.js' />"></script>
<link rel="stylesheet" href="<c:url value='resources/assets/css/bootstrap.min.css' />">
	<link rel="stylesheet" href="<c:url value='resources/assets/css/azzara.min.css' />">
	<script src="<c:url value='resources//assets/js/plugin/jquery-ui-1.12.1.custom/jquery-ui.min.js' />"></script>
	<script src="<c:url value='resources/assets/css/bootstrap.min.css' />"></script>
	<script src="<c:url value='resources/assets/js/ready.js' />"></script>
	<script src="<c:url value='resources/assets/js/core/jquery.3.2.1.min.js' />"></script>
	<script src="<c:url value='resources/assets/js/core/popper.min.js' />"></script>
	<script src="<c:url value='resources/assets/js/core/bootstrap.min.js' />"></script>
	<script >
		$(document).ready(function() {			
			  $("#navbar").load('<c:url value="/resources/common/header.jsp" />'); 
			  $("#systemAdminSidebar").load('<c:url value="/resources/common/systemAdminSidebar.jsp" />'); 
			  getTicketId();
			  getRegion();
			  dateFun();
			  $("#region","#city","#exchange","#floor","#suite","#rack","#sub_rack","#customerId").attr('required','');
			  $(".isa_success").fadeOut(10000);
			  $("input[name='ticketType']").change(function(){
		            var radioValue = $("input[name='ticketType']:checked").val();
		            var ticketId=$("#ticketId").val();
		            
		            if(radioValue=="Existing"){
		            	if(($("#uniqueIdExist")[0].style.display)=="block")
		            	{
		            		getUniqueId();
		            	}
		            	else
		            	{
		            		document.forms[0].reset();
		            		getExistingRegion();
		            	}
		            	
		            	$("#ticketId").val(ticketId);
		            	$("#ticketTypeExist").prop("checked",true);
		            	$("#uniqueIdMsg").css("display","none");
		            	$("#uniqueIdExist").css("display","none");
		            	$("#submit").attr('disabled',false);
		            }
		            else
		            {
		            	document.forms[0].reset();
		            	getRegion();
		            	$("#ticketId").val(ticketId);
		            	$("#ticketTypeNew").prop("checked",true);
		            	$("#uniqueIdMsg").css("display","none");
		            	$("#uniqueIdExist").css("display","none");
		            	$("#submit").attr('disabled',false);
		            }
		            
		        });
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
			var	catOptions="<option value=''>Select</option>";
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
		 	
		 function getExistingRegion()
		 {
			 var radioValue = $("input[name='ticketType']:checked").val();
		      
			 	$.ajax({
			         type:"get",
			         url:"getExistingRegion",
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
			 	
			 	/* if($("#region").val()=="")
			 		$("#regionMsg").css("display","block");
			 	else
			 		$("#regionMsg").css("display","none"); */
			 		
			 		
		 }
		 
		 function getRegion()
		 { 
			 var radioValue = $("input[name='ticketType']:checked").val();
		      
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
			 	
			 	 /* if($("#region").val()=="")
			 		$("#regionMsg").css("display","block");
			 	else
			 		$("#regionMsg").css("display","none");  */
		 }
		 
		 function getCity(selectedRegion)
		 { 
			var radioValue = $("input[name='ticketType']:checked").val();
	        if(radioValue=="New")
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
			else
			{
				 $.ajax({
			         type:"get",
			         url:"getExistingCity",
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
	        
	        /* $("#city").val('')
	        $("#exchange").val()="";
	        $("#floor").val()="";
	        $("#suite").val()="";
	        $("#rack").val()="";
	        $("sub_rack").val()="";
	        $("#customerId").val()=""; */
	        
	        if($("#region").val()=="")
		 		$("#regionMsg").css("display","block");
		 	else
		 		$("#regionMsg").css("display","none");
		 }
		 
		 function getExchange(value)
		 { 
			 	var selectedCity=value;
			 	var radioValue = $("input[name='ticketType']:checked").val();
		        if(radioValue=="New")
			 {
			 	$.ajax({
			         type:"get",
			         url:"getExchange",
			         contentType: 'application/json',
			         datatype : "json",
			         data:{"selectedCity":selectedCity},
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
			 else
			{
					
				 $.ajax({
			         type:"get",
			         url:"getExistingExchange",
			         contentType: 'application/json',
			         datatype : "json",
			         data:{"selectedCity":selectedCity},
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
		        
		        if($("#city").val()=="")
			 		$("#cityMsg").css("display","block");
			 	else
			 		$("#cityMsg").css("display","none");
	 		}
		 
		 function getFloor(value)
		 { 
			 var selectedExchange=value;
			 var radioValue = $("input[name='ticketType']:checked").val();
		     if(radioValue=="New")
			 {
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
		 	else
			{
		 		$.ajax({
			         type:"get",
			        url:"getExistingFloor",
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
		   
		     if($("#exchange").val()=="")
			 		$("#exchangeMsg").css("display","block");
			 	else
			 		$("#exchangeMsg").css("display","none");
		     
		 }
		 function getSuite()
		 { 
			 	var selectedExchange=$("#exchange").val();
			 	var selectedFloor=$("#floor").val(); 
			 	var radioValue = $("input[name='ticketType']:checked").val();
			     if(radioValue=="New")
				 {
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
		 
		 	else
			{
		 		$.ajax({
			         type:"get",
			         url:"getExistingSuite",
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
			     if($("#floor").val()=="")
				 		$("#floorMsg").css("display","block");
				 	else
				 		$("#floorMsg").css("display","none");
			     
		 }
		 function getRack()
		 { 
			 	var selectedExchange=$("#exchange").val();
			 	var selectedFloor=$("#floor").val(); 
			 	var selectedSuite=$("#suite").val(); 
			 	
			 	var radioValue = $("input[name='ticketType']:checked").val();
			     if(radioValue=="New")
				 {
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
			else
			{
				$.ajax({
			         type:"get",
			         url:"getExistingRack",
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
			     if($("#suite").val()=="")
				 		$("#suiteMsg").css("display","block");
				 	else
				 		$("#suiteMsg").css("display","none");
		}
    	 
		 function getSubRack()
		 { 
			 	var selectedExchange=$("#exchange").val();
			 	var selectedFloor=$("#floor").val(); 
			 	var selectedSuite=$("#suite").val(); 
			 	var selectedRack=$("#rack").val();
			 	
			 	var radioValue = $("input[name='ticketType']:checked").val();
			     if(radioValue=="New")
				 {
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
			 else
			 {
				 $.ajax({
			         type:"get",
			         url:"getExistingSubRack",
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
			     if($("#rack").val()=="")
				 		$("#rackMsg").css("display","block");
				 	else
				 		$("#rackMsg").css("display","none");
	   	 }
		 function getCustomerId()
		 { 
			 	var selectedExchange=$("#exchange").val();
			 	var selectedFloor=$("#floor").val(); 
			 	var selectedSuite=$("#suite").val(); 
			 	var selectedRack=$("#rack").val();
			 	var selectedSubRack=$("#sub_rack").val();
			 	
			 	var radioValue = $("input[name='ticketType']:checked").val();
			    if(radioValue=="New")
				{
				 	$.ajax({
				         type:"get",
				         url:"getCustomerId",
				         contentType: 'application/json',
				         datatype : "json",
				         data:{"selectedExchange":selectedExchange,"selectedFloor":selectedFloor,"selectedSuite":selectedSuite,"selectedRack":selectedRack,"selectedSubRack":selectedSubRack},
				         success:function(data1) {
				        	 jsonData = JSON.parse(data1);
				        	var jsondata= _.uniq(jsonData);
				        	 
					         populateDropdown(jsondata,"customerId");
				         },
				         error:function()
				         {
				         	console.log("Error");
				         }
				 	});
				}
			    else
			    {
			    	$.ajax({
				         type:"get",
				         url:"getExistingCustomerId",
				         contentType: 'application/json',
				         datatype : "json",
				         data:{"selectedExchange":selectedExchange,"selectedFloor":selectedFloor,"selectedSuite":selectedSuite,"selectedRack":selectedRack,"selectedSubRack":selectedSubRack},
				         success:function(data1) {
				        	 jsonData = JSON.parse(data1);
				        	 var jsondata= _.uniq(jsonData);
				        	 
					         populateDropdown(jsondata,"customerId");
				         },
				         error:function()
				         {
				         	console.log("Error");
				         }
				 	});
			    }
			   
			    if($("#sub_rack").val()=="")
			 		$("#subRackMsg").css("display","block");
			 	else
			 		$("#subRackMsg").css("display","none");
			 }
		 
			 function getUniqueId()
			{
				 var selectedCustomerId=$("#customerId").val();
				 var selectedExchange=$("#exchange").val();
				 var radioValue = $("input[name='ticketType']:checked").val();
				 //var ticketId=$("#ticketId").val();
				 
		            if(radioValue=="Existing")
		            {
		            	
		            	 $.ajax({
		    		         type:"get",
		    		         url:"getExistUniqueId",
		    		         contentType: 'application/json',
		    		         datatype : "json",
		    		         data:{"selectedExchange":selectedExchange,"selectedCustomerId":selectedCustomerId},
		    		         success:function(data1) {
		    		        	 jsonData = JSON.parse(data1);
		    			         if(jsonData.length==0)
		    			         	{
		    			         		$("#uniqueIdMsg").css("display","block");
		    			         		$("#submit").attr('disabled',true);
		    			         	}
		    			         	else
		    			         	{	 
		    			         		$("#uniqueIdMsg").css("display","none");
		    			         		$("#uniqueId").val(jsonData);
		    			         		$("#submit").attr('disabled',false);
		    			         	}
		    		         },
		    		         error:function()
		    		         {
		    		         	console.log("Error");
		    		         }
		    		 	});
		            }
		            else
		            	{
		            	
		            	$.ajax({
		    		         type:"get",
		    		         url:"getStartnEndPoint",
		    		         contentType: 'application/json',
		    		         datatype : "json",
		    		         data:{"selectedExchange":selectedExchange,"selectedCustomerId":selectedCustomerId},
		    		         success:function(data1) {
		    		        	 jsonData = JSON.parse(data1);
		    		        	 var id= jsonData[0].startPoint+"-"+jsonData[0].endPoint+"-"+jsonData[0].rack+jsonData[0].customerId.customerId;
		    			         $("#uniqueId").val(id);
		    			        var custId= $("#customerId").val();
		    			        // TestUniqueIdExist(id);
		    			        TestCustIdExist(custId);
		    		         },
		    		         error:function()
		    		         {
		    		         	console.log("Error");
		    		         }
		    		 	});
		            	
				
					/*var jsonArr1;
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
						        	var dataSplit=jsonArr[0].split("_");
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
						});*/
				}
		            
		            if($("#customerId").val()=="")
				 		$("#customerIdMsg").css("display","block");
				 	else
				 		$("#customerIdMsg").css("display","none");
			}
			 
			 
			 function TestUniqueIdExist(uniqueId)
			 {
				 $.ajax({
						type:"get",
						url:"TestUniqueIdExist",
						contentType:'application/json',
						data:{"UniqueId":uniqueId},
						datatype:"json",
						success:function(data){
							
							if(data=="Exists")
							{
    			         		$("#uniqueIdExist").css("display","block");
    			         		$("#submit").attr('disabled',true);
    			         	}
    			         	else
    			         	{	 
    			         		$("#uniqueIdExist").css("display","none");
    			         		$("#submit").attr('disabled',false);
    			         	}
						},
						error:function()
						{
							console.log("Error");
						}
				 });
			 }
			 
			 function TestCustIdExist(custId)
			 {
				 $.ajax({
						type:"get",
						url:"TestCustIdExist",
						contentType:'application/json',
						data:{"CustId":custId},
						datatype:"json",
						success:function(data){
							
							if(data=="Exists")
							{
    			         		$("#uniqueIdExist").css("display","block");
    			         		$("#submit").attr('disabled',true);
    			         	}
    			         	else
    			         	{	 
    			         		$("#uniqueIdExist").css("display","none");
    			         		$("#submit").attr('disabled',false);
    			         	}
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
			 	document.getElementById('openDate').value=today;
			 }
			 
			 function getSeverityMsg(val)
			 {
				 if(val=="")
					 $("#severityMsg").css("display","block");
				 else
					 $("#severityMsg").css("display","none");
			 }
			 
			 function validateTicketForm()
			 {
						
			
					var severity=$('#severity').val();
					var region=$("#region").val();
					var city=$("#city").val();
					var exchange=$("#exchange").val();
					var floor=$("#floor").val();
					var suite=$("#suite").val();
					var rack=$("#rack").val();
					var subRack=$("#sub_rack").val();
					var uniqueId=$("#uniqueId").val();
				
						if	(severity=="")
						{
							$("#severityMsg").css("display","block");
							 return false;
						}
						else
						{
							$("#errMsg").css("display","none");
						}
						if	(region=="")
						{
							$("#regionMsg").css("display","block");
							 return false;
						}
						else
						{
							$("#regionMsg").css("display","none");
						}
						if	(city=="")
						{
							$("#cityMsg").css("display","block");
							 return false;
						}
						else
						{
							$("#cityMsg").css("display","none");
						}
						if	(exchange=="")
						{
							$("#exchangeMsg").css("display","block");
							 return false;
						}
						else
						{
							$("#exchangeMsg").css("display","none");
						}
						if	(floor=="")
						{
							$("#floorMsg").css("display","block");
							 return false;
						}
						else
						{
							$("#floorMsg").css("display","none");
						}
						if	(suite=="")
						{
							$("#suiteMsg").css("display","block");
							 return false;
						}
						else
						{
							$("#suiteMsg").css("display","none");
						}
						if	(rack=="")
						{
							$("#rackMsg").css("display","block");
							 return false;
						}
						else
						{
							$("#rackMsg").css("display","none");
						}
						if	(subRack=="")
						{
							$("#subRackMsg").css("display","block");
							 return false;
						}
						else
						{
							$("#subRackMsg").css("display","none");
						}
						
						if	(uniqueId=="")
						{
							$("#uniqueIdMsg").css("display","block");
							 return false;
						}
						else
						{
							$("#uniqueIdMsg").css("display","none");
						}
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
<div id="systemAdminSidebar">
</div>
		<!-- End Sidebar -->
		  <div class="wrapper wrapper-login">
		<div class="container container-login animated fadeIn">
		 <div align="center"><span class="isa_success" style="color:#35B234;font-size:20px">${status}</span></div>	<br><br>
		 <span id="errorMsg" style="color:red;display:none;font-size:15px">Please enter all details</span>
			<h3 class="text-center">Create Ticket</h3>
        <form:form action="saveCreatedTicket" method="post" modelAttribute="Ticketing" onsubmit="return validateTicketForm();">
        <div class="login-form">
        		
      			<div class="form-group">
      				<label for="ticketId" class="placeholder">Ticket ID</label>
                <form:input id="ticketId" path="ticketNum" name="ticketId" class="form-control input-solid"  readonly="true"/>
            
            	</div>
            	<div class="form-check">
										<label>Ticket Type</label><br>
										<label class="form-radio-label">
											<form:radiobutton  class="form-radio-input"  name="ticketType" id="ticketTypeNew" path="ticketType" value="New" checked="checked"/>
											<span class="form-radio-sign">New</span>
										</label>
										<label class="form-radio-label ml-3">
											<form:radiobutton  class="form-radio-input"  name="ticketType" id="ticketTypeExist" path="ticketType" value="Existing"/>
											<span class="form-radio-sign">Existing</span>
										</label>
				</div>
				<div class="form-group ">
				 <label for="rack" class="placeholder">Severity</label>
                <form:select id="severity" path="severity" name="severity" class="form-control input-border"  onchange="getSeverityMsg(this.value);">
                			 <form:option value="">Select</form:option>
               		 		 <form:option value="Major">Major</form:option>
              				 <form:option value="Minor">Minor</form:option>
                </form:select>
               <span id="severityMsg" style="color:red;display:none;font-size:15px">Please enter Severity</span>
            	</div>
				<div class="form-group " id="regionDiv">
				<label for="region" class="placeholder">Region</label>
            	<form:select id="region" path="region" name="region" class="form-control input-border" onchange="getCity(this.value);"  />
            	<span id="regionMsg" style="color:red;display:none;font-size:15px">Please enter Region</span>
            	</div>
            	<div class="form-group " id="regionDiv">
            	<label for="region" class="placeholder">City</label>
            	<form:select id="city" path="city" name="city" class="form-control input-border" onchange="getExchange(this.value);" />
            	<span id="cityMsg" style="color:red;display:none;font-size:15px">Please enter City</span>
            	</div>
            	<div class="form-group ">
            	 <label for="exchange" class="placeholder">Exchange</label>
                <form:select id="exchange" path="exchangeName" name="exchange" class="form-control input-border" onchange="getFloor(this.value);"    />
               <span id="exchangeMsg" style="color:red;display:none;font-size:15px">Please enter Exchange</span>
            	</div>
            	<div class="form-group ">
            	 <label for="floor" class="placeholder">Floor</label>
                <form:select id="floor" path="floor" name="" class="form-control input-border" onchange="getSuite();"   />
               	<span id="floorMsg" style="color:red;display:none;font-size:15px">Please enter Floor</span>
            	</div>
            	<div class="form-group ">
            	 <label for="suite" class="placeholder">Suite</label>
                <form:select id="suite" path="suite" name="suite" class="form-control input-border" onchange="getRack();"  />
               <span id="suiteMsg" style="color:red;display:none;font-size:15px">Please enter Suite</span>
            	</div>
            	<div class="form-group ">
            	<label for="rack" class="placeholder">Rack</label>
                <form:select id="rack" path="rack" name="rack" class="form-control input-border"  onchange="getSubRack();" />
                <span id="rackMsg" style="color:red;display:none;font-size:15px">Please enter Rack</span>
            	</div>    
            	 <div class="form-group ">
            	  <label for="sub_rack" class="placeholder">Sub Rack</label>
                <form:select id="sub_rack" path="subrack" name="sub_rack" class="form-control input-border" onchange="getCustomerId()"  />
               <span id="subRackMsg" style="color:red;display:none;font-size:15px">Please enter Sub Rack</span>
            	</div>  
            	<div class="form-group ">
            	<label for="customerId" class="placeholder">Customer ID</label>
                <form:select id="customerId" path="customer.customerId" name="customerId" class="form-control input-border"  onchange="getUniqueId();"   />
            	<span id="customerIdMsg" style="color:red;display:none;font-size:15px">Please enter CustomerId</span>
            	</div>
            	<div class="form-group">
            	<label for="uniqueId" class="placeholder">Unique ID</label>
                <form:input id="uniqueId" path="uniqueId" name="uniqueId" class="form-control input-solid" readonly="true"   />
            	
            	  <span id="uniqueIdMsg" style="color:red;display:none;font-size:15px">Ticket is already Assigned -In Progress</span> 
            	  <span id="uniqueIdExist" style="color:red;display:none;font-size:15px">Need to be created as Exisitng</span>
            	</div>
            	
                <form:hidden id="status" value="Open" path="status" name="status" />              
            	
            	<div class="form-group">
					<label for="ticketDescription">Ticket Description</label>
					<form:textarea path="ticketDescription" placeholder="Enter upto 120 characters" id="ticketDescription"   class="form-control" onkeypress="textarea_validation();" onkeydown = "onKeyDown()"/>
				</div>
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