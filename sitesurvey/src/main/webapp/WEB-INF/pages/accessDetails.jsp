<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html >
<html lang="en">
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

.error {
	color: #ff0000;
	font-style: italic;
	font-weight: bold;
}
</style>
<head>

<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="icon" href="<c:url value='resources/assets/img/icon.ico' />" type="image/x-icon"/>

<title>Site Survey</title>

	<meta content='width=device-width, initial-scale=1.0, shrink-to-fit=no' name='viewport' />
	<script src="<c:url value='resources/js/jquery.min.js' />"></script>
	
	<script src="<c:url value='resources/js/jquery-ui.min.js' />"></script>
	<script src="<c:url value='resources/js/validations.js' />"></script>
	
	<link rel="stylesheet" href="<c:url value='resources/css/jquery-ui.css' />">	
</head>
	<script type="text/javascript">
	var  siteId;
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
		   siteId=sessionStorage.getItem("site");
		
		   }

</script>


		

     
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


$(document).ready(function(){	
	 $("#navbar").load('<c:url value="/resources/common/header.jsp" />'); 
	  $("#technicianSidebar").load('<c:url value="/resources/common/technicianSidebar.jsp" />'); 
	  $("#siteAccess :input").attr("required",'');
	  getSiteAccessDetails(siteId);
	  //document.getElementById("accesstypespan").style.display = "none";
	  //document.getElementById("roadcondspan").style.display = "none";
	  //document.getElementById("commntsspan").style.display = "none";
	  //document.getElementById("image1sspan").style.display = "none";
	  //document.getElementById("image2sspan").style.display = "none";
	//  getRegions();
		//getSiteId();
		//$("#type,#username,#emailId,#pwd,#cpwd,#mobileNum,#region").attr('required', '');  
		 $(".isa_success").fadeOut(10000);
		 //$("input").attr("required", "true");
		document.getElementById('siteIdInpt').value=siteId;
		$('#siteIdInpt').prop('readonly', true);
		
		 $("select option:contains('Select')").attr("disabled","disabled");
		 document.getElementById("image1spanMSG").style.display = "none";
		 document.getElementById("image1span").style.display = "none";
		 
});

function getSiteAccessDetails(siteId)
{

	 $.ajax({
         type: "get",
         url: "getSiteAccessDetails",
         contentType: 'application/json',
         data:{"siteId":siteId},
         datatype: "json",
         success: function(result) {
            jsonData = JSON.parse(result);
            console.log("fasf"+JSON.stringify(jsonData));
            if(jsonData.length==0)
            {
            	
            }
            else
            {
            	$("#id").val(jsonData[0].id);
            	$("#accesstype").val(jsonData[0].accessType);
            	$("#condition").val(jsonData[0].roadCondition);
            	$("#obsrvcommnts").val(jsonData[0].comments);
         }
         }					
		 }); 
}

function redirectToOther()
{
	window.location.href = "/sitesurvey/siteArea";
} 

