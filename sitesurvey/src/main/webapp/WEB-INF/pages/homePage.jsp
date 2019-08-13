<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
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
	
	</script>
	<script src="<c:url value='resources/js/jquery.min.js' />"></script>
	
	<script src="<c:url value='resources/js/jquery-ui.min.js' />"></script>
	<script src="<c:url value='resources/js/validations.js' />"></script>
	
	<link rel="stylesheet" href="<c:url value='resources/css/jquery-ui.css' />">	
	
	<link rel="icon" href="<c:url value='resources/assets/img/icon.ico' />" type="image/x-icon"/>
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css" />
<script type="javascript" src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script type="javascript" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>


	<!-- Fonts and icons -->
	<script src="<c:url value='resources/assets/js/plugin/webfont/webfont.min.js' />"></script>
	<script>
		WebFont.load({
			google: {"families":["Open+Sans:300,400,600,700"]},
			custom: {"families":["Flaticon", "Font Awesome 5 Solid", "Font Awesome 5 Regular", "Font Awesome 5 Brands"], urls: ["<c:url value='resources/assets/css/fonts.css' />"]},
			active: function() {
				sessionStorage.fonts = true;
			}
		});
	
	</script>
	<script>
	var name,role;
	$(function(){

		if(sessionStorage.getItem("username")==null)
			{
			window.location.href = "/sitesurvey/";
			}
		else
			{
			name=sessionStorage.getItem("username");
			   role=sessionStorage.getItem("role");
			}	
		  $("#navbar").load('<c:url value="/resources/common/header.jsp" />'); 
		  $("#superAdminSidebar").load('<c:url value="/resources/common/superAdminSidebar.jsp" />'); 
		  $("#adminSidebar").load('<c:url value="/resources/common/adminSidebar.jsp" />'); 
		  $("#managerSidebar").load('<c:url value="/resources/common/managerSidebar.jsp" />'); 
		  $("#technicianSidebar").load('<c:url value="/resources/common/technicianSidebar.jsp" />'); 

	  
		  if(role=="SuperAdmin"){
		  //	getAdminCount();
			document.getElementById("open_div").click();	
		  }
		  else if(role=="Admin"){
			 // getCount();
				document.getElementById("open_div_admin").click();	
	      }
		  else if(role=="Manager"){
			  	//getManagerCount();
				document.getElementById("manager_div").click();	
			}
			else if(role=="FieldTechnician"){
				 // getExecutiveTicketsCount();
					document.getElementById("tech_div").click();	
		    }
		   
	  });


	
	
	</script>
<style>
.fa-bars,
.fa-ellipsis-v
{
color: #fff!important;
}

.isa_success{
    color:#10F564;
}
</style>
	<!-- CSS Files -->
	<link rel="stylesheet" href="<c:url value='resources/assets/css/bootstrap.min.css' />">
	<link rel="stylesheet" href="<c:url value='resources/assets/css/azzara.min.css' />">

	</head>
<body>
	<div class="wrapper">
		<!--
			Tip 1: You can change the background color of the main header using: data-background-color="blue | purple | light-blue | green | orange | red"
		-->
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
			<div id="navbar">	
			</div>
			<!-- End Navbar -->
		</div>

		




