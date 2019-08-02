<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<title>RFID</title>
	<meta content='width=device-width, initial-scale=1.0, shrink-to-fit=no' name='viewport' />
	
		<script src="<c:url value='resources/js/jquery.min.js' />"></script>
	
	<script src="<c:url value='resources/js/jquery-ui.min.js' />"></script>
	<script src="<c:url value='resources/js/validations.js' />"></script>
	
	<link rel="stylesheet" href="<c:url value='resources/css/jquery-ui.css' />">
	
	<link rel="icon" href="<c:url value='resources/assets/img/icon.ico' />" type="image/x-icon"/>

	<!-- Fonts and icons -->
	<script src="<c:url value='resources/assets/js/plugin/webfont/webfont.min.js' />"></script>
		
<style type="text/css">

#openModal {
	text-align:center;
	margin:auto;
	width:50%;
	height:30%;
	opacity:.95;
	top:0;
	bottom:0;
	right:0;
	left:0;	
	position:absolute;
	background-color:#ffffff;
	overflow:auto
}

/* The Close Button */
.close {
  color: #aaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: black;
  text-decoration: none;
  cursor: pointer;
}

.btn-border.btn-assign {
    color: #6610f2!important;
    border: 1px solid #6610f2!important;
    }
   
.fa-bars,
.fa-ellipsis-v
{
color: #fff!important;
}
</style>

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
		$(document).ready(function() {


			  $("#navbar").load('<c:url value="/resources/common/header.jsp" />'); 
			  $("#sysAdminSidebar").load('<c:url value="/resources/common/systemAdminSidebar.jsp" />'); 
			  
			  tableData();
			  saveCount();
			  
			  $(".close").click(function () {
				 document.getElementById('openModal').style.display = "none";
              });
		
		});	
	
		var dataSet=[];
		 var ticketId;
		 var rowIndex,table1,rowToDelete;
		
		function tableData()
		{			
			$.ajax({
                type:"post",
                url:"getUnassignedOpenTickets",
                contentType: 'application/json',
                datatype : "json",
                success:function(data) {
                    openTicketsList = JSON.parse(data);
					
                    for(var i=0;i<openTicketsList.length;i++)
         		   {
                    	dataSet.push([openTicketsList[i].ticketNum,openTicketsList[i].customer.customerId,openTicketsList[i].status]);
         			   
         		   }
                   
                    
			  table1=$('#openTickets').DataTable({
					destroy:true,
					language: {
					  emptyTable: "No Data Available"
					},	
					columnDefs: [{ "targets": -1, "data": null, "defaultContent": "<button class='btn btn-assign btn-border' id='assignBtn' onclick='on()'>Assign</button>"}],					
			        data: dataSet,
			        columns: [
						{title: "Ticket Id" },
						{title: "Customer Id" },
						{title: "Issue" },
						{title: "Assigned To" }							
			        ]
			    } );
			 
			 
			 
			
			 $('#openTickets tbody').on('click', '[id*=assignBtn]', function () {
		            data1 =  table1.row($(this).parents('tr')).data();
		            rowIndex = $(this).parent().index();
					 rowToDelete= table1.row($(this).parents('tr'));
		            // alert(data1[0] );
		           ticketId=data1[0]
		           $.ajax({
		                type: "post",
		                url: "getUnassignedExecutives",
		                contentType: 'application/json',
		                datatype: "json",
		                success: function(result) {
		                    executivesList = JSON.parse(result);
		                   
		                    document.getElementById('openModal').style.display="";
		                	for(i=0;i<executivesList.length;i++){
		            			var newrow = $('<tr><td onclick=saveExecutives(this)>'+executivesList[i].executiveId+'</td></a><td> '+executivesList[i].executiveName+'</td> </tr>');
		            			
		            	         $('.executiveRow').after(newrow);
		            			}
		                    
		                }
					
		       		 });
			 
            

                });
			
				

		}
			});
		}
		
		
		function saveExecutives(value){
			
			$.ajax({
                type:"get",
                url:"assignExecutive",
                contentType: 'application/json',
                datatype : "json",     
                data: {"executiveId":value.innerHTML,"ticketId":ticketId},
                success:function(data) {
                  alert(data);
                  document.getElementById('openModal').style.display="none";
                  var OpenTicketCount=parseInt($('#openTicketCount')[0].innerHTML);
                // table1.row(':eq(0)').remove().draw();
				 rowToDelete.remove().draw();
				 $("#executiveTable").find("tr:gt(0)").remove();
                  $('#openTicketCount')[0].innerHTML=OpenTicketCount-1;
                }
     			
			});
		}
		
