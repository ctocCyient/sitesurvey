<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String jsondetails=(String)request.getParameter("ticketDetails"); 
   System.out.println("json>>>>>>>"+jsondetails);%>
<% String status=(String)request.getAttribute("status"); %>

<% String btnClick=(String)request.getAttribute("btnClick"); 
  System.out.println("btnclck>>>>>>>"+btnClick);%>
<html lang="en">

<head>

<spring:url value="resources/css/styling.css" var="mainCss" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<link rel="icon" href="<c:url value='resources/assets/img/icon.ico' />" type="image/x-icon"/>
<title>Site Survey</title>
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
         <script type="text/javascript">
	
   if(sessionStorage.getItem("username")==null) 
   	{ 
		   url = "/sitesurvey/"; 
		      $( location ).attr("href", url);
  	}
  
 	   else 
 		   { 
 		  role=sessionStorage.getItem("role"); 
 			siteId=sessionStorage.getItem("siteId");
 			ticketId=sessionStorage.getItem("ticketId");
		   } 

 </script> 
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


var jsonDetails;
$(document).ready(function(){	
	

	var status='<%=status%>';

	var btnClick='<%=btnClick%>';
	//alert(status);
	 if(status=='Saved')

     {
                  var nextUrl;
              if(btnClick=="Save"){
                    nextUrl="/sitesurvey/home";
              }
              else if(btnClick=="Save & Continue"){
                    nextUrl="/sitesurvey/gotoAdditional";
              }
              swal({
                         //title: 'Are you sure?',
                         text: "Details Saved Successfully",
                         type: 'info',
                         buttons:{
                                confirm: {
                                       text : 'Ok',
                                       className : 'btn btn-success'
                                }
                         }
                  }).then((Delete) => {
                         if (Delete) {
                                window.location.href = nextUrl;
                         }
                  });
            }
	
	$("select option[value='Select']").attr('disabled','disabled');
	 $("#safetyform :input").attr("required", '');
	 $("#navbar").load('<c:url value="/resources/common/header.jsp" />'); 
	 $("#technicianSidebar").load('<c:url value="/resources/common/technicianSidebar.jsp" />'); 
	 jsonDetails='<%=jsondetails%>';
//	alert(jsonDetails)
	var ticketDetails=JSON.parse(JSON.stringify(jsonDetails));

	$("#siteid")[0].value=siteId;
	  $("#json")[0].value=ticketDetails;
	  getSafetyDetails(siteId);
	
});


function getSafetyDetails(siteId)
{
	//alert("ji")

	 $.ajax({
         type: "get",
         url: "getSafetyDetails",
         contentType: 'application/json',
         data:{"siteId":siteId},
         datatype: "json",
         success: function(result) {
            jsonData = JSON.parse(result);
            if(jsonData.length==0)
            {
            	
            }
            else
            {
            	//alert(jsonData[0].id)
            	$("#safetyid").val(jsonData[0].id);
            	$("#securitycondition").val(jsonData[0].extinguishersAvailability);
            	$("#edate").val(jsonData[0].extinguishersDueDate);
            	$("#aviationlight").val(jsonData[0].aviationLights);
            	$("#arrestor").val(jsonData[0].lightningArrestor);
            	$("#rttloc").val(jsonData[0].rtt_rtp_locations);
               	$("#stairs").val(jsonData[0].stairsLaddersCondition);
            	$("#climbdevice").val(jsonData[0].safeClimbDevice);
            	$("#anticlimbdevice").val(jsonData[0].antiClimbProtection);
            	$("#fireclear").val(jsonData[0].siteFireClear);
            	$("#oilspill").val(jsonData[0].oilSpillsDG);
            	$("#safetysignage").val(jsonData[0].safetySignage);
            	$("#obv").val(jsonData[0].observations);
            	
            }
         }					
		 }); 
}