<!-- Admin -->
		
    <script>
    if(sessionStorage.getItem("username")==null)
    	{
		//window.location.href = "/sitesurvey/";
		   url = "/sitesurvey/";
		      $( location ).attr("href", url);
    	}
    	else
		{
		name=sessionStorage.getItem("username");
		role=sessionStorage.getItem("role");
		}
    
    if(role=="SuperAdmin")
    	{
    	
        alert(sessionStorage.getItem("username"));

    </script>
    
    
    
    
    <!-- Sidebar -->
		<div id="superAdminSidebar">
		</div>
		<!-- End Sidebar -->
    

		<div class="main-panel">
			<div class="content">
				<div class="page-inner">
					<div class="page-header">
						<h4 class="page-title">Dashboard</h4>						
					</div>
					<div class="row">
						<div class="col-sm-6 col-md-3">
							<div class="card card-stats card-round" >
								<div class="card-body" id="open_div" onclick="location.href='${pageContext.request.contextPath}/openTickets'" style="background-color:#00B1BF;">
									<div class="row align-items-center" >
										<div class="col-icon" >
											<div class="icon-big text-center bubble-shadow-small" style="background:#f3545d;border-radius: 5px">
											<img src="<c:url value='resources/assets/img/open.svg' />" >
											</div>
										</div>
										<div class="col col-stats ml-3 ml-sm-0">
											<div class="numbers">
												<p class="card-category" style="color:#ffffff;">Open</p>
												<h4 class="card-title" id="assignSurveyCount" style="color:#ffffff;"></h4>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-3">
							<div class="card card-stats card-round">
								<div class="card-body" onclick="location.href='${pageContext.request.contextPath}/assignedTickets'" >
									<div class="row align-items-center">
										<div class="col-icon">
											<div class="icon-big text-center bubble-shadow-small" style="background:#F98B88;border-radius: 5px">
											<img src="<c:url value='resources/assets/img/closed.svg' />" >
											</div>
										</div>
										<div class="col col-stats ml-3 ml-sm-0">
											<div class="numbers">
												<p class="card-category" >Assigned</p>
												<h4 class="card-title" id="assignedTicketCount" ></h4>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-3">
							<div class="card card-stats card-round">
								<div class="card-body" onclick="location.href='${pageContext.request.contextPath}/historyTickets'">
									<div class="row align-items-center">
										<div class="col-icon">
											<div class="icon-big text-center bubble-shadow-small" style="background:#808080;border-radius: 5px">
											<img src="<c:url value='resources/assets/img/history.svg' />" >
											</div>
										</div>
										<div class="col col-stats ml-3 ml-sm-0">
											<div class="numbers">
												<p class="card-category">History</p>
												<h4 class="card-title" id="historyTicketCount"></h4>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-3">
							<div class="card card-stats card-round">
								<div class="card-body" onclick="location.href='${pageContext.request.contextPath}/totalTickets'" style="cursor:pointer;">
									<div class="row align-items-center">
										<div class="col-icon">
											<div class="icon-big text-center bubble-shadow-small" style="background:#af91e1;border-radius: 5px;">
											<img src="<c:url value='resources/assets/img/closed.svg' />" >
											</div>
										</div>
										<div class="col col-stats ml-3 ml-sm-0">
											<div class="numbers">
												<p class="card-category" >Total</p>
												<h4 class="card-title" id="totalTicketCount" ></h4>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						
					</div>
					
					
				</div>
			</div>
			
		</div>
		
		
		<script>
    	}
    </script>
		
		
    <script>
    if(sessionStorage.getItem("username")==null)
    	{
		window.location.href = "/sitesurvey/";
    	}
    	else
		{
		name=sessionStorage.getItem("username");
		role=sessionStorage.getItem("role");
		}
    
    if(role=="Admin")
    	   	
    </script> 
    <!-- Sidebar -->
		<div id="adminSidebar">
		</div>
		<!-- End Sidebar -->
    

		<div class="main-panel">
			<div class="content">
				<div class="page-inner">
					<div class="page-header">
						<h4 class="page-title">Dashboard</h4>						
					</div>
					<div class="row">
						<div class="col-sm-6 col-md-3">
							<div class="card card-stats card-round" >
								<div class="card-body" id="open_div_admin" onclick="location.href='${pageContext.request.contextPath}/adminOpenTickets'" style="background-color:#00B1BF;cursor:pointer;">
									<div class="row align-items-center" >
										<div class="col-icon" >
											<div class="icon-big text-center bubble-shadow-small" style="background:#f3545d;border-radius: 5px">
											<img src="<c:url value='resources/assets/img/open.svg' />" >
											</div>
										</div>
										<div class="col col-stats ml-3 ml-sm-0">
											<div class="numbers">
												<p class="card-category" style="color:#ffffff;">Open</p>
												<h4 class="card-title" id="assignSurveyCount" style="color:#ffffff;"></h4>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-3">
							<div class="card card-stats card-round">
								<div class="card-body" onclick="location.href='${pageContext.request.contextPath}/assignedTickets'" style="cursor:pointer;">
									<div class="row align-items-center">
										<div class="col-icon">
											<div class="icon-big text-center bubble-shadow-small" style="background:#F98B88;border-radius: 5px">
											<img src="<c:url value='resources/assets/img/closed.svg' />" >
											</div>
										</div>
										<div class="col col-stats ml-3 ml-sm-0">
											<div class="numbers">
												<p class="card-category" >Assigned</p>
												<h4 class="card-title" id="assignedTicketCount" ></h4>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-3">
							<div class="card card-stats card-round">
								<div class="card-body" onclick="location.href='${pageContext.request.contextPath}/historyTickets'" style="cursor:pointer;">
									<div class="row align-items-center">
										<div class="col-icon">
											<div class="icon-big text-center bubble-shadow-small" style="background:#808080;border-radius: 5px">
											<img src="<c:url value='resources/assets/img/history.svg' />" >
											</div>
										</div>
										<div class="col col-stats ml-3 ml-sm-0">
											<div class="numbers">
												<p class="card-category">History</p>
												<h4 class="card-title" id="historyTicketCount"></h4>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-3">
							<div class="card card-stats card-round">
								<div class="card-body" onclick="location.href='${pageContext.request.contextPath}/totalTickets'" style="cursor:pointer;">
									<div class="row align-items-center">
										<div class="col-icon">
											<div class="icon-big text-center bubble-shadow-small" style="background:#af91e1;border-radius: 5px;">
											<img src="<c:url value='resources/assets/img/closed.svg' />" >
											</div>
										</div>
										<div class="col col-stats ml-3 ml-sm-0">
											<div class="numbers">
												<p class="card-category" >Total</p>
												<h4 class="card-title" id="totalTicketCount" ></h4>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						
					</div>
					
					
				</div>
			</div>
			
		</div>
		
	
		<script>}</script>
		
		
		
		    <script>
    if(sessionStorage.getItem("username")==null)
    	{
		window.location.href = "/sitesurvey/";
    	}
    	else
		{
		name=sessionStorage.getItem("username");
		role=sessionStorage.getItem("role");
		}
    
    if(role=="Manager")
    	{
    	
    	
    </script>
		
    <!-- Sidebar -->
		<div id="managerSidebar">
		</div>
		<!-- End Sidebar -->
    

		<div class="main-panel">
			<div class="content">
				<div class="page-inner">
					<div class="page-header">
						<h4 class="page-title">Dashboard</h4>						
					</div>
					<div class="row">
						<div class="col-sm-6 col-md-3">
							<div class="card card-stats card-round" >
								<div class="card-body" id="manager_div" onclick="location.href='${pageContext.request.contextPath}/managerOpenTickets'" style="background-color:#00B1BF;cursor:pointer;">
									<div class="row align-items-center" >
										<div class="col-icon" >
											<div class="icon-big text-center bubble-shadow-small" style="background:#f3545d;border-radius: 5px">
											<img src="<c:url value='resources/assets/img/open.svg' />" >
											</div>
										</div>
										<div class="col col-stats ml-3 ml-sm-0">
											<div class="numbers">
												<p class="card-category" style="color:#ffffff;">Open</p>
												<h4 class="card-title" id="openCount" style="color:#ffffff;"></h4>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-3">
							<div class="card card-stats card-round">
								<div class="card-body" onclick="location.href='${pageContext.request.contextPath}/managerClosedTickets'" style="cursor:pointer;">
									<div class="row align-items-center">
										<div class="col-icon">
											<div class="icon-big text-center bubble-shadow-small" style="background:#808080;border-radius: 5px">
											<img src="<c:url value='resources/assets/img/closed.svg' />" >
											</div>
										</div>
										<div class="col col-stats ml-3 ml-sm-0">
											<div class="numbers">
												<p class="card-category">Closed</p>
												<h4 class="card-title" id="historyTicketCount"></h4>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						
					</div>
					
					
				</div>
			</div>
			
		</div>
		
	
		<script>}</script>
		
				    <script>
    if(sessionStorage.getItem("username")==null)
    	{
		window.location.href = "/sitesurvey/";
    	}
    	else
		{
		name=sessionStorage.getItem("username");
		role=sessionStorage.getItem("role");
		}
    
    if(role=="FieldTechnician")
    	{
    	
    	
    </script>
    <!-- Sidebar -->
		<div id="technicianSidebar">
		</div>
		<!-- End Sidebar -->
    

		<div class="main-panel">
			<div class="content">
				<div class="page-inner">
					<div class="page-header">
						<h4 class="page-title">Dashboard</h4>						
					</div>
					<div class="row">
						<div class="col-sm-6 col-md-3">
							<div class="card card-stats card-round" >
								<div class="card-body" id="tech_div" onclick="location.href='${pageContext.request.contextPath}/technicianAssignedTickets'" style="background-color:#00B1BF;cursor:pointer;">
									<div class="row align-items-center" >
										<div class="col-icon" >
											<div class="icon-big text-center bubble-shadow-small" style="background:#f3545d;border-radius: 5px">
											<img src="<c:url value='resources/assets/img/open.svg' />" >
											</div>
										</div>
										<div class="col col-stats ml-3 ml-sm-0">
											<div class="numbers">
												<p class="card-category" style="color:#ffffff;">Assigned</p>
												<h4 class="card-title" id="openTicketCount" style="color:#ffffff;"></h4>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-3">
							<div class="card card-stats card-round">
								<div class="card-body" onclick="location.href='${pageContext.request.contextPath}/technicianClosedTickets'" style="cursor:pointer;">
									<div class="row align-items-center">
										<div class="col-icon">
											<div class="icon-big text-center bubble-shadow-small" style="background:#808080;border-radius: 5px">
											<img src="<c:url value='resources/assets/img/closed.svg' />" >
											</div>
										</div>
										<div class="col col-stats ml-3 ml-sm-0">
											<div class="numbers">
												<p class="card-category">Closed</p>
												<h4 class="card-title" id="closedTicketCount"></h4>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						
					</div>
					
					
				</div>
			</div>
			
		</div>
		
		
		
		<script>}</script>
		
	</div>

<!--   Core JS Files   -->



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

<script src="<c:url value='resources/assets/js/setting-demo.js' />"></script>
<script src="<c:url value='resources/assets/js/demo.js' />"></script>

</body>
</html>