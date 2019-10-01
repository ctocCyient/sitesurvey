<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String jsondetails=(String)request.getParameter("ticketDetails"); 
   System.out.println("json>>>>>>>"+jsondetails);%>
<%-- <% String status=(String)request.getAttribute("status"); %> --%>

<%-- <% String btnClick=(String)request.getAttribute("btnClick");  --%>
<%--   System.out.println("btnclck>>>>>>>"+btnClick);%> --%>
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
  <script src="<c:url value='resources/js/base64js.min.js' />"></script>
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

var inventoryData;
var ticketId,ticketType;
var ticketStatus;


var jsonDetails;
$(document).ready(function(){	
	

<%-- 	var status='<%=status%>'; --%>

<%-- 	var btnClick='<%=btnClick%>'; --%>
// 	//alert(status);
// 	 if(status=='Saved')


//      {
//                   var nextUrl;
//               if(btnClick=="Save"){
//                     nextUrl="/sitesurvey/home";
//               }
//               else if(btnClick=="Save & Continue"){
//                     nextUrl="/sitesurvey/gotoAdditional";
//               }
//               swal({
//                          //title: 'Are you sure?',
//                          text: "Details Saved Successfully",
//                          type: 'info',
//                          buttons:{
//                                 confirm: {
//                                        text : 'Ok',
//                                        className : 'btn btn-success'
//                                 }
//                          }
//                   }).then((Delete) => {
//                          if (Delete) {
//                                 window.location.href = nextUrl;
//                          }
//                   });
//             }
	
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

function ValidateImage(id){
	var i=id[id.length-1];
	  var fuData = document.getElementById(id);
  var FileUploadPath = fuData.value;
//To check if user upload any file
  if (FileUploadPath == '') {
	  
      alert("Please upload an image");
 } else {
      var Extension = FileUploadPath.substring(
              FileUploadPath.lastIndexOf('.') + 1).toLowerCase();
//The file uploaded is an image
if (Extension == "gif" || Extension == "png" || Extension == "bmp"|| Extension == "jpeg" || Extension == "jpg") {
//To Display
		  $("#image"+i)[0].innerHTML="";
          if (fuData.files && fuData.files[0]) {
             var reader = new FileReader();
             reader.onload = function(e) {
                 // $('#blah').attr('src', e.target.result);
              }
             reader.readAsDataURL(fuData.files[0]);
          }
     }
//The file upload is NOT an image
else {
       //  alert("Photo only allows file types of GIF, PNG, JPG, JPEG and BMP. ");
         $("#image"+i)[0].innerHTML="Uploaded file must be Image Format";  
       document.getElementById(id).value="";
      }
  }
}
var base64_1;
var jsonData1;

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
            jsonData1 = JSON.parse(result);
            safetyjsonData=JSON.parse(result);
            console.log("json"+safetyjsonData);
            if(safetyjsonData.length==0)
            {
            	 $("#imagediv1").hide();
                 $("#imagediv2").hide();
                 $("#imagediv3").hide();
                 $("#imagediv4").hide();
                 $("#imagediv5").hide();
                 $("#imagediv6").hide();
                 $("#imagediv7").hide();
                 $("#fileupload1").show();
                 $("#fileupload2").show();
                 $("#fileupload3").show();
                 $("#fileupload5").show();
                 $("#fileupload6").show();
                 $("#fileupload7").show();
                 $("#fileupload4").show();
                 $("#cnfrmr1").hide();
                 $("#cnfrmr2").hide();
                 $("#cnfrmr3").hide();
                 $("#cnfrmr4").hide();
                 $("#cnfrmr5").hide();
                 $("#cnfrmr6").hide();
                 $("#cnfrmr7").hide();
            }
            else
            {
            	$("#imagediv1").show();
                $("#imagediv2").show();
                $("#imagediv3").show();
                $("#imagediv4").show();
                $("#imagediv5").show();
                $("#imagediv6").show();
                $("#imagediv7").show();
                $("#fileupload1").hide();
                $("#fileupload2").hide();
                $("#fileupload3").hide();
                $("#fileupload4").hide();
                $("#fileupload5").hide();
                $("#fileupload6").hide();
                $("#fileupload7").hide();
                
            	//alert(jsonData[0].id)
            	$("#safetyid").val(safetyjsonData[0].id);
            	$("#securitycondition").val(safetyjsonData[0].extinguishersAvailability);
            	$("#edate").val(safetyjsonData[0].extinguishersDueDate);
            	$("#aviationlight").val(safetyjsonData[0].aviationLights);
            	$("#arrestor").val(safetyjsonData[0].lightningArrestor);
            	$("#rttloc").val(safetyjsonData[0].rtt_rtp_locations);
               	$("#stairs").val(safetyjsonData[0].stairsLaddersCondition);
            	$("#climbdevice").val(safetyjsonData[0].safeClimbDevice);
            	$("#anticlimbdevice").val(safetyjsonData[0].antiClimbProtection);
            	$("#fireclear").val(safetyjsonData[0].siteFireClear);
            	$("#oilspill").val(safetyjsonData[0].oilSpillsDG);
            	$("#safetysignage").val(safetyjsonData[0].safetySignage);
            	$("#obv").val(safetyjsonData[0].observations);
            	$("#imaget1").val(safetyjsonData[0].safety_photo1_name);
            	$("#imaget2").val(safetyjsonData[0].safety_photo2_name);
            	$("#imaget3").val(safetyjsonData[0].safety_photo3_name);
            	$("#imaget4").val(safetyjsonData[0].safety_photo4_name);
            	$("#imaget5").val(safetyjsonData[0].safety_photo2_name);
            	$("#imaget6").val(safetyjsonData[0].safety_photo3_name);
            	$("#imaget7").val(safetyjsonData[0].safety_photo4_name);
            	
            	$("#safetyform :input").removeAttr('required');
            }
         }					
		 }); 
}


