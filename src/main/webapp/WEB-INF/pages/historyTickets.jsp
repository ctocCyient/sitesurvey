<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<<<<<<< HEAD
	<title>RFID</title>
	<meta content='width=device-width, initial-scale=1.0, shrink-to-fit=no' name='viewport' />
	
	<link rel="icon" href="<c:url value='resources/assets/img/icon.ico' />" type="image/x-icon"/>

	<!-- Fonts and icons -->
	<script src="<c:url value='resources/assets/js/plugin/webfont/webfont.min.js' />"></script>
	
		<script src="<c:url value='resources/js/jquery.min.js' />"></script>
	
	<script src="<c:url value='resources/js/jquery-ui.min.js' />"></script>
	<script src="<c:url value='resources/js/validations.js' />"></script>
	
	<link rel="stylesheet" href="<c:url value='resources/css/jquery-ui.css' />">
		
	<script>
		WebFont.load({
			google: {"families":["Open+Sans:300,400,600,700"]},
			custom: {"families":["Flaticon", "Font Awesome 5 Solid", "Font Awesome 5 Regular", "Font Awesome 5 Brands"], urls: ["<c:url value='resources/assets/css/fonts.css' />"]},
			active: function() {
				sessionStorage.fonts = true;
			}
		});
		$(document).ready(function() {
			
			 $("#navbar").load('<c:url value="/resources/common/header.jsp" />');  
			  $("#superAdminSidebar").load('<c:url value="/resources/common/superAdminSidebar.jsp" />');
			
			  //tableData();
			  //getCount();
			
			  	
			 
		
			  
		});
		var dataSet=[];
		 var ticketId,custId,ticketType;
		
		function tableData()
		{			
			$.ajax({
               type:"get",
               url:"getHistoryTickets",
               contentType: 'application/json',
               datatype : "json",
               success:function(data) {
                   historyTicketsList = JSON.parse(data);
					
                   for(var i=0;i<historyTicketsList.length;i++)
        		   {
					uid=historyTicketsList[i].uniqueId	
					 	var Unique= hex2a(uid);
                   	dataSet.push([historyTicketsList[i].ticketNum,historyTicketsList[i].customer.customerId,historyTicketsList[i].ticketType,Unique,historyTicketsList[i].executiveName]);
        			   
        		   }
                  
                   
			 var table1=$('#historyTickets').DataTable({
					destroy:true,
					language: {
					  emptyTable: "No Data Available"
					},	
					columnDefs: [{ "targets": -1, "data": null, "defaultContent": "<button style=' background-color: #4CAF50;border: none;  color: white;  padding: 5px 25px;  text-align: center;  text-decoration: none;  display: inline-block;  font-size: 16px;  margin: 4px 2px;  cursor: pointer;' id='viewBtn'>View</button>"}],					
			        data: dataSet,
			        columns: [
						{title: "Ticket Id" },
						{title: "Customer Id" },
						{title: "Ticket Type" },	
						{title: "Unique Id" },
						{title: "Technician Name" },						
						{title: "Action" }
			        ]
			    } );
			 
			 $('#historyTickets tbody').on('click', '[id*=viewBtn]', function () {
		            data1 =  table1.row($(this).parents('tr')).data();
		           
		           ticketId=data1[0];
		           custId=data1[1];
		           ticketType=null;
		           
		           console.log("Cust"+custId);
		           
		          // window.location.href = '/RFIDAssetTracking/viewTicketDetails';
					

					$.ajax({
		                type: "get",
		                url: "getDetails",
		                contentType: 'application/json',
		                data :{
		                	custId,ticketId
		                  },
		                datatype: "json",
		                success: function(result) {
		                    listData = JSON.parse(result);
		                   window.location.href = '/RFIDAssetTracking/viewTicketDetails?listDetails='+ window.encodeURIComponent(JSON.stringify(listData)); 
		                  

		                }
					
		       		 }); 
			 
             });
		}
			});
		}
		
		
function getCount(){
	
	$.ajax({
        type:"get",
        url:"ticketsCount",
        contentType: 'application/json',
        datatype : "json",
        success:function(result) {
        	var jsonArr = $.parseJSON(result);
        	$('#openTicketCount')[0].innerHTML=jsonArr[0];
            /* $('#closedTicketCount')[0].innerHTML=jsonArr[1];
            $('#historyTicketCount')[0].innerHTML=jsonArr[2]; */
            $('#assignedTicketCount')[0].innerHTML=jsonArr[1];
               //$('#unassignedTicketCount')[0].innerHTML=jsonArr[2];
               $('#historyTicketCount')[0].innerHTML=jsonArr[2];
               $('#totalTicketCount')[0].innerHTML=jsonArr[3];
            
        }
	});
}

	</script>
<style>
.fa-bars,
.fa-ellipsis-v
{
color: #fff!important;
}

