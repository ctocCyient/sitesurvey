<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- <% String status=(String)request.getAttribute("PPEStatus"); %> --%>
<%-- <% String btnClick=(String)request.getAttribute("btnClick"); %> --%>
<!DOCTYPE html >
<html lang="en">

<head>

<spring:url value="resources/css/styling.css" var="mainCss" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<link rel="icon" href="<c:url value='resources/assets/img/icon.ico' />" type="image/x-icon"/>
<title>Site Survey</title>
	<meta content='width=device-width, initial-scale=1.0, shrink-to-fit=no' name='viewport' />

	<script src="<c:url value='resources/js/jquery.min.js' />"></script>
	
	<script src="<c:url value='resources/js/jquery-ui.min.js' />"></script>
	<script src="<c:url value='resources/js/validations.js' />"></script>
	
	<link rel="stylesheet" href="<c:url value='resources/css/jquery-ui.css' />">
	
	
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>

		
	<link rel="stylesheet" type="text/css" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" />

     
<script src="<c:url value='resources/assets/js/plugin/webfont/webfont.min.js' />"></script>
 <script src="<c:url value='resources/js/base64js.min.js' />"></script>

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


            p {
                padding-left: 10px;
/*                 background-color: #00ae42; */
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

<script type="text/javascript">


WebFont.load({
	google: {"families":["Open+Sans:300,400,600,700"]},
	custom: {"families":["Flaticon", "Font Awesome 5 Solid", "Font Awesome 5 Regular", "Font Awesome 5 Brands"], urls: ["<c:url value='resources/assets/css/fonts.css' />"]},
	active: function() {
		sessionStorage.fonts = true;
	}
});
var surveyTeamDetails;
$(document).ready(function(){	
	$("#navbar").load('<c:url value="/resources/common/header.jsp" />'); 
	 $("#technicianSidebar").load('<c:url value="/resources/common/technicianSidebar.jsp" />'); 
	 $("#siteid")[0].value=siteId;
	  $('#siteid').attr('readonly','readonly');
	  $("#technicianName,#rigger_Name").attr('required', '');  
	 getSurveyTeamPPEDetails();

<%-- 	 var status='<%=status%>'; --%>
<%-- 	 var btnClick='<%=btnClick%>'; --%>
// 		// $(".isa_success").fadeOut(10000);
		
		
// 		 if(status=='Saved')
// 		{
// 			 	var nextUrl;
// 			  if(btnClick=="Save"){
// 				  nextUrl="/sitesurvey/home";
// 			  }
// 			  else if(btnClick=="Save & Continue"){
// 				  nextUrl="/sitesurvey/siteAccess";
// 			  }
// 			  swal({
// 					//title: 'Are you sure?',
// 					text: "Details Saved Successfully",
// 					type: 'info',
// 					buttons:{
// 						confirm: {
// 							text : 'Ok',
// 							className : 'btn btn-success'
// 						}
// 					}
// 				}).then((Delete) => {
// 					if (Delete) {
// 						window.location.href = nextUrl;
// 					} 
// 				});
// 			}
	
});


function getSurveyTeamPPEDetails()
{
	$.ajax({
        type:"get",
        url:"getSurveyTeamPPEDetails",
        contentType: 'application/json',
        datatype : "json",
        data:{"selectedSiteId":siteId},
        success:function(result) {
        	 surveyTeamDetails= JSON.parse(result);   
        	console.log("xzv"+JSON.stringify(surveyTeamDetails));
       	  if(surveyTeamDetails.length==0){
       	        $("#imagediv1").hide();
       	        $("#imagediv2").hide();
       	        $("#imagediv3").hide();
       	        $("#fileupload1").show();
       	        $("#fileupload2").show();
       	        $("#fileupload3").show();
       	        $("#cnfrmr1").hide();
       	        $("#cnfrmr2").hide();
       	        $("#cnfrmr3").hide();
       	        }
       	  else{
       		 
       		$("#imagediv1").show();
            $("#imagediv2").show();
            $("#imagediv3").show();
            $("#fileupload1").hide();
            $("#fileupload2").hide();
            $("#fileupload3").hide();
            
        		$("#ppeId")[0].value=surveyTeamDetails[0].id;
 			  	$("#ppe").val(surveyTeamDetails[0].ppe);
 			  	$("#technicianName")[0].value=surveyTeamDetails[0].technicianName;
 			 	$("#rigger_Name")[0].value=surveyTeamDetails[0].rigger_Name;
 			
	 			$.each(surveyTeamDetails[0].rigger_Wearing.split(','), function(i, val){
	 			   $("input[name='rigger_Wearing'][value='" + val + "']").prop('checked', true);
	 			});
	 			
	 			$.each(surveyTeamDetails[0].technicianWearing.split(','), function(i, val){
	  			   $("input[name='technicianWearing'][value='" + val + "']").prop('checked', true);
	  			});
			  
	 			
	 			$("#imaget1").val(surveyTeamDetails[0].photoSurveyTeamName);
	        	$("#imaget2").val(surveyTeamDetails[0].photoTechnicianTeamName);
	        	$("#imaget3").val(surveyTeamDetails[0].photoRiggerTeamName);
	        	
	        	
        	  }
        }
	});
}



// function ValidateImage(id){
	
// 	var  i=id[id.length-1];
// 		  var fuData = document.getElementById(id);
//       var FileUploadPath = fuData.value;
// //To check if user upload any file
//       if (FileUploadPath == '') {
//           alert("Please upload an image");
//      } else {
//           var Extension = FileUploadPath.substring(
//                   FileUploadPath.lastIndexOf('.') + 1).toLowerCase();
// //The file uploaded is an image
// if (Extension == "gif" || Extension == "png" || Extension == "bmp"|| Extension == "jpeg" || Extension == "jpg") {
// //To Display
// 			 $("#image"+i)[0].innerHTML="";
//               if (fuData.files && fuData.files[0]) {
//                  var reader = new FileReader();
//                  reader.onload = function(e) {
//                      // $('#blah').attr('src', e.target.result);
//                   }
//                  reader.readAsDataURL(fuData.files[0]);
//               }
//          }
// //The file upload is NOT an image
// else {
//            // alert("Photo only allows file types of GIF, PNG, JPG, JPEG and BMP. ");
//               $("#image"+i)[0].innerHTML="Uploaded file must be Image Format";
//              document.getElementById(id).value="";
//           }
//       }
//   }
  
  
  

function ValidateImage(id){
	 	var i=id[id.length-1];
		  var fuData = document.getElementById(id);
	     var FileUploadPath = fuData.value;
	//To check if user upload any file
	     if (FileUploadPath == '') {
	   	//  $("#image"+i)[0].innerHTML="Please upload an image";  
	        // alert("Please upload an image");
	    } else {
   	 
         var Extension = FileUploadPath.substring(
                 FileUploadPath.lastIndexOf('.') + 1).toLowerCase();
		//The file uploaded is an image
		if (Extension == "gif" || Extension == "png" || Extension == "bmp"|| Extension == "jpeg" || Extension == "jpg") {
		//To Display
				 $("#image"+i)[0].innerHTML=""
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



function upload_files(id){
	
	var rdBtnid=id.id
	//var Value = $("input[name='"+id.name+"']:checked").val();
    //var name = $("input[name='"+id.name+"']:checked").val();
	var i=rdBtnid[rdBtnid.length-1];
	//alert("i"+i);
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
	//var i=id[id.length-1];
	//var i=2
	//var pid=id
	//console.log(surveyTeamDetails[0].pid);
	//console.log(surveyTeamDetails[0].tower_photo1)
	var imageData= base64js.fromByteArray(surveyTeamDetails[0][id])
	
	
	
	//alert(imageData);
	var imageNum="Photo";
	  var htmlstring = "<img id='ItemPreview' 'src=data:image/jpeg;base64,"+imageData+"' width='104' height='142'>";
    //$("#ItemPreview").attr('src', 'data:image/jpeg;base64,' + base64);
       Swal.fire({
                title: "<i>"+imageNum+"</i>",
                html: "<center><table border='0'><tr><td><img id='ItemPreview' src='data:image/jpeg;base64,"+imageData+"' width='300' height='300'></td></tr></table><center>", 
                timer: 3000,
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
			
			
    
			<h3 class="text-center">PPE(PERSONAL PROTECTIVE EQUIPMENT)</h3>
				
			<form:form action="saveSurveyPPE" method="post" modelAttribute="SurveyTeamPPE"  enctype = 'multipart/form-data' id="ppeForm">
			<div class="login-form">
			<form:hidden path="id" id="ppeId"/>
				<label for=siteid class="placeholder"><b>Site Id</b></label>
					<form:input id="siteid" path="siteid.siteid"  name="siteid"  class="form-control input-full filled"  />
				 <br>
				<label for="ppe" class="placeholder"><b>All members of survey team wearing PPE(safety boots, high visibility vest, hard hat)</b></label>
<%-- 				<form:input id="ppe" path="ppe" class="form-control input-full filled" /> --%>
				<form:select id="ppe" path="ppe"  name="ppe"  class="form-control input-full filled" >
              	<form:option value="Yes">Yes</form:option>
              	<form:option value="No">No</form:option>              	
              	 </form:select>
				<br>
				
				  <div id="fileupload1">
				<label for="photoSurveyTeam" class="placeholder"><b>Photo of survey team</b></label>
				<input type="file"  class="form-control input-border-bottom" name="file" id="img0" onchange="ValidateImage(this.id)"/> 
				<span class="isa_failure" id="image0">${errMsg}</span>
				</div>
				
				
 				<div id="imagediv1">
 					
  						<label for="surveyPhoto1" class="placeholder"><b>Photo of survey team</b></label>
  						<div class="row mt-1" >
  						<div class="col-md-9">
  						<form:input type="text" id="imaget1" path="" class="form-control input-full"   readonly="true"  />
  						</div>	
  						<div class="col-md-3 " >
  						<form:input type="button" id="photoSurveyTeam" path="" value="View Image " onclick="ViewImage(this.id)"  class="form-control input-full  btn btn-info"   />	
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
				<label for="technicianName" class="placeholder"><b>Technician name/s</b></label> 
				<form:input id="technicianName" path="technicianName"  name="technicianName"  class="form-control input-full filled"  onkeypress="isCharacters(event)"/>
				<br>
               
				<label for="technicianWearing" class="placeholder"><b>Technician/s wearing PPE</b></label><br><br>
				<form:checkboxes items="${PPEList}" path="technicianWearing" id="technicianWearing"  element="p" name="technicianWearing"/><br>
<%--                <form:input id="technicianWearing" path="technicianWearing"  name="technicianWearing"  class="form-control input-full filled"  /> --%>
				
                <br>
                <div id="fileupload2">
                <label for="photoTechnicianTeam" class="placeholder"><b>Photo of technician/s</b></label>            
				<input type="file"  class="form-control input-border-bottom"  name="file"  id="img1" onchange="ValidateImage(this.id)"/> 
				<span class="isa_failure" id="image1">${errMsg}</span>
				</div>
				<div id="imagediv2">
 					
  						<label for="photo2" class="placeholder"><b>Photo of technician/s</b></label>
  						<div class="row mt-1" >
  						<div class="col-md-9">
  						<form:input type="text" id="imaget2" path="" class="form-control input-full"   readonly="true"  />
  						</div>	
  						<div class="col-md-3 " >
  						<form:input type="button" id="photoTechnicianTeam" path="" value="View Image " onclick="ViewImage(this.id)"  class="form-control input-full  btn btn-info"   />	
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
          
				<label for="rigger_Name" class="placeholder"><b>Rigger Name/s</b></label>
				<form:input id="rigger_Name" path="rigger_Name" class="form-control input-full filled" />
				<br>
				<label for="rigger_Wearing" class="placeholder"><b>Rigger/s wearing PPE</b></label><br><br>
<%-- 				<form:input id="rigger_Wearing" path="rigger_Wearing" class="form-control input-full filled" /> --%>
				<form:checkboxes items="${riggerPPEList}" path="rigger_Wearing" id="rigger_Wearing"  element="p" name="rigger_Wearing"/><br>
				<br>
				
				<div id="fileupload3">
				  
				<label for="photoRiggerTeam" class="placeholder"><b>Photo of Rigger/s</b></label>
				<input type="file"  class="form-control input-border-bottom"  name="file" id="img2" onchange="ValidateImage(this.id)"/> 
				<span class="isa_failure" id="image2">${errMsg}</span>
				</div>
				<div id="imagediv3">
 					
  						<label for=" photo3" class="placeholder"><b>Photo of Rigger/s</b></label>
  						<div class="row mt-1" >
  						<div class="col-md-9">
  						<form:input type="text" id="imaget3" path="" class="form-control input-full"   readonly="true"  />
  						</div>	
  						<div class="col-md-3 " >
  						<form:input type="button" id="photoRiggerTeam" path="" value="View Image " onclick="ViewImage(this.id)"  class="form-control input-full btn btn-info"   />	
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
				<div class="form-action">
					<input type="submit" id="clickBtn" value="Save" class="btn btn-rounded btn-login" name="clickBtn" style="background-color: #E4002B;color: white;">
					<input type="submit" id="clickBtn1" value="Save & Continue" class="btn btn-rounded btn-login" name="clickBtn" style="background-color: #012169;color: white;"> 
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


<!-- Sweet Alert -->
<script src="<c:url value='resources/assets/js/plugin/sweetalert/sweetalert.min.js' />"></script>
<!-- jQuery Sparkline -->

<script src="<c:url value='resources/assets/js/plugin/jquery.sparkline/jquery.sparkline.min.js' />"></script>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
</body>

</html>