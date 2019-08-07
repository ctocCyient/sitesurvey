<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head >
<script>
var userName;
var pasword;
var type;
$(document).ready(function() {	
	userName = '<%=session.getAttribute("userName")%>';
	password = '<%=session.getAttribute("password")%>';
	type = '<%=session.getAttribute("userRole")%>';
	
	//getRoles();
});

function getRoles()
{ 
	//alert("get roles:"+userName)
	 	
	 	$.ajax({
	         type:"get",
	         url:"getRoles",
	         contentType: 'application/json',
	         datatype : "json",
	         data:{"userName":userName},
	         success:function(data1) {
	         	jsonData = JSON.parse(data1);
	         	//alert(jsonData);
	         	
	         	populateRolesDropdown(jsonData,"role");
	         },
	         error:function()
	         {
	         	console.log("Error");
	         }
	 	});
	 }
	 
	 
function populateRolesDropdown(data,id)
{
	var	catOptions="";
 	for (i in data) {
			if(data[i]=='FeildExecutive')
			
 			data[i]="Field Technician";
   	 	 catOptions += "<option>" + data[i] + "</option>";
 		}
 		document.getElementById(id).innerHTML = catOptions;
 		
 		console.log('type'+type);
 		if(type=='FeildExecutive')
			{
				type="Field Technician";
			}
 		$("#role").val(type);
 		
}
function loadDashboard(value){
	
		 	var selectedRegion=value;
		 	
		 	if(value=='Field Technician')
			{
		 		value="FeildExecutive";
			}
		 	$("#role").val(value);
		 	
		 	$.ajax({
		         type:"get",
		         url:"validateSelectUser",
		         contentType: 'application/json',
		         datatype : "json",
		         data:{"role":value,"userName":userName,"password":password},
		         success:function(data1) {
		        	 if(data1=="success"){
		        	window.location.href="/RFIDAssetTracking/home";
		        	 }
		         },
		         error:function()
		         {
		         	console.log("Error");
		         }
		 	});
		 
}

</script>
<style>
.sample.form-control {
    font-size: 13px;
    border-color: #ebedf2;
    padding: .6rem 1rem;
    position: absolute;
    right: 66px;
    width: 150px;
    top: -18px;
}
.avatar-sm1 {
    width: 2.5rem;
    height: 2.5rem;
    position: absolute;
    top: -18px;
    right: 0px
}
</style>
	

</head>
<body>
	<!-- Navbar Header -->
			<nav class="navbar navbar-header navbar-expand-lg">
				
				<div class="container-fluid">
					
					<ul class="navbar-nav topbar-nav ml-md-auto align-items-center">
						
						<li class="nav-item dropdown hidden-caret">
<!-- 						<span> -->
<!-- 								<select style='font-size:12.5px;' id="role"  name="role" class="sample form-control input-border" onchange="loadDashboard(this.value);" ></select> -->
<!-- 								</span> -->
							<a class="dropdown-toggle profile-pic" data-toggle="dropdown" href="#" aria-expanded="false">
								<div class="avatar-sm1">								
									<img src="<c:url value='resources/assets/img/profile.jpg' />"  alt="..." class="avatar-img rounded-circle">
								</div>
							</a>
							<ul class="dropdown-menu dropdown-user animated fadeIn">
								<li>
									<div class="user-box">
										<div class="avatar-lg"><img src="<c:url value='resources/assets/img/profile2.jpg' />" alt="image profile" class="avatar-img rounded"></div>
										<div class="u-text">
										<br>
											<h4>${sessionScope.userName}</h4>
<!-- 											<p class="text-muted">Hello</p> -->
<!-- 												<a href="profile.html" class="btn btn-rounded btn-danger btn-sm">View Profile</a> -->
										</div>
									</div>
								</li>
								<li>
									<div class="dropdown-divider"></div>
									<a class="dropdown-item" href="logout">Logout</a>
								</li>
							</ul>
						</li>
						
					</ul>
				</div>
			</nav>
			<!-- End Navbar -->



<script src="<c:url value='resources/assets/js/core/jquery.3.2.1.min.js' />"></script>
<script src="<c:url value='resources/assets/js/core/popper.min.js' />"></script>
<script src="<c:url value='resources/assets/js/core/bootstrap.min.js' />"></script>

<!-- jQuery UI -->


<script src="<c:url value='resources/assets/js/plugin/jquery-ui-1.12.1.custom/jquery-ui.min.js' />"></script>
<script src="<c:url value='resources/assets/js/plugin/jquery-ui-touch-punch/jquery.ui.touch-punch.min.js' />"></script>


<!-- jQuery Scrollbar -->
<script src="<c:url value='resources/assets/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js' />"></script>

<!-- Moment JS -->
<script src="<c:url value='resources/assets/js/plugin/moment/moment.min.js' />"></script>

<!-- Chart JS -->

<script src="<c:url value='resources/assets/js/plugin/chart.js/chart.min.js' />"></script>

<!-- jQuery Sparkline -->

<script src="<c:url value='resources/assets/js/plugin/jquery.sparkline/jquery.sparkline.min.js' />"></script>


<!-- Chart Circle -->
<script src="<c:url value='resources/assets/js/plugin/chart-circle/circles.min.js' />"></script>


<!-- Datatables -->
<script src="<c:url value='resources/assets/js/plugin/datatables/datatables.min.js' />"></script>


<!-- Bootstrap Notify -->
<script src="<c:url value='resources/assets/js/plugin/bootstrap-notify/bootstrap-notify.min.js' />"></script>


<!-- Bootstrap Toggle -->
<script src="<c:url value='resources/assets/js/plugin/bootstrap-toggle/bootstrap-toggle.min.js' />"></script>



<!-- jQuery Vector Maps -->
<script src="<c:url value='resources/assets/js/plugin/jqvmap/jquery.vmap.min.js' />"></script>
<script src="<c:url value='resources/assets/js/plugin/jqvmap/maps/jquery.vmap.world.js' />"></script>


<!-- Google Maps Plugin -->
<script src="<c:url value='resources/assets/js/plugin/gmaps/gmaps.js' />"></script>

<!-- Sweet Alert -->

<script src="<c:url value='resources/assets/js/plugin/sweetalert/sweetalert.min.js' />"></script>

<!-- Azzara JS -->

<script src="<c:url value='resources/assets/js/ready.min.js' />"></script>
</body>
		</html>