function upload_files(id){
	
	var rdBtnid=id.id
	//var Value = $("input[name='"+id.name+"']:checked").val();
    //var name = $("input[name='"+id.name+"']:checked").val();
	var i=rdBtnid[rdBtnid.length-1];
	
	if(id.value=="Yes"){
		$("#imagediv"+i).hide();
		$("#fileupload"+i).show();
		//$("#site_photo1").attr('disabled',false);
    	//$("#site_photo2").attr('disabled',false);
	}else if(id.value=="No"){
		$("#imagediv"+i).show();
		$("#fileupload"+i).hide();
		//$("#site_photo1").attr('disabled',true);
    	//$("#site_photo2").attr('disabled',true);
	}
	
	
	
}
 
function ViewImage(id){
	
	//alert(jsonData1)
	var i=id[id.length-1];
	//var i=2
	var pid="safety_photo"+i
	console.log(jsonData[0].pid);
	console.log(jsonData[0].tower_photo1)
	var imageData= base64js.fromByteArray(jsonData1[0][pid])
	
	
	//alert(imageData);
	var imageNum="Photo"+i;
	  var htmlstring = "<img id='ItemPreview' 'src=data:image/jpeg;base64,"+imageData+"' width='104' height='142'>";
    //$("#ItemPreview").attr('src', 'data:image/jpeg;base64,' + base64);
       Swal.fire({
                title: "<i>"+imageNum+"</i>",
                html: "<center><table border='0'><tr><td><img id='ItemPreview' src='data:image/jpeg;base64,"+imageData+"' width='300' height='300'></td></tr></table><center>", 
                timer: 1000,
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
				
						<label for="siteid" class="placeholder"><b>Site Id</b>
				
						</label>
						 
						<form:input type="text" id="siteid" path="siteid.siteid" class="form-control input-full" readonly="true"  />				
						<form:errors path="siteid.siteid" cssClass="error" />	
				
				<br>
						<label for="extinguishersAvailability" class="placeholder"><b>Are Fire extinguishers available (Non expired)?</b> </label>
						<form:select id="securitycondition" path="extinguishersAvailability"  name="overallconditon"  class="form-control input-full filled" >
		                <form:option value="Select">Select</form:option>
		                <form:option value="Yes">Yes</form:option>
		                <form:option value="No">No</form:option>
		                <form:option value="Unknown">Unknown</form:option>
		                
		                </form:select>
								<form:errors path="extinguishersAvailability" cssClass="error" />
										
				
				<br>	
					
						<label for="edate" class="placeholder"><b>When are fire extinguishers due for a service?</b></label>
						<form:input type="date" id="edate" path="extinguishersDueDate" class="form-control input-full"  />				
						<form:errors path="extinguishersDueDate" cssClass="error" />	
					<br>
						
				<div id="fileupload1">
				<label for="Upload Image" class="placeholder" ><b>Photo 1 </b></label>
				<input type="file"   class="form-control input-border-bottom"  id="img1" name="file" onchange="ValidateImage(this.id);"  /> 
				<span class="isa_failure" id="image0">${errMsg}</span>
  				</div>
  				<div id="imagediv1">
 				
  						<label for="Site photo1" class="placeholder" ><b>Photo 1</b></label>
  						<div class="row mt-1" >
  						<div class="col-md-9">
  						<form:input type="text" id="imaget1" path="" class="form-control input-full"   readonly="true"  />
  						</div>	
  						<div class="col-md-3 " >
  						<form:input type="button" id="imageb1" path="" value="View Image " onclick="ViewImage(this.id)"  class="form-control input-full btn btn-info"   />	
  						</div>
  						</div>
  					
  				</div>
  				<div id="cnfrmr1">
  				   <div class="row mt-1">   
  				 	<div class="col-md-7">
                  		<label for="Radio_1" class="placeholder" ><b>Do you want to upload Image</b></label><br>
                  	</div>
                  		<div class="col-md-3">Yes<input type="radio"  value="Yes" id="rdyes1" name="rdbtn1" onclick="upload_files(this)" />
                  	</div>
                  	<div class="col-md-2">No<input type="radio" onclick="upload_files(this)" id="rdno1"  value="No"  name="rdbtn1" checked/>
                 	</div>
                  </div>
 	
 				</div>
 				
 				<br>
  				
						<label for="aviationlight" class="placeholder"><b>Does the tower have a aviation lights?></b></label>
						<form:select id="aviationlight" path="aviationLights"  name="aviationlight"  class="form-control input-full filled" >
		                <form:option value="Select">Select</form:option>
		                <form:option value="Yes">Yes</form:option>
		                <form:option value="No">No</form:option>
		                <form:option value="Unknown">Unknown</form:option>
		                
		                </form:select>
								<form:errors path="aviationLights" cssClass="error" />
										
					<br>
					
						<label for="arrestor" class="placeholder"><b>Is the lighting arrestor spike and connection to tower or earthing available?</b></label>
						<form:select id="arrestor" path="lightningArrestor"  name="arrestor"  class="form-control input-full filled" >
		                <form:option value="Select">Select</form:option>
		                <form:option value="Yes">Yes</form:option>
		                <form:option value="No">No</form:option>
		                <form:option value="Unknown">Unknown</form:option>
		                
		                </form:select>
								<form:errors path="lightningArrestor" cssClass="error" />
										
					<br>
						<label for="rttloc" class="placeholder"><b>For RTT/RTP loactions,are protection rails or parapet walls available </b></label>
						<form:select id="rttloc" path="rtt_rtp_locations"  name="rttloc"  class="form-control input-full filled" >
		                <form:option value="Select">Select</form:option>
		                <form:option value="Yes">Yes</form:option>
		                <form:option value="No">No</form:option>
		                <form:option value="Unknown">Unknown</form:option>
		                
		                </form:select>
								<form:errors path="rtt_rtp_locations" cssClass="error" />
										
					<br>
  				
  				
 				<div id="fileupload2">
				<label for="Upload Image" class="placeholder" ><b>Photo 2 </b> </label>
				<input type="file"   class="form-control input-border-bottom"  id="img2"  name="file"  onchange="ValidateImage(this.id)"/> 
					<span class="isa_failure" id="image2">${errMsg}</span>
  				</div>
  				<div id="imagediv2">
 					
  						<label for="photo2" class="placeholder" ><b>Photo 2</b></label>
  						<div class="row mt-1" >
  						<div class="col-md-9">
  						<form:input type="text" id="imaget2" path="" class="form-control input-full"   readonly="true"  />
  						</div>	
  						<div class="col-md-3 " >
  						<form:input type="button" id="imageb2" path="" value="View Image " onclick="ViewImage(this.id)"  class="form-control input-full btn btn-info"   />	
  						</div>
  						</div>
  				
  				</div>
  				<div id="cnfrmr2">
  				   <div class="row mt-1">   
  				 	<div class="col-md-7">
                  		<label for="Radio_2" class="placeholder" ><b>Do you want to upload Image</b></label><br>
                  	</div>
                  		<div class="col-md-3">Yes<input type="radio"  value="Yes" id="rdyes2" name="rdbtn2" onclick="upload_files(this)" />
                  	</div>
                  	<div class="col-md-2">No<input type="radio" onclick="upload_files(this)" id="rdno2"  value="No"  name="rdbtn2" checked/>
                 	</div>
                  </div>
 	
 				</div>
  				<br>
  			
						<label for="stairs" class="placeholder"><b>Stairs or ladders-are they in good condition with no missing rungs etc?</b></label>
						<form:select id="stairs" path="stairsLaddersCondition"  name="stairs"  class="form-control input-full filled" >
		                <form:option value="Select">Select</form:option>
		                <form:option value="Yes">Yes</form:option>
		                <form:option value="No">No</form:option>
		                <form:option value="Not Applicable">Not Applicable</form:option>
		                </form:select>
								<form:errors path="stairsLaddersCondition" cssClass="error" />
										
				<br>
					
					<div id="fileupload3">
						<label for="Upload Image" class="placeholder" ><b>Photo 3 </b> </label>
						<input type="file"   class="form-control input-border-bottom"  id="img3"  name="file"  onchange="ValidateImage(this.id);"/> 
						<span class="isa_failure" id="image3">${errMsg}</span>
  					</div>
					
					<div id="imagediv3">
 					
  						<label for=" photo3" class="placeholder" ><b>Photo 3</b></label>
  						<div class="row mt-1" >
  						<div class="col-md-9">
  						<form:input type="text" id="imaget3" path="" class="form-control input-full"   readonly="true"  />
  						</div>	
  						<div class="col-md-3 " >
  						<form:input type="button" id="imageb3" path="" value="View Image " onclick="ViewImage(this.id)"  class="form-control input-full btn btn-info"   />	
  						</div>
  						</div>
  					</div>
  					
  					
  				<div id="cnfrmr3">
  				   <div class="row mt-1">   
  				 	<div class="col-md-7">
                  		<label for="Radio_3" class="placeholder" ><b>Do you want to upload Image</b></label><br>
                  	</div>
                  		<div class="col-md-3">Yes<input type="radio"  value="Yes" id="rdyes3" name="rdbtn3" onclick="upload_files(this)" />
                  	</div>
                  	<div class="col-md-2">No<input type="radio" onclick="upload_files(this)" id="rdno3"  value="No"  name="rdbtn3" checked/>
                 	</div>
                  </div>
 	
 				</div>
 				<br>
					
						<label for="climbdevice" class="placeholder"><b>Is there safe climb device installed on ladder ? (Typically a cable or rail)</b></label>
						<form:select id="climbdevice" path="safeClimbDevice"  name="climbdevice"  class="form-control input-full filled" >
		                <form:option value="Select">Select</form:option>
		                <form:option value="Yes">Yes</form:option>
		                <form:option value="No">No</form:option>
		                </form:select>
								<form:errors path="safeClimbDevice" cssClass="error" />
										
				<br>
						<label for="anticlimbdevice" class="placeholder"><b>Is the anti climb protection in place?</b></label>
						<form:select id="anticlimbdevice" path="antiClimbProtection"  name="anticlimbdevice"  class="form-control input-full filled" >
		                <form:option value="Select">Select</form:option>
		                <form:option value="Yes">Yes</form:option>
		                <form:option value="No">No</form:option>
		                
		                
		                </form:select>
								<form:errors path="antiClimbProtection" cssClass="error" />
										
					<br>
						<label for="fireclear" class="placeholder"><b>Is the site clear of fire hazard rubble, installation material, released old equipment etc.?</b></label>
						<form:select id="fireclear" path="siteFireClear"  name="fireclear"  class="form-control input-full filled" >
		                <form:option value="Select">Select</form:option>
		                <form:option value="Yes">Yes</form:option>
		                <form:option value="No">No</form:option>
		                
		                
		                </form:select>
								<form:errors path="siteFireClear" cssClass="error" />
										
				<br>
					<div  id="fileupload4">
						<label for="Upload Image" class="placeholder" ><b>Photo 4</b></label>
						<input type="file" class="form-control input-border-bottom"  id="img4"  name="file"  onchange="ValidateImage(this.id);"/> 
						<span class="isa_failure" id="image4">${errMsg}</span>
  					</div>
  					<div id="imagediv4">
 					
  						<label for="photo4" class="placeholder" ><b>Photo 4</b></label>
  						<div class="row mt-1" >
  						<div class="col-md-9">
  						<form:input type="text" id="imaget4" path="" class="form-control input-full"   readonly="true"  />
  						</div>	
  						<div class="col-md-3 " >
  						<form:input type="button" id="imageb4" path="" value="View Image " onclick="ViewImage(this.id)"  class="form-control input-full btn btn-info"   />	
  						</div>
  						</div>
  					
  					</div>
  				<div id="cnfrmr4">
  				   <div class="row mt-1">   
  				 	<div class="col-md-7">
                  		<label for="Radio_4" class="placeholder" ><b>Do you want to upload Image</b></label><br>
                  	</div>
                  		<div class="col-md-3">Yes<input type="radio"  value="Yes" id="rdyes4" name="rdbtn4" onclick="upload_files(this)" />
                  	</div>
                  	<div class="col-md-2">No<input type="radio" onclick="upload_files(this)" id="rdno4"  value="No"  name="rdbtn4" checked/>
                 	</div>
                  </div>
 	
 				</div>
  					<br>
					
						<label for="oilspill" class="placeholder"><b>Are there oil spills in the DG area (Diesel + Engine oil etc. )?</b></label>
						<form:select id="oilspill" path="oilSpillsDG"  name="oilspill"  class="form-control input-full filled" >
		                <form:option value="Select">Select</form:option>
		                <form:option value="Yes">Yes</form:option>
		                <form:option value="No">No</form:option>
		                
		                </form:select>
								<form:errors path="oilSpillsDG" cssClass="error" />
					<br>
						<label for="safetysignage" class="placeholder"><b>Are safety and Hazard signage available?</b></label>
						<form:select id="safetysignage" path="safetySignage"  name="safetysignage"  class="form-control input-full filled" >
		                <form:option value="Select">Select</form:option>
		                <form:option value="Yes">Yes</form:option>
		                <form:option value="No">No</form:option>
		                
		                
		                </form:select>
								<form:errors path="safetySignage" cssClass="error" />
										
					<br>
					<div id="fileupload5">
						<label for="Upload Image" class="placeholder" ><b>Photo 5</b></label>
						<input type="file"  class="form-control input-border-bottom"  id="img5"  name="file"  onchange="ValidateImage(this.id);"/> 
						<span class="isa_failure" id="image5">${errMsg}</span>
  					</div>
  					
  				<div id="cnfrmr5">
  				   <div class="row mt-1">   
  				 	<div class="col-md-7">
                  		<label for="Radio_5" class="placeholder" ><b>Do you want to upload Image</b></label><br>
                  	</div>
                  		<div class="col-md-3">Yes<input type="radio"  value="Yes" id="rdyes5" name="rdbtn5" onclick="upload_files(this)" />
                  	</div>
                  	<div class="col-md-2">No<input type="radio" onclick="upload_files(this)" id="rdno5"  value="No"  name="rdbtn5" checked/>
                 	</div>
                  </div>
 	
 				</div>
				<br>
						<label for="siteid" class="placeholder"><b>Observations</b>
				
						</label>
						 
						<form:input type="text" id="obv" path="observations" class="form-control input-full"  />				
						<form:errors path="observations" cssClass="error" />	
					<br>
  				
  					<div id="fileupload6">
						<label for="Upload Image" class="placeholder" ><b>Photo 6 </b> </label>
						<input type="file" class="form-control input-border-bottom"  id="img6"  name="file"  onchange="ValidateImage(this.id);"/> 
						<span class="isa_failure" id="image6">${errMsg}</span>
  					</div>
  					<div id="imagediv6">
 					<div class="form-group" >
  						<label for="photo6" class="placeholder" ><b>Photo 6</b></label>
  						<div class="row mt-1" >
  						<div class="col-md-9">
  						<form:input type="text" id="imaget6" path="" class="form-control input-full"   readonly="true"  />
  						</div>	
  						<div class="col-md-3 " >
  						<form:input type="button" id="imageb6" path="" value="View Image " onclick="ViewImage(this.id)"  class="form-control input-full btn btn-info"   />	
  						</div>
  						</div>
  					</div>
  					</div>
  				<div id="cnfrmr6">
  				   <div class="row mt-1">   
  				 	<div class="col-md-7">
                  		<label for="Radio_6" class="placeholder" ><b>Do you want to upload Image</b></label><br>
                  	</div>
                  		<div class="col-md-3">Yes<input type="radio"  value="Yes" id="rdyes6" name="rdbtn6" onclick="upload_files(this)" />
                  	</div>
                  	<div class="col-md-2">No<input type="radio" onclick="upload_files(this)" id="rdno6"  value="No"  name="rdbtn6" checked/>
                 	</div>
                  </div>
 	
 				</div>
 				<br>
  					<div id="fileupload7">
						<label for="Upload Image" class="placeholder" ><b>Photo 7 </b></label>
						<input type="file" class="form-control input-border-bottom"  id="img7"  name="file"  onchange="ValidateImage(this.id);"/> 
						<span class="isa_failure" id="image7">${errMsg}</span>
  					</div>
  				<div id="imagediv7">
 				
  						<label for="photo7" class="placeholder" ><b>Photo7</b></label>
  						<div class="row mt-1" >
  						<div class="col-md-9">
  						<form:input type="text" id="imaget7" path="" class="form-control input-full"   readonly="true"  />
  						</div>	
  						<div class="col-md-3 " >
  						<form:input type="button" id="imageb7" path="" value="View Image " onclick="ViewImage(this.id)"  class="form-control input-full btn btn-info"   />	
  						</div>
  						</div>
  					</div>
  					
  				<div id="cnfrmr7">
  				   <div class="row mt-1">   
  				 	<div class="col-md-7">
                  		<label for="Radio_7" class="placeholder" ><b>Do you want to upload Image</b></label><br>
                  	</div>
                  		<div class="col-md-3">Yes<input type="radio"  value="Yes" id="rdyes7" name="rdbtn7" onclick="upload_files(this)" />
                  	</div>
                  	<div class="col-md-2">No<input type="radio" onclick="upload_files(this)" id="rdno4"  value="No"  name="rdbtn7" checked/>
                 	</div>
                  </div>
 	
 				</div>
  				
 						<div class="form-action" id="new_submit" >
				 		<input type="submit"  class="btn btn-rounded btn-login" value="Save" name="btn" style="background-color: #E4002B;color: white;">  
					
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

<!-- Sweet Alert -->

<script src="<c:url value='resources/assets/js/plugin/sweetalert/sweetalert.min.js' />"></script>
<!-- jQuery Sparkline -->

<script src="<c:url value='resources/assets/js/plugin/jquery.sparkline/jquery.sparkline.min.js' />"></script>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>




</body>

</html>