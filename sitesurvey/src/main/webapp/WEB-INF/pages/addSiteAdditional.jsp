<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String jsondetails=(String)request.getParameter("ticketDetails"); 
   System.out.println("json>>>>>>>"+jsondetails);%>
<% String status=(String)request.getAttribute("status"); %>

<% String btnClick=(String)request.getAttribute("btnClick"); 
  System.out.println("btnclck>>>>>>>"+btnClick);%>
<!DOCTYPE html >
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
	$('#selectedTicketId')[0].value=ticketId;
	var status='<%=status%>';

	var btnClick='<%=btnClick%>';
	//alert(status);
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


	 if(status=='Saved')

     {
                         
              swal.fire({
                         //title: 'Are you sure?',
                         text: "Details Saved and Ticket Closed Succesfully",
                         type: 'info',
                         buttons:{
                                confirm: {
                                       text : 'Ok',
                                       className : 'btn btn-success'
                                }
                         }
                  }).then((Delete) => {
                         if (Delete) {
                                window.location.href = "/sitesurvey/home";
                         }
                  });
            }
	
	
	$("select option[value='Select']").attr('disabled','disabled');
	//$("#additionalNotes : input").attr("required",'');
	 $("#additionalNotes :input").attr("required", '');
	 
	 $("#navbar").load('<c:url value="/resources/common/header.jsp" />'); 
	 $("#technicianSidebar").load('<c:url value="/resources/common/technicianSidebar.jsp" />'); 
	 jsonDetails='<%=jsondetails%>';
	//alert(jsonDetails)
	var ticketDetails=JSON.parse(JSON.stringify(jsonDetails));
	//alert(ticketDetails);
	//$("#siteid")[0].value=ticketDetails.split(",")[1];
	//alert(ticketDetails.split(",")[1]);
	  $("#json")[0].value=ticketDetails;
	  var siteId="IND005";
		$("#siteid")[0].value=siteId;
		  $("#json")[0].value=ticketDetails;
		  //alert(siteId);
		  getSiteAdditionalDetails(siteId);
		  
		  
		  
		  /* $("#imageb1").click(function(){
			  alert("The paragraph was clicked.");
			  $("#imageId").show();
			}) */
		 
	
});
var base64_1;
var jsonData1;
function getSiteAdditionalDetails(siteId){
	
	 $.ajax({
         type: "get",
         url: "getSiteAdditionalDetails",
         contentType: 'application/json',
         data:{"siteId":siteId},
         datatype: "json",
         success: function(result) {
        	 jsonData1=JSON.parse(result);
            jsonData = JSON.parse(result);
            console.log("jsonDa"+jsonData);
            if(jsonData.length==0)
            {
            	$("#siteimage1").hide();
            	$("#imagediv1").show();
            	$("#imagediv2").show();
            	$("#imaged1").hide();
            	$("#imaged2").hide();
            }
            else
            {
            	$("#imaged1").show();
            	$("#imaged2").show();
            	$("#imagediv1").hide();
            	$("#imagediv2").hide();
            	//$("#site_photo1").hide();
            	//$("#site_photo2").hide();
            //	$("#siteimage1").show();
            	$("#siteaddid").val(jsonData[0].id);
            	$("#observations").val(jsonData[0].observations);
            	$("#imaget1").val(jsonData[0].site_photo1_name);
            	$("#imaget2").val(jsonData[0].site_photo2_name);
            	base64_1 = base64js.fromByteArray(jsonData[0].site_photo1);
            	//alert(base64_1)
            	 //$("#imageId").attr("src", 'data:image/jpg;base64,'+base64_2);
            	//alert("pic"+jsonData[0].site_photo1_name);
            	//$("#securitycondition").val(jsonData[0].securityCondition);
            	//$("#site_photo1").attr('disabled','disabled');
            	//$("#site_photo2").attr('disabled','disabled');
            	$('#site_photo1').removeAttr('required');
            	$('#site_photo2').removeAttr('required');
            	$("#additionalNotes :input").removeAttr('required');
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
		$("#imaged"+i).hide();
		$("#imagediv"+i).show();
		//$("#site_photo1").attr('disabled',false);
    	//$("#site_photo2").attr('disabled',false);
	}else if(id.value=="No"){
		$("#imaged"+i).show();
		$("#imagediv"+i).hide();
		//$("#site_photo1").attr('disabled',true);
    	//$("#site_photo2").attr('disabled',true);
	}
	
	
	
}
 
function ViewImage(id){
	
	//alert(jsonData1)
	var i=id[id.length-1];
	//var i=2
	var pid="site_photo"+i
	console.log(jsonData[0].pid);
	console.log(jsonData[0].site_photo2)
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


function ValidateImage(id){
		//alert(typeof(id));
			var i=id[id.length-1]
			//alert(i)
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
             alert("Photo only allows file types of GIF, PNG, JPG, JPEG and BMP. ");
             $("#image"+i)[0].innerHTML=" Uploaded file Must be Image format"; 
             document.getElementById(id).value="";
             //$(".isa_failure")[0].innerHTML="";
          }
      }
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
<%-- 	   <div align="center"><span class="isa_success" style="color:#35B234;font-size:20px">${status}</span></div>	<br><br> --%>
				<h3 class="text-center">Additional Details</h3>
				<span id="msg" style="color:red;font-size:12px;">*All Fields are Mandatory*</span><br><br>
				<form:form method="post" id="additionalNotes" modelAttribute="Site_Additional_Notes" action="additionalNotes" enctype="multipart/form-data" onsubmit="return ValiidateForm()">
				<form:input type="hidden" path="id" id="siteaddid" />
				<input type="hidden"   id="json" name="json" />
				
						<label for="siteid" class="placeholder"><b>Site ID</b></label>						 
						<form:input type="text" id="siteid" path="siteid.siteid" class="form-control input-full"  readonly="true" />				
						<form:errors path="siteid.siteid" cssClass="error" />	
					<br>
								
				
						<label for="observations" class="observations"><b>Observations</b></label>
						<form:input  id="observations" path="observations" class="form-control input-full"   />				
						<form:errors path="observations" cssClass="error" />	
					<br>
						
				
				<div id="imagediv1"> 
				<label for="site_photo1" class="placeholder" >Site Photo 1</label>
				<input type="file" class="form-control input-border-bottom"  id="site_photo1"  name="file"  onchange="ValidateImage(this.id)"/> 
				
					<span class="isa_failure" id="image1">${errMsg}</span>
						
  				</div>
  				
  				<div  id="imaged1">
  				<label for="Site photo1" class="placeholder" ><b>Site Photo 1</b></label>
  				<div class="row mt-1" >
  					<div class="col-md-9">
  						
  						<form:input type="text" id="imaget1" path="" class="form-control input-full"   readonly="true"  />
  					</div>	
  					<div class="col-md-3 " >
  						<form:input type="button" id="imageb1" path="" value="View Image " onclick="ViewImage(this.id)"  class="form-control input-full btn btn-info"   />	
  						<!-- <img id="imageId" src="" style="display:none" />-->
  				
  					</div>
  					
  				</div>
  				</div>
  				<div class="row mt-1">   
  				 <div class="col-md-7">
                  <label for="Radio_1" class="placeholder" ><b>Do you want to upload Image</b></label><br>
                  </div>
                  <div class="col-md-3">Yes<input type="radio"  value="Yes" id="rdyes1" name="rdbtn1" onclick="upload_files(this)" />
                  </div>
                  <div class="col-md-2">No<input type="radio" onclick="upload_files(this)" id="rdno1"  value="No"  name="rdbtn1" checked/>
                 </div>
                  </div>
                      
  				<br>
  				
				<div id="imagediv2">
				<label for="site_photo2" class="placeholder" ><b>Site Photo 2</b></label>
				<input type="file" class="form-control input-border-bottom"  id="site_photo2"  name="file"  onchange="ValidateImage(this.id)"/> 
				
					<span class="isa_failure" id="image2">${errMsg}</span>
  				</div>
  				<div id="imaged2">
  				<label for="Site photo2" class="placeholder" ><b>Site Photo 2</b></label>
  				<div class="row mt-1" >
  					<div class="col-md-9">
  						
  						<form:input type="text" id="imaget2" path="" class="form-control input-full"   readonly="true"  />
  					</div>	
  					<div class="col-md-3 " >
  						<form:input type="button" id="imageb2" path="" value="View Image " onclick="ViewImage(this.id,this)"  class="form-control input-full btn btn-info"   />	
  						<!-- <img id="imageId" src="" style="display:none" />-->
  				
  					</div>
  					
  				</div>
  				</div>
  				<div class="row mt-1">   
  				 <div class="col-md-7">
                  <label for="Radio_1" class="placeholder" ><b>Do you want to upload Image</b></label><br>
                  </div>
                  <div class="col-md-3">Yes<input type="radio"  value="Yes" id="rdyes2" name="rdbtn2" onclick="upload_files(this)" />
                  </div>
                  <div class="col-md-2">No<input type="radio" onclick="upload_files(this)" id="rdno2" value="No"  name="rdbtn2"  checked/>
                 </div>
                  </div>
  				
  				
  				
  				
 						<div class="form-action" id="new_submit" >
 						
 						<input type="submit"  class="btn btn-rounded btn-login" value="Finish Survey" name="btn" style="background-color: #012169;color: white;">  
					
 						 <input id="selectedTicketId" name="selectedTicketId" value="" type="hidden">
 						 
<!-- 				 		<input type="submit"  class="btn btn-rounded btn-login" value="Save" name="btn" style="background-color: #012169;color: white;">   -->
					
<!--  						<input type="submit"  value="Save" class="btn btn-primary btn-rounded btn-login">  -->
 				
 				
<!-- 				 		<input type="submit" class="btn btn-rounded btn-login" value="Save & Continue" name="btn" style="background-color: #012169;color: white;">   -->
					
<!--  							<input type="submit"  value="Save" class="btn btn-primary btn-rounded btn-login">  -->
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