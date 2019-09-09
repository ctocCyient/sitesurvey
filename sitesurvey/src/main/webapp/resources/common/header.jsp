<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>

<script>
var userName;
var pasword;
var type;
var currentip;
$(document).ready(function() {	

	userName = sessionStorage.getItem("username");
	password = sessionStorage.getItem("password");
	type = sessionStorage.getItem("role");
	//alert(userName);
	getRoles();
	 function getUserIP(onNewIP) { //  onNewIp - your listener function for new IPs
		    //compatibility for firefox and chrome
		    var myPeerConnection = window.RTCPeerConnection || window.mozRTCPeerConnection || window.webkitRTCPeerConnection;
		    var pc = new myPeerConnection({
		        iceServers: []
		    }),
		    noop = function() {},
		    localIPs = {},
		    ipRegex = /([0-9]{1,3}(\.[0-9]{1,3}){3}|[a-f0-9]{1,4}(:[a-f0-9]{1,4}){7})/g,
		    key;

		    function iterateIP(ip) {
		        if (!localIPs[ip]) onNewIP(ip);
		        localIPs[ip] = true;
		    }

		     //create a bogus data channel
		    pc.createDataChannel("");

		    // create offer and set local description
		    pc.createOffer().then(function(sdp) {
		        sdp.sdp.split('\n').forEach(function(line) {
		            if (line.indexOf('candidate') < 0) return;
		            line.match(ipRegex).forEach(iterateIP);
		        });

		        pc.setLocalDescription(sdp, noop, noop);
		    }).catch(function(reason) {
		        // An error occurred, so handle the failure to connect
		    });

		    //listen for candidate events
		    pc.onicecandidate = function(ice) {
		        if (!ice || !ice.candidate || !ice.candidate.candidate || !ice.candidate.candidate.match(ipRegex)) return;
		        ice.candidate.candidate.match(ipRegex).forEach(iterateIP);
		    };
		}

		// Usage
		getUserIP(function(ip){
		   //alert("Got IP! :" + ip);
		   currentip=ip;
		    
		    
		});
});


function trackUsers()
{
	//var currentip=ip;
 var uname=name;
 var today = new Date();
 var date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
 var time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
 var dateTime = date+' '+time;
 //alert(dateTime);
 //alert("user"+uname);
 //alert("IP"+currentip);
 $.ajax({
      type:"get",
      url:"saveLoginInfo",
      contentType: 'application/json',
      datatype : "json",
      data:{"UserName":userName,"Time":dateTime,"CurrentIP":currentip,"Type":"Login"},
      success:function(data1) {
      	
      	window.location.href = "/sitesurvey/home";
      },
      error:function()
      {
      	console.log("Error");
      }
	});
}


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
 	
 		$("#role").val(type);
 		
}
var usersList=[];
function loadDashboard(value){
	
		 	var selectedRole=value;
		 	
		 	$.ajax({
		         type:"get",
		         url:"validateUserAjax",
		         contentType: 'application/json',
		         datatype : "json",
		         data:{"role":value,"username":userName,"password":password},
		         success:function(data1) {
			        	
			        	if(data1!="failure")
			        	{
			        		usersList = JSON.parse(data1);
			        		console.log("USer"+usersList);
			        		sessionStorage.setItem("username", userName);
			        		sessionStorage.setItem("password",password);
			        		sessionStorage.setItem("role",selectedRole);	 
			        		sessionStorage.setItem("region",usersList[0].region);	 
			        		sessionStorage.setItem("city",usersList[0].city);	 
			        		trackUsers();
			        	}
			        	else if(data1=="failure")
			        	{
			        		alert("Failed to login");	
			        		sessionStorage.clear();
			        	}
			        },
			        error:function()
			        {
			        	console.log("Error");
			        }
		 	});
		 
}

function trackUsersLogout()
	{
		//var currentip=ip;
    var uname=name;
    var today = new Date();
    var date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
    var time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
    var dateTime = date+' '+time;
    //alert(dateTime);
    
    $.ajax({
         type:"get",
         url:"saveLoginInfo",
         contentType: 'application/json',
         datatype : "json",
         data:{"UserName":uname,"Time":dateTime,"CurrentIP":currentip,"Type":"Logout"},
         success:function(data1) {
         	
         	window.location.href = "/sitesurvey/";
         },
         error:function()
         {
         	console.log("Error");
         }
 	});
	}
	
	
	
	
function session_out(){
	trackUsersLogout();
	sessionStorage.clear();
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
						<span>
								<select style='font-size:12.5px;' id="role"  name="role" class="sample form-control input-border" onchange="loadDashboard(this.value);" ></select>
								</span>
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
										<h4 id="demo"></h4>
											

											<script>
											document.getElementById("demo").innerHTML = sessionStorage.getItem("username");
											
											</script>
<!-- 											<p class="text-muted">Hello</p> -->
<!-- 												<a href="profile.html" class="btn btn-rounded btn-danger btn-sm">View Profile</a> -->
										</div>
									</div>
								</li>
								<li>
									<div class="dropdown-divider"></div>
									<a class="dropdown-item" href="logout" onclick="session_out()">Logout</a>
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