</script>
<style>
.isa_failure{
    color:red;
}
.error {
 color: #ff0000;
 font-style: italic;
 font-weight: bold;
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
<div id="technicianSidebar">
</div>
		<!-- End Sidebar -->
		
	<div class="wrapper wrapper-login">
	  <div class="container container-login animated fadeIn">
	 
				<h3 class="text-center">Safety</h3>
				<span id="msg" style="color:red;font-size:12px;">*All Fields are Mandatory*</span><br><br>
				<form:form method="post" id="safetyform" modelAttribute="Site_Safety" action="sitesafety" enctype="multipart/form-data">
				<form:input type="hidden"  path="" id="json" name="json" />
				
				<form:input type="hidden" path="id" id="safetyid" />
				<div class="form-group ">
						<label for="siteid" class="placeholder">Site ID
				
						</label>
						 
						<form:input type="text" id="siteid" path="siteid.siteid" class="form-control input-full" readonly="true"  />				
						<form:errors path="siteid.siteid" cssClass="error" />	
					</div>
				<div class="form-group ">
						<label for="extinguishersAvailability" class="placeholder">Are Fire extinguishers available (Non expired)? </label>
						<form:select id="securitycondition" path="extinguishersAvailability"  name="overallconditon"  class="form-control input-full filled" >
		                <form:option value="Select">Select</form:option>
		                <form:option value="Yes">Yes</form:option>
		                <form:option value="No">No</form:option>
		                <form:option value="Unknown">Unknown</form:option>
		                
		                </form:select>
								<form:errors path="extinguishersAvailability" cssClass="error" />
										
					</div>
					
					<div class="form-group ">
						<label for="edate" class="placeholder">When are fire extinguishers due for a service?</label>
						<form:input type="date" id="edate" path="extinguishersDueDate" class="form-control input-full"  />				
						<form:errors path="extinguishersDueDate" cssClass="error" />	
					</div>
						
				<div class="form-group ">
				<label for="Upload Image" class="placeholder" >Upload Image1 </label>
				<input type="file"   path="safety_photo1" class="form-control input-border-bottom"  id="img1" name="file" onchange="return ValidateImage(this.id);"  /> 
				<span class="isa_failure" id="image0">${errMsg}</span>
  				</div>
  				
  				<div class="form-group ">
						<label for="aviationlight" class="placeholder">Does the tower have a aviation lights?</label>
						<form:select id="aviationlight" path="aviationLights"  name="aviationlight"  class="form-control input-full filled" >
		                <form:option value="Select">Select</form:option>
		                <form:option value="Yes">Yes</form:option>
		                <form:option value="No">No</form:option>
		                <form:option value="Unknown">Unknown</form:option>
		                
		                </form:select>
								<form:errors path="aviationLights" cssClass="error" />
										
					</div>
					<div class="form-group ">
						<label for="arrestor" class="placeholder">Is the lighting arrestor spike and connection to tower or earthing available?</label>
						<form:select id="arrestor" path="lightningArrestor"  name="arrestor"  class="form-control input-full filled" >
		                <form:option value="Select">Select</form:option>
		                <form:option value="Yes">Yes</form:option>
		                <form:option value="No">No</form:option>
		                <form:option value="Unknown">Unknown</form:option>
		                
		                </form:select>
								<form:errors path="lightningArrestor" cssClass="error" />
										
					</div>
					<div class="form-group ">
						<label for="rttloc" class="placeholder">For RTT/RTP loactions,are protection rails or parapet walls available</label>
						<form:select id="rttloc" path="rtt_rtp_locations"  name="rttloc"  class="form-control input-full filled" >
		                <form:option value="Select">Select</form:option>
		                <form:option value="Yes">Yes</form:option>
		                <form:option value="No">No</form:option>
		                <form:option value="Unknown">Unknown</form:option>
		                
		                </form:select>
								<form:errors path="rtt_rtp_locations" cssClass="error" />
										
					</div>
  				
  				
  				
 				<div class="form-group ">
				<label for="Upload Image" class="placeholder" >Upload Image2 </label>
				<input type="file" path="safety_photo2"  class="form-control input-border-bottom"  id="img2"  name="file"  onchange="return ValidateImage('img2');"/> 
					<span class="isa_failure" id="image2">${errMsg}</span>
  				</div>
  				
  				<div class="form-group ">
						<label for="stairs" class="placeholder">Stairs or ladders-are they in good condition with no missing rungs etc?</label>
						<form:select id="stairs" path="stairsLaddersCondition"  name="stairs"  class="form-control input-full filled" >
		                <form:option value="Select">Select</form:option>
		                <form:option value="Yes">Yes</form:option>
		                <form:option value="No">No</form:option>
		                <form:option value="Not Applicable">Not Applicable</form:option>
		                
		                </form:select>
								<form:errors path="stairsLaddersCondition" cssClass="error" />
										
					</div>
					
					<div class="form-group ">
						<label for="Upload Image" class="placeholder" >Upload Image3 </label>
						<input type="file" path="safety_photo3"  class="form-control input-border-bottom"  id="img3"  name="file"  onchange="return ValidateImage('img2');"/> 
						<span class="isa_failure" id="image3">${errMsg}</span>
  					</div>
					
					
					<div class="form-group ">
						<label for="climbdevice" class="placeholder">Is there safe climb device installed on ladder ? (Typically a cable or rail)</label>
						<form:select id="climbdevice" path="safeClimbDevice"  name="climbdevice"  class="form-control input-full filled" >
		                <form:option value="Select">Select</form:option>
		                <form:option value="Yes">Yes</form:option>
		                <form:option value="No">No</form:option>
		                
		                
		                </form:select>
								<form:errors path="safeClimbDevice" cssClass="error" />
										
					</div><div class="form-group ">
						<label for="anticlimbdevice" class="placeholder">Is the anti climb protection in place?</label>
						<form:select id="anticlimbdevice" path="antiClimbProtection"  name="anticlimbdevice"  class="form-control input-full filled" >
		                <form:option value="Select">Select</form:option>
		                <form:option value="Yes">Yes</form:option>
		                <form:option value="No">No</form:option>
		                
		                
		                </form:select>
								<form:errors path="antiClimbProtection" cssClass="error" />
										
					</div>
						<div class="form-group ">
						<label for="fireclear" class="placeholder">Is the site clear of fire hazard rubble, installation material, released old equipment etc.?</label>
						<form:select id="fireclear" path="siteFireClear"  name="fireclear"  class="form-control input-full filled" >
		                <form:option value="Select">Select</form:option>
		                <form:option value="Yes">Yes</form:option>
		                <form:option value="No">No</form:option>
		                
		                
		                </form:select>
								<form:errors path="siteFireClear" cssClass="error" />
										
					</div>
					<div class="form-group ">
						<label for="Upload Image" class="placeholder" >Upload Image4 </label>
						<input type="file" path="safety_photo4"  class="form-control input-border-bottom"  id="img4"  name="file"  onchange="return ValidateImage('img2');"/> 
						<span class="isa_failure" id="image4">${errMsg}</span>
  					</div>
  					
						<div class="form-group ">
						<label for="oilspill" class="placeholder">Are there oil spills in the DG area (Diesel + Engine oil etc. )?</label>
						<form:select id="oilspill" path="oilSpillsDG"  name="oilspill"  class="form-control input-full filled" >
		                <form:option value="Select">Select</form:option>
		                <form:option value="Yes">Yes</form:option>
		                <form:option value="No">No</form:option>
		                
		                
		                </form:select>
								<form:errors path="oilSpillsDG" cssClass="error" />
										
					</div>
					
					<div class="form-group ">
						<label for="safetysignage" class="placeholder">Are safety and Hazard signage available?</label>
						<form:select id="safetysignage" path="safetySignage"  name="safetysignage"  class="form-control input-full filled" >
		                <form:option value="Select">Select</form:option>
		                <form:option value="Yes">Yes</form:option>
		                <form:option value="No">No</form:option>
		                
		                
		                </form:select>
								<form:errors path="safetySignage" cssClass="error" />
										
					</div>
					<div class="form-group ">
						<label for="Upload Image" class="placeholder" >Upload Image5 </label>
						<input type="file" path="safety_photo5"  class="form-control input-border-bottom"  id="img5"  name="file"  onchange="return ValidateImage('img2');"/> 
						<span class="isa_failure" id="image5">${errMsg}</span>
  					</div>
					<div class="form-group ">
						<label for="siteid" class="placeholder">Observations
				
						</label>
						 
						<form:input type="text" id="obv" path="observations" class="form-control input-full"  />				
						<form:errors path="observations" cssClass="error" />	
					</div>
  				
  					<div class="form-group ">
						<label for="Upload Image" class="placeholder" >Upload Image6 </label>
						<input type="file" path="safety_photo6"  class="form-control input-border-bottom"  id="img6"  name="file"  onchange="return ValidateImage('img2');"/> 
						<span class="isa_failure" id="image6">${errMsg}</span>
  					</div>
  					<div class="form-group ">
						<label for="Upload Image" class="placeholder" >Upload Image7 </label>
						<input type="file" path="safety_photo6"  class="form-control input-border-bottom"  id="img6"  name="file"  onchange="return ValidateImage('img2');"/> 
						<span class="isa_failure" id="image6">${errMsg}</span>
  					</div>
  				
  				
 						<div class="form-action" id="new_submit" >
				 		<input type="submit"  class="btn btn-rounded btn-login" value="Save" name="btn" style="background-color: #012169;color: white;">  
					
 						<!-- <input type="submit"  value="Save" class="btn btn-primary btn-rounded btn-login">  -->
 				
 				
				 		<input type="submit" class="btn btn-rounded btn-login" value="Save & Continue" name="btn" style="background-color: #012169;color: white;">  
					
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

<!-- Sweet Alert -->

<script src="<c:url value='resources/assets/js/plugin/sweetalert/sweetalert.min.js' />"></script>
<!-- jQuery Scrollbar -->
<script src="<c:url value='resources/assets/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js' />"></script>



<!-- jQuery Sparkline -->

<script src="<c:url value='resources/assets/js/plugin/jquery.sparkline/jquery.sparkline.min.js' />"></script>



</body>

</html>