function ValidateFileUpload(id) {
    var fuData = document.getElementById(id);
    var FileUploadPath = fuData.value;

//To check if user upload any file
    if (FileUploadPath == '') {
    	 document.getElementById("image1spanMSG").style.display ="block";

    } else {
        var Extension = FileUploadPath.substring(
                FileUploadPath.lastIndexOf('.') + 1).toLowerCase();

//The file uploaded is an image

if (Extension == "gif" || Extension == "png" || Extension == "bmp"
                || Extension == "jpeg" || Extension == "jpg") {

//To Display
            if (fuData.files && fuData.files[0]) {
                var reader = new FileReader();

                reader.onload = function(e) {
                    $('#blah').attr('src', e.target.result);
                }

                reader.readAsDataURL(fuData.files[0]);
            }

        } 

//The file upload is NOT an image
else {
	        document.getElementById("image1span").style.display ="block";
            document.getElementById(id).value="";
        }
    }
}
/*function validate(){
	var accesstype=document.getElementById("accesstype").value;
	var roadcond=document.getElementById("condition").value;
	alert(roadcond);
	var commnts=document.getElementById("obsrvcommnts").value;
	 
	var image1=document.getElementById("photo1up").value;
	var image2=document.getElementById("photo2up").value;
	
	if(accesstype ==="Select"){
		 document.getElementById("accesstypespan").style.display = "block";
		 return false;
   }
	else{
		 document.getElementById("accesstypespan").style.display = "none";
		 
	}
	
	if(roadcond ==="Select"){
		 document.getElementById("roadcondspan").style.display = "block";
		 return false;
  }
	else{
		 document.getElementById("roadcondspan").style.display = "none";
		 
	}

	if(commnts ===""){
		 document.getElementById("commntsspan").style.display = "block";
		 return false;
 }
	else{
		 document.getElementById("commntsspan").style.display = "none";
		 
	}
	if(image1 ===""){
		 document.getElementById("image1span").style.display = "block";
		 return false;
}
	else{
		 document.getElementById("image1sspan").style.display = "none";
		 
	}
	if(image2 ===""){
		 document.getElementById("image2span").style.display = "block";
		 return false;
 }
	else{
		 document.getElementById("image2sspan").style.display = "none";
		 
	}
}*/


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
  <span class="isa_success" style="color:green;font-size:14px;">${status}</span>
			<h3 class="text-center">Site Access</h3>
			<span id="image1span" style="color:red">*Photo only allows file types of GIF, PNG, JPG, JPEG and BMP. *</span>
			<span id="image1spanMSG" style="color:red">*Please Upload an Image*</span>
			<form:form method="post" action="saveAccess"  id="siteAccess" modelAttribute="Site_Access" enctype="multipart/form-data" >
			<div class="login-form">	

					                
	          <div id="exchangeExistDiv">
	          <form:hidden path="id"/>
					<div class="form-group">
					<label for="siteid" class="placeholder">Site ID</label>
	                <form:input id="siteIdInpt" path="siteid.siteid" name="siteIdInpt"  class="form-control input-border "  />	
	                         
	            	</div>
            	</div>
          		  <div id="exchangeExistDiv" >
					<div class="form-group">
					<label for="accesstype" class="placeholder">Access Type</label>
	                <form:select id="accesstype"  path="accessType" name="accesstype" class="form-control input-border ">
	                <form:option value="" >Select</form:option>
	                <form:option value="Road">Road</form:option>
	                <form:option value="FootPath">Foot Path</form:option>
	                <form:option value="Stairway">Stairway</form:option>
	                <form:option value="Other">Other</form:option>
	                </form:select>	
	                <!-- <span id="accesstypespan" style="color:red">*Please Select Access Type*</span>-->
	                                      
	            	</div>
            	</div>
				

				  <div id="exchangeExistDiv" >
					<div class="form-group">
					<label for="condition" class="placeholder">Road Condition</label>
	                <form:select id="condition"  path="roadCondition" name="condition" class="form-control input-border " >
	                <form:option  value="" >Select</form:option>
	                <form:option value="Notassessed">Not assessed(Note why not assessed in observation)</form:option>
	                <form:option value="VeryPoor">Very Poor(very difficult to access, waterlogged, significant obstacles/tripping hazard etc.)</form:option>
	                <form:option value="Poor">Poor(Access with difficulty)</form:option>
	                <form:option value="Fair"> Fair(e.g. Mud road access, phisical constructions to accessing site)</form:option>
	                <form:option value="Good">Good(Paved road)</form:option>
	                <form:option value="VeryGood">Very good(Tarred or concrete road)</form:option>
	                <form:option value="Notapplicable">Not applicable</form:option>
	                </form:select>	  
	                 <!--<span id="roadcondspan" style="color:red">*Please Select Road Condition*</span> -->            
	            	</div>
            	</div>
				
				<div id="exchangeExistDiv">
					<div class="form-group">
					<label for="obsrvcommnts" class="placeholder">Observations/Comments</label>
	                <form:input id="obsrvcommnts" path="comments" name="obsrvcommnts" class="form-control input-border " />	   
	                <!-- <span id="commntsspan" style="color:red">*Please Enter Comments*</span>-->                  
	            	</div>
            	</div>
                
                <div id="exchangeExistDiv">
					<div class="form-group">
					<label for="photo1up" class="placeholder">Upload Image1(Photo 1) </label>
	                <input type="file" id="photo1up" name="file" accept="image/*" onchange="return ValidateFileUpload(this.id)" class="form-control input-border" />	
	                <!--<span id="image1sspan" style="color:red">*Please Upload Image*</span> -->         
	            	</div>
	            
            	</div>
				 <div id="exchangeExistDiv">
					<div class="form-group">
					<label for="photo2up" class="placeholder">Upload Image2(Photo 2) </label>
	                <input type="file" id="photo2up" name="file" accept="image/*" onchange="return ValidateFileUpload(this.id)" class="form-control input-border" />	
	                <!--<span id="image2sspan" style="color:red">*Please Upload Image*</span> -->              
	            	</div>
	            
            	</div>
				
                 
				<div class="form-action" id="typeDiv">	
				    <input type="submit" id="submit" name="clickBtn" value="Save" class="btn btn-rounded btn-login" style="background-color: #E4002B;color: white;">
					<input  type="submit" id="submit1" name="clickBtn" value="Save & Continue" class="btn btn-rounded btn-login"  style="background-color: #012169;color: white;">
					
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



</body>

</html>