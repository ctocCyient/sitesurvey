<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html >
<html lang="en">

<head>

	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="icon" href="<c:url value='resources/assets/img/icon.ico' />" type="image/x-icon"/>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<title>Site Survey</title>
	<meta content='width=device-width, initial-scale=1.0, shrink-to-fit=no' name='viewport' />
	<script type="text/javascript">
	

	 if(sessionStorage.getItem("username")==null)
	   	{
			//window.location.href = "/sitesurvey/";
			//alert(sessionStorage.getItem("username"));
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

<script src="<c:url value='resources/js/jquery.min.js' />"></script>
	
	<script src="<c:url value='resources/js/jquery-ui.min.js' />"></script>
	<script src="<c:url value='resources/js/validations.js' />"></script>
	
	<link rel="stylesheet" href="<c:url value='resources/css/jquery-ui.css' />">	
		

     
<script src="<c:url value='resources/assets/js/plugin/webfont/webfont.min.js' />"></script>
<link rel="stylesheet" href="<c:url value='resources/assets/css/bootstrap.min.css' />">
	<link rel="stylesheet" href="<c:url value='resources/assets/css/azzara.min.css' />">
  <script src="<c:url value='resources/js/base64js.min.js' />"></script>

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
	  $("#technicianSidebar").load('<c:url value="/resources/common/technicianSidebar.jsp" />'); 
	  $("#addGenerator :input").attr("required", '');
	  $("select option[value='Select']").attr('disabled','disabled');
		 $(".isa_success").fadeOut(10000);
		 var siteID=siteId;
		 $("#siteId").val(siteID);
		getGeneratorDetails(siteID);
		
});


function getGeneratorDetails(siteID)
{

	 $.ajax({
         type: "get",
         url: "getGeneratorDetails",
         contentType: 'application/json',
         data:{"siteId":siteID},
         datatype: "json",
         success: function(result) {
            jsonData = JSON.parse(result);
            if(jsonData.length==0)
            {
            	
            }
            else
            {
            	$("#id").val(jsonData[0].id);
            	$("#dgManufacturer").val(jsonData[0].dgManufacturer);
            	$("#date").val(jsonData[0].manufacturedDate);
            	$("#capacity").val(jsonData[0].capacity);
            	$("#DGrunhours").val(jsonData[0].DGrunhours);
            	$("#fuellevel").val(jsonData[0].fuellevel);
               	$("[name=assettagnumber]").val([jsonData[0].assettagnumber]);
            	$("#generatorCondition").val(jsonData[0].generatorCondition);
            	$("#comments").val(jsonData[0].comments);
            	
            }
         }					
		 }); 
}


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
var base64_1,jsonData;