.btn-border.btn-assign {
    color: #6610f2!important;
    border: 1px solid #6610f2!important;
    }
    
</style>
	<!-- CSS Files -->

	
	<link rel="stylesheet" href="<c:url value='resources/assets/css/bootstrap.min.css' />">
	<link rel="stylesheet" href="<c:url value='resources/assets/css/azzara.min.css' />">

	<!-- CSS Just for demo purpose, don't include it in your project -->
	<link rel="stylesheet" href="<c:url value='resources/assets/css/demo.css' />">
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
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

		<!-- Sidebar -->
<div id="superAdminSidebar">
</div>



		<div class="main-panel">
			<div class="content">
				<div class="page-inner">
					<div class="page-header">
						<h4 class="page-title">Dashboard</h4>						
					</div>
					
					
					<div class="row">
						<div class="col-sm-6 col-md-3">
							<div class="card card-stats card-round">
								<div class="card-body " onclick="location.href='/sitesurvey/openTickets'" style="cursor:pointer;">
									<div class="row align-items-center">
										<div class="col-icon">
											<div class="icon-big text-center bubble-shadow-small" style="background:#f3545d;border-radius: 5px">
											<img src="<c:url value='resources/assets/img/open.svg' />" >
											</div>
										</div>
										<div class="col col-stats ml-3 ml-sm-0">
											<div class="numbers">
												<p class="card-category" >Open</p>
												<h4 class="card-title" id="openTicketCount" ></h4>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-3">
							<div class="card card-stats card-round">
								<div class="card-body" onclick="location.href='/sitesurvey/assignedTickets'" style="cursor:pointer;">
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
								<div class="card-body" onclick="location.href='/sitesurvey/historyTickets'" style="background-color:#00B1BF;border-radius: 10px;cursor:pointer;">
									<div class="row align-items-center">
										<div class="col-icon">
											<div class="icon-big text-center bubble-shadow-small" style="background:#808080;border-radius: 5px;">
											<img src="<c:url value='resources/assets/img/history.svg' />" >
											</div>
										</div>
										<div class="col col-stats ml-3 ml-sm-0">
											<div class="numbers">
												<p class="card-category" style="color:#ffffff;" >History</p>
												<h4 class="card-title" style="color:#ffffff;" id="historyTicketCount" ></h4>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						
						<div class="col-sm-6 col-md-3">
							<div class="card card-stats card-round">
								<div class="card-body" onclick="location.href='/sitesurvey/totalTickets'" style="cursor:pointer;">
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
				
					

					<div class="row">
							<div class="col-md-12">
							<div class="card">
								<div class="card-header">
									<h4 class="card-title">Tickets</h4>
								</div>
								<div class="card-body">
									<div class="table-responsive">
										<table id="historyTickets" style="width:100%" class="display table table-striped table-hover" ></table>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
	</div>
=======
	<title>Site Survey</title>
	<meta content='width=device-width, initial-scale=1.0, shrink-to-fit=no' name='viewport' />
	
	<link rel="icon" href="<c:url value='resources/assets/img/icon.ico' />" type="image/x-icon"/>

	<!-- Fonts and icons -->
	<script src="<c:url value='resources/assets/js/plugin/webfont/webfont.min.js' />"></script>
	
		<script src="<c:url value='resources/js/jquery.min.js' />"></script>
	
			<script type="text/javascript">
	   if(sessionStorage.getItem("username")==null)
   	{
		   url = "/sitesurvey/";
		  $( location ).attr("href", url);
   	}	
	</script>	
		<script src="<c:url value='resources/js/jquery-ui.min.js' />"></script>
	
		<script src="<c:url value='resources/js/validations.js' />"></script>
	
	<link rel="stylesheet" href="<c:url value='resources/css/jquery-ui.css' />">
		
	<script>
		WebFont.load({
			google: {"families":["Open+Sans:300,400,600,700"]},
			custom: {"families":["Flaticon", "Font Awesome 5 Solid", "Font Awesome 5 Regular", "Font Awesome 5 Brands"], urls: ["<c:url value='resources/assets/css/fonts.css' />"]},
			active: function() {
				sessionStorage.fonts = true;
			}
		});
		$(document).ready(function() {

			if(sessionStorage.getItem("username")=="SuperAdmin")
			{
			window.location.href = "/sitesurvey/openTickets";
			}
		if(sessionStorage.getItem("username")=="Admin")
		{
		window.location.href = "/sitesurvey/adminOpenTickets";
		}	
		
			 $("#navbar").load('<c:url value="/resources/common/header.jsp" />');  
			 $("#superAdminSidebar").load('<c:url value="/resources/common/superAdminSidebar.jsp" />'); 
			  $("#adminSidebar").load('<c:url value="/resources/common/adminSidebar.jsp" />'); 
			  getCount();
			  tableData();
			  
		});
		var dataSet=[];
		 var ticketId,custId,ticketType;
		
		function tableData()
		{			
			$.ajax({
               type:"get",
               url:"getHistoryTickets",
               contentType: 'application/json',
               datatype : "json",
               success:function(data) {
                   historyTicketsList = JSON.parse(data);
					
                   for(var i=0;i<historyTicketsList.length;i++)
        		   {
					
                   	dataSet.push([historyTicketsList[i].ticketNum,historyTicketsList[i].siteid,historyTicketsList[i].technicianName]);

        			   
        		   }
                  
                   
			 var table1=$('#historyTickets').DataTable({
					destroy:true,
					language: {
					  emptyTable: "No Data Available"
					},											
			        data: dataSet,
			        columns: [
						{title: "Ticket Id" },
						{title: "Site Id" },
						{title: "Technician Name" }
			        ]
			    } );
			 
		}
			});
		}
		
		