function saveCount(){
			
			$.ajax({
                type:"get",
                url:"ticketsCount",
                contentType: 'application/json',
                datatype : "json",
                success:function(result) {
                	var jsonArr = $.parseJSON(result);
                  $('#openTicketCount')[0].innerHTML=jsonArr[0];
                  $('#closedTicketCount')[0].innerHTML=jsonArr[1];
                  $('#historyTicketCount')[0].innerHTML=jsonArr[2];
                    
                }
			});
		}
		
	</script>


	<!-- CSS Files -->

	
	<link rel="stylesheet" href="<c:url value='resources/assets/css/bootstrap.min.css' />">
	<link rel="stylesheet" href="<c:url value='resources/assets/css/azzara.min.css' />">

	<!-- CSS Just for demo purpose, don't include it in your project -->
	<link rel="stylesheet" href="<c:url value='resources/assets/css/demo.css' />">
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
<style>
#overlay {
  position: fixed;
  display: none;
  width: 100%;
  height: 100%;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: rgba(0,0,0,0.5);
  z-index: 2;
  cursor: pointer;
}
</style>
<script>
function on() {
  document.getElementById("overlay").style.display = "block";
}

function off() {
  document.getElementById("overlay").style.display = "none";
}
</script>

</head>
<body>
	<div class="wrapper" >
		<!--
			Tip 1: You can change the background color of the main header using: data-background-color="blue | purple | light-blue | green | orange | red"
		-->
		
		<div id="overlay" ></div>
		
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
<div id="sysAdminSidebar">
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
							<div class="card card-stats card-round">
								<div class="card-body " onclick="location.href='/RFIDAssetTracking/openTickets'" style="background-color:#00B1BF;border-radius: 10px">
									<div class="row align-items-center">
										<div class="col-icon">
											<div class="icon-big text-center icon-success bubble-shadow-small">
											<img src="<c:url value='resources/assets/img/open.svg' />" >
											</div>
										</div>
										<div class="col col-stats ml-3 ml-sm-0">
											<div class="numbers">
												<p class="card-category" style="color:#ffffff;">Open</p>
												<h4 class="card-title" id="openTicketCount" style="color:#ffffff;"></h4>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-3">
							<div class="card card-stats card-round">
								<div class="card-body" onclick="location.href='/RFIDAssetTracking/closedTickets'">
									<div class="row align-items-center">
										<div class="col-icon">
											<div class="icon-big text-center bubble-shadow-small" style="background:#f3545d;border-radius: 5px">
											<img src="<c:url value='resources/assets/img/closed.svg' />" >
											</div>
										</div>
										<div class="col col-stats ml-3 ml-sm-0">
											<div class="numbers">
												<p class="card-category" >Closed</p>
												<h4 class="card-title" id="closedTicketCount" ></h4>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-3">
							<div class="card card-stats card-round">
								<div class="card-body" onclick="location.href='/RFIDAssetTracking/historyTickets'">
									<div class="row align-items-center">
										<div class="col-icon">
											<div class="icon-big text-center bubble-shadow-small" style="background:#808080;border-radius: 5px">
											<img src="<c:url value='resources/assets/img/history.svg' />" >
											</div>
										</div>
										<div class="col col-stats ml-3 ml-sm-0">
											<div class="numbers">
												<p class="card-category" >History</p>
												<h4 class="card-title" id="historyTicketCount" ></h4>
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
									<h4 class="card-title">Open Tickets</h4>
								</div>
								<div class="card-body">
									<div class="table-responsive">
										<table id="openTickets" class="display table table-striped table-hover" >
											
										</table>
									</div>
								</div>
							</div>
						</div>
	
	

			</div>
			<div id="openModal" align="center" style="display:none">
			<div onclick="off()"><span class="close" >&times;</span></div>
		<div class="card">
								<div class="card-header">
									<div class="card-title">Executives List</div>
								</div>
								<div class="card-body">
		
		
		<table id="executiveTable" class="table table-hover" border=0 style="width:100%;margin-top:10px;margin-bottom:10px;">  
			<tr class="executiveRow"><th scope="col">Executive Id</th><th scope="col">Executive Name</th></tr>		
		</table>
		
		
		
		<div id="executivesData"></div>
		
		</div>
		</div>
		</div>
		</div>
		
	</div>
	</div>
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