function getGeneratorDetails(siteID)
{
	//alert("ji")

	 $.ajax({
         type: "get",
         url: "getGeneratorDetails",
         contentType: 'application/json',
         data:{"siteId":siteID},
         datatype: "json",
         success: function(result) {
            jsonData = JSON.parse(result);
            if(jsonData.length==0)
            {
            	 $("#imagediv1").hide();
                 $("#imagediv2").hide();
                 $("#imagediv3").hide();
                 $("#imagediv4").hide();
                 $("#imagediv5").hide();
                 $("#fileupload1").show();
                 $("#fileupload2").show();
                 $("#fileupload3").show();
                 $("#fileupload4").show();
                 $("#fileupload5").show();
                 $("#cnfrmr1").hide();
                 $("#cnfrmr2").hide();
                 $("#cnfrmr3").hide();
                 $("#cnfrmr4").hide();
                 $("#cnfrmr5").hide();
                
            }
            else
            {
            	$("#imagediv1").show();
                $("#imagediv2").show();
                $("#imagediv3").show();
                $("#imagediv4").show();
                $("#imagediv5").show();
                $("#fileupload1").hide();
                $("#fileupload2").hide();
                $("#fileupload3").hide();
                $("#fileupload4").hide();
                $("#fileupload5").hide();
               
                $("#id").val(jsonData[0].id);
            	$("#dgManufacturer").val(jsonData[0].dgManufacturer);
            	$("#date").val(jsonData[0].manufacturedDate);
            	$("#capacity").val(jsonData[0].capacity);
            	$("#DGrunhours").val(jsonData[0].DGrunhours);
            	$("#fuellevel").val(jsonData[0].fuellevel);
               	$("[name=assettagnumber]").val([jsonData[0].assettagnumber]);
            	$("#generatorCondition").val(jsonData[0].generatorCondition);
            	$("#comments").val(jsonData[0].comments);
            	$("#imaget1").val(jsonData[0].dg_photo_name);
            	$("#imaget2").val(jsonData[0].fuel_level_name);
            	$("#imaget3").val(jsonData[0].dg_inproper_1_name);
            	$("#imaget4").val(jsonData[0].dg_inproper_2_name);
            	$("#imaget5").val(jsonData[0].tag_photo_name);
            	
            	$("#addGenerator :input").removeAttr('required');
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
 
function ViewImage(pid){
	
	
	console.log(jsonData[0].pid);
	console.log(jsonData[0].tower_photo1)
	var imageData= base64js.fromByteArray(jsonData[0][pid])
	
	
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
.fa-bars,
.fa-ellipsis-v
{
color: #fff!important;
}
label {
    color: #495057!important;
    font-size: 13px!important;
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

.error {
	color: #ff0000;
	font-style: italic;
	font-weight: bold;
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
<%--     <div align="center"><span class="isa_success" style="color:#35B234;font-size:20px">${status}</span></div>	<br><br> --%>
    
			<h3 class="text-center">Add Generator</h3>
				<span id="msg" style="color:red;font-size:12px;">*All Fields are Mandatory*</span><br><br>
				
			<form:form action="saveGenerator" id="addGenerator"  method="post" modelAttribute="Site_Generator" enctype = 'multipart/form-data' >
			<div class="login-form">
			<!-- <span id="addMsg" style="font-size:18px;margin-left:221px;"><b>Add New</b><button type="submit" value="Add" name="submit"><i class="fa fa-plus-square" aria-hidden="true"></i></button></span><br><br>-->
			 <form:hidden path="id" id="id"/>
			<label for="siteid" class="placeholder"><b>Site Id</b></label>
				<form:input id="siteId" path="siteid.siteid" name="siteId" class="form-control input-full filled" readonly="true" />
				<form:errors path="siteid.siteid" cssClass="error"/>
			
				 <br>
				
				<label for="Manufacturer" class="placeholder"><b>Manufacturer</b></label>
				<form:input id="dgManufacturer" path="dgManufacturer" class="form-control input-full filled" onkeypress="return isCharacters(event);"/>
				<form:errors path="dgManufacturer" cssClass="error"/>
				
				<br>
				<label for="date" class="placeholder"><b>Date of Manufacturer/Installation</b></label>
				 <form:input id="date" type="date"  placeholder="mm/dd/yyyy" value="" path="manufacturedDate" class="form-control input-full filled" max="9999-12-31"/>
				 <form:errors path="manufacturedDate" cssClass="error"/>
				<br>
				
				<label for="capacity" class="placeholder"><b>Generator Capacity Rating(kVA)</b></label> 
				<form:input id="capacity" path="capacity"  name="capacity"  class="form-control input-full filled" onkeypress="return isNumber(event)" />
				<form:errors path="capacity" cssClass="error"/>
				<br>
               
				<label for="DGrunhours" class="DGrunhours"><b>DG Run hours(hrs)</b></label>
               <form:input id="DGrunhours" path="DGrunhours"  name="DGrunhours"  class="form-control input-full filled"  onkeypress="return isNumber(event)"/>
               <form:errors  path="DGrunhours" cssClass="error" />
               
               <br>
               
 				  	<label for="tagNumber" class="placeholder"><b>Asset Tag Number</b></label>
				 <form:radiobutton path="assettagnumber" name="assettagnumber" value="Yes"/> Yes 
        		 <form:radiobutton path="assettagnumber" name="assettagnumber" value="No"/>  No
				<br>
				
               <br>
               <!--  <br>
                <span class="isa_failure" style="color:red">${errMsg}</span>
                <label for="" class=""><b>Photos of Generator Control Unit(GCU)</b></label>
               <input type="file" id="GCUPhoto"  name="file"  class="form-control input-full filled" onchange="ValidateFileUpload(this.id)"/>
                <br> -->
                            
                
           		<div  id="fileupload1">
				<label for="Upload Image" class="placeholder" ><b>Photos of Generator Control Unit (GCU)</b></label>
				<input type="file"  class="form-control input-border-bottom"  id="img1" name="file" onchange="ValidateImage(this.id);"  /> 
				<span class="isa_failure" id="image0">${errMsg}</span>
  				</div>
  				<div id="imagediv1">
 					
  						<label for="Site photo1" class="placeholder" ><b>Photos of Generator Control Unit</b></label>
  						<div class="row mt-1" >
  						<div class="col-md-9">
  						<form:input type="text" id="imaget1" path="" class="form-control input-full"   readonly="true"  />
  						</div>	
  						<div class="col-md-3 " >
  						<form:input type="button" id="gdphoto" path="" value="View Image " onclick="ViewImage(this.id)"  class="form-control input-full btn btn-info"   />	
  						</div>
  						</div>
  					
  				</div>
  				<div id="cnfrmr1">
  				   <div class="row mt-1">   
  				 	<div class="col-md-7">
                  		<label for="Radio_1" class="placeholder" ><b>Do you want to upload Image</b></label><br>
                  	</div>
                  		<div class="col-md-3">Yes&nbsp;<input type="radio"  value="Yes" id="rdyes1" name="rdbtn1" onclick="upload_files(this)" />
                  	</div>
                  	<div class="col-md-2">No&nbsp;<input type="radio" onclick="upload_files(this)" id="rdno1"  value="No"  name="rdbtn1" checked/>
                 	</div>
                  </div>
 	
 				</div>
                <br>
                
                <label for="fuellevel" class="fuellevel"><b>Fuel Level at Site(%)</b></label>
                	 <form:input id="fuellevel" path="fuellevel"  name="fuellevel"  class="form-control input-full filled"  onkeypress="return isNumber(event)"/>
               	<br>
              
           	 <!-- 	<label for="" class=""><b>Photos of Fuel Level Sensor</b></label>
               	<input type="file" id="FLSPhoto"  name="file"  class="form-control input-full filled" onchange="ValidateFileUpload(this.id)" />
                <br> 
              
              	<label for="" class=""><b>Photo1 of the site(Which is not in proper condition)</b></label>
               	<input type="file" id="photo1"  name="file"  class="form-control input-full filled" onchange="ValidateFileUpload(this.id)" />
                <br> 
                
                <label for="" class=""><b>Photo2 of the site(Which is not in proper condition)</b></label>
               	<input type="file" id="photo2"  name="file"  class="form-control input-full filled"  onchange="ValidateFileUpload(this.id)"/>
                <br> 
              -->
              
              <!--  -->
              
                		<div id="fileupload2">
				<label for="Upload Image" class="placeholder" ><b>Photos of Fuel Level Sensor</b></label>
				<input type="file"  class="form-control input-border-bottom"  id="img2" name="file" onchange="ValidateImage(this.id);"  /> 
				<span class="isa_failure" id="image1">${errMsg}</span>
  				</div>
  				<div id="imagediv2">
 					
  						<label for="Site photo2" class="placeholder" ><b>Photos of Fuel Level Sensor</b></label>
  						<div class="row mt-1" >
  						<div class="col-md-9">
  						<form:input type="text" id="imaget2" path="" class="form-control input-full"   readonly="true"  />
  						</div>	
  						<div class="col-md-3 " >
  						<form:input type="button" id="fuellevel_photo" path="" value="View Image " onclick="ViewImage(this.id)"  class="form-control input-full btn btn-info"   />	
  						</div>
  						</div>
  					
  				</div>
  				<div id="cnfrmr2">
  				   <div class="row mt-1">   
  				 	<div class="col-md-7">
                  		<label for="Radio_2" class="placeholder" ><b>Do you want to upload Image</b></label><br>
                  	</div>
                  		<div class="col-md-3">Yes&nbsp;<input type="radio"  value="Yes" id="rdyes2" name="rdbtn2" onclick="upload_files(this)" />
                  	</div>
                  	<div class="col-md-2">No&nbsp;<input type="radio" onclick="upload_files(this)" id="rdno2"  value="No"  name="rdbtn2" checked/>
                 	</div>
                  </div>
 	
 				</div>
 				<br>
 				  		<div id="fileupload3">
				<label for="Upload Image" class="placeholder" ><b>Photo1 of the site(Which is not in proper condition)</b></label>
				<input type="file"  class="form-control input-border-bottom"  id="img3" name="file" onchange="ValidateImage(this.id);"  /> 
				<span class="isa_failure" id="image2">${errMsg}</span>
  				</div>
  				<div id="imagediv3">
 					
  						<label for="Site photo3" class="placeholder" ><b>Photo1 of the site(Which is not in proper condition)</b></label>
  						<div class="row mt-1" >
  						<div class="col-md-9">
  						<form:input type="text" id="imaget3" path="" class="form-control input-full"   readonly="true"  />
  						</div>	
  						<div class="col-md-3 " >
  						<form:input type="button" id="dg_inproper_1" path="" value="View Image " onclick="ViewImage(this.id)"  class="form-control input-full btn btn-info"   />	
  						</div>
  						</div>
  					
  				</div>
  				<div id="cnfrmr3">
  				   <div class="row mt-1">   
  				 	<div class="col-md-7">
                  		<label for="Radio_3" class="placeholder" ><b>Do you want to upload Image</b></label><br>
                  	</div>
                  		<div class="col-md-3">Yes&nbsp;<input type="radio"  value="Yes" id="rdyes3" name="rdbtn3" onclick="upload_files(this)" />
                  	</div>
                  	<div class="col-md-2">No&nbsp;<input type="radio" onclick="upload_files(this)" id="rdno3"  value="No"  name="rdbtn3" checked/>
                 	</div>
                  </div>
 	
 				</div>
 				<br>
 				  		<div id="fileupload4">
				<label for="Upload Image" class="placeholder" ><b>Photo2 of the site(Which is not in proper condition)</b></label>
				<input type="file"  class="form-control input-border-bottom"  id="img4" name="file" onchange="ValidateImage(this.id);"  /> 
				<span class="isa_failure" id="image3">${errMsg}</span>
  				</div>
  				<div id="imagediv4">
 					
  						<label for="Site photo4" class="placeholder" ><b>Photo2 of the site(Which is not in proper condition)</b></label>
  						<div class="row mt-1" >
  						<div class="col-md-9">
  						<form:input type="text" id="imaget4" path="" class="form-control input-full"   readonly="true"  />
  						</div>	
  						<div class="col-md-3 " >
  						<form:input type="button" id="dg_inproper_2" path="" value="View Image " onclick="ViewImage(this.id)"  class="form-control input-full btn btn-info"   />	
  						</div>
  						</div>
  					
  				</div>
  				<div id="cnfrmr4">
  				   <div class="row mt-1">   
  				 	<div class="col-md-7">
                  		<label for="Radio_4" class="placeholder" ><b>Do you want to upload Image</b></label><br>
                  	</div>
                  		<div class="col-md-3">Yes&nbsp;<input type="radio"  value="Yes" id="rdyes4" name="rdbtn4" onclick="upload_files(this)" />
                  	</div>
                  	<div class="col-md-2">No&nbsp;<input type="radio" onclick="upload_files(this)" id="rdno4"  value="No"  name="rdbtn4" checked/>
                 	</div>
                  </div>
 	
 				</div>
              <br>
              <!--  -->
              
            
				<!-- <br>
				<label for="" class=""><b>Asset Tag Photo</b></label>
               	<input type="file" id="tagPhoto"  name="file"  class="form-control input-full filled"  onchange="ValidateFileUpload(this.id)"/>
                <br> -->
                
         <!--  -->
           		<div id="fileupload5">
				<label for="Upload Image" class="placeholder" ><b>Tag Photo</b></label>
				<input type="file"  class="form-control input-border-bottom"  id="img5" name="file" onchange="ValidateImage(this.id);"  /> 
				<span class="isa_failure" id="image4">${errMsg}</span>
  				</div>
  				<div id="imagediv5">
 				
  						<label for="Site photo5" class="placeholder" ><b>Tag Photo</b></label>
  						<div class="row mt-1" >
  						<div class="col-md-9">
  						<form:input type="text" id="imaget5" path="" class="form-control input-full"   readonly="true"  />
  						</div>	
  						<div class="col-md-3 " > 
  						<form:input type="button" id="tag_photo" path="" value="View Image " onclick="ViewImage(this.id)"  class="form-control input-full btn btn-info"   />	
  						</div>
  						</div>
  				
  				</div>
  				<div id="cnfrmr5">
  				   <div class="row mt-1">   
  				 	<div class="col-md-7">
                  		<label for="Radio_5" class="placeholder" ><b>Do you want to upload Image</b></label><br>
                  	</div>
                  		<div class="col-md-3">Yes&nbsp;<input type="radio"  value="Yes" id="rdyes5" name="rdbtn5" onclick="upload_files(this)" />
                  	</div>
                  	<div class="col-md-2">No&nbsp;<input type="radio" onclick="upload_files(this)" id="rdno5"  value="No"  name="rdbtn5" checked/>
                 	</div>
                  </div>
 	
 				</div>
 				
 				<!--  -->
 				<br>
				
              	<label for="Condition" class="Condition"><b>Condition</b></label>
              	 <form:select id="generatorCondition" path="generatorCondition"  name="generatorCondition"  class="form-control input-full filled" >
              	 <form:option value="Select">Select</form:option>
              	 <form:option value="Not assessed">Not assessed (Note why not assessed in observation)</form:option>
              	 <form:option value="Very Poor">Very Poor. Burnt,needing urgent repairs cannablised</form:option>
              	 <form:option value="Poor">Poor (Broken down condition needing replacement)</form:option>
              	 <form:option value="Fair">Fair (Working without any major issues)</form:option>
              	 <form:option value="Good">Good (Working with no issues at all)</form:option>
              	 <form:option value="Very Good">Very good (Looks as good as new)</form:option>
              	 <form:option value="Not Applicable">Not Applicable</form:option>
              	 </form:select>
                <br>
                
                <label for="comments" class="placeholder"><b>Comments</b></label> 
				<form:input id="comments" path="comments"  name="comments"  class="form-control input-full filled"  />
				<br>
                
				<div class="form-action">
				<a href="siteWiring" class="btn btn-rounded btn-login btn-warning">Previous</a>
					<!-- <a href="home" id="show-signin" class="btn btn-rounded btn-login mr-3" style="background-color: #E4002B;color: white;">Cancel</a>-->
					<input type="submit" value="Save for Later" name="submit" class="btn btn-rounded btn-login btn-danger" style="background-color: #E4002B;color: white;">
					<input type="submit" value="Next" name="submit" class="btn btn-rounded btn-login btn-primary" style="background-color: #012169;color: white;">
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

<!-- Sweet Alert -->

<script src="<c:url value='resources/assets/js/plugin/sweetalert/sweetalert.min.js' />"></script>
<!-- jQuery Sparkline -->

<script src="<c:url value='resources/assets/js/plugin/jquery.sparkline/jquery.sparkline.min.js' />"></script>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>



</body>

</html>