function getCount(){
			
			$.ajax({
		        type:"get",
		        url:"ticketsCount",
		        contentType: 'application/json',
		        datatype : "json",
		        success:function(result) {
		        	var jsonArr = $.parseJSON(result);
		        	$('#openTicketCount')[0].innerHTML=jsonArr.OpenTickets;
		            $('#assignedTicketCount')[0].innerHTML=jsonArr.AssignedTickets;
	               $('#historyTicketCount')[0].innerHTML=jsonArr.HistoryTickets;
	               $('#totalTicketCount')[0].innerHTML=jsonArr.TotalTickets;
		            
		        }
			});
		}
	

	</script>
<style>
.fa-bars,
.fa-ellipsis-v
{
color: #fff!important;
}

.btn-border.btn-assign {
    color: #6610f2!important;
    border: 1px solid #6610f2!important;
    }
    
</style>
	<!-- CSS Files -->

	
	<link rel="stylesheet" href="<c:url value='resources/assets/css/bootstrap.min.css' />">
	<link rel="stylesheet" href="<c:url value='resources/assets/css/azzara.min.css' />">

	<!-- CSS Just for demo purpose, don't include it in your project -->
	<link rel="stylesheet" href="<c:url value='resources/assets/css/demo.css' />">
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
</head>
<body>
	    <script>
    if(sessionStorage.getItem("username")==null)
    	{
		//window.location.href = "/sitesurvey/";
		   url = "/sitesurvey/";
		      $( location ).attr("href", url);
    	}
    	else
		{
		s=sessionStorage.getItem("username");
		role=sessionStorage.getItem("role");
		}
    
  
    </script> 
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

		
		<script>
			if (role == "SuperAdmin") {
				document.write('<div id="superAdminSidebar"></div>');
			}
		</script>


<!-- Sidebar -->
		<script type="text/javascript">
			if (role == "Admin") {
		 document.write('<div id="adminSidebar"></div>');				
			}
		</script>
		<div class="main-panel">
			<div class="content">
				<div class="page-inner">
					<div class="page-header">
						<h4 class="page-title">Dashboard</h4>						
					</div>
					<div class="row">
						<div class="col-sm-6 col-md-3">
							<div class="card card-stats card-round">	
							<div class="card-body" onclick="location.href='${pageContext.request.contextPath}/openTickets'"	style=" cursor: pointer;">
									<div class="row align-items-center">
										<div class="col-icon">
											<div class="icon-big text-center bubble-shadow-small" style="background:#f3545d;border-radius: 5px">
											<img src="<c:url value='resources/assets/img/open.svg' />" >
											</div>
										</div>
										<div class="col col-stats ml-3 ml-sm-0">
											<div class="numbers">
												<p class="card-category" >Open</p>
												<h4 class="card-title" id="openTicketCount" ></h4>
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
								<div class="card-body" onclick="location.href='${pageContext.request.contextPath}/historyTickets'" style="background-color:#00B1BF;border-radius: 10px;cursor:pointer;">
									<div class="row align-items-center">
										<div class="col-icon">
											<div class="icon-big text-center bubble-shadow-small" style="background:#808080;border-radius: 5px;">
											<img src="<c:url value='resources/assets/img/history.svg' />" >
											</div>
										</div>
										<div class="col col-stats ml-3 ml-sm-0">
											<div class="numbers">
												<p class="card-category" style="color:#ffffff;" >History</p>
												<h4 class="card-title" style="color:#ffffff;" id="historyTicketCount" ></h4>
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
				
					

					<div class="row">
							<div class="col-md-12">
							<div class="card">
								<div class="card-header">
									<h4 class="card-title">Tickets</h4>
								</div>
								<div class="card-body">
									<div class="table-responsive">
										<table id="historyTickets" style="width:100%" class="display table table-striped table-hover" ></table>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		</div>
>>>>>>> branch 'master' of https://github.com/ctocCyient/sitesurvey

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