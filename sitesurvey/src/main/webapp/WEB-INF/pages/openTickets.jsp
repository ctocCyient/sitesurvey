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

/* #openModal { */
/* 	text-align:center; */
/* 	margin:auto; */
/* 	width:50%; */
/* 	height:30%; */
/* 	opacity:.95; */
/* 	top:0; */
/* 	bottom:0; */
/* 	right:0; */
/* 	left:0;	 */
/* 	position:absolute; */
/* 	background-color:#ffffff; */
/* 	overflow:auto */
/* } */

/* The Modal (background) */
.modal2 {
	display: none; /* Hidden by default */
	position: absolute; /* Stay in place */
	z-index: 1; /* Sit on top */
	padding-top: 100px; /* Location of the box */
	padding-left:25px;
	padding-right:30px;
	left: 0;
	top: 0;
	width: 100%; /* Full width */
	height: 100%; /* Full height */
	overflow: auto; /* Enable scroll if needed */
	background-color: rgb(0, 0, 0); /* Fallback color */
	background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
}

/* Modal Content */
.modal-content {
	background-color: #fefefe;
	margin: auto;
	position: relative;
	padding: 20px;
	border: 1px solid #888;
	height: 80%; /* Full height */
}

#loading {
   width: 100%;
   height: 100%;
   top: 0;
   left: 0;
   position: fixed;
   display: block;
   opacity: 0.7;
   background-color: #fff;
   z-index: 99;
   text-align: center;
}

#loading-image {
  position: absolute;
  top: 50%;
    left: 50%;
  z-index: 100;
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
			  
			  $(".closeBtn").click(function () {
				  $("#executiveTable").find("tr:gt(0)").remove();
				 document.getElementById('openModal').style.display = "none";
              });
		
		});	
	
		var dataSet=[];
		 var ticketId;
		  var region,city;
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
                    	dataSet.push([openTicketsList[i].ticketNum,openTicketsList[i].customer.customerId,openTicketsList[i].ticketType,openTicketsList[i].status,openTicketsList[i].region,openTicketsList[i].city]);
         			   
         		   }
                   
                    
			  table1=$('#openTickets').DataTable({
					destroy:true,
					language: {
					  emptyTable: "No Data Available"
					},		
					columnDefs: [    
// 						{
// 		                "targets": [ 3 ],
// 		                "visible": false
// 		            },
// 		            {
// 		                "targets": [ 4 ],
// 		                "visible": false
// 		            },
			
	
					{ "targets": -1, "data": null, "defaultContent": "<button style=' background-color: #4CAF50;border: none;  color: white;  padding: 5px 25px;  text-align: center;  text-decoration: none;  display: inline-block;  font-size: 16px;  margin: 4px 2px;  cursor: pointer;'  id='assignBtn' onclick='on()'>Assign</button>"}],					
			        data: dataSet,
			        columns: [
						{title: "Ticket Id" },
						{title: "Customer Id" },
						{title: "Ticket type"},
						{title: "Status" },
						{title: "Region"},
						{title: "City"},
						{title: "Action" }							
			        ]
			    } );
			  
			 $('#openTickets tbody').on('click', '[id*=assignBtn]', function () {
		            data1 =  table1.row($(this).parents('tr')).data();
		            rowIndex = $(this).parent().index();
					 rowToDelete= table1.row($(this).parents('tr'));
		            // alert(data1[0] );
		           ticketId=data1[0];
		           region=data1[4];
		           city=data1[5];
		           $.ajax({
		                type: "get",
		                url: "getUnassignedExecutives",
		                contentType: 'application/json',
		                datatype: "json", 
						    data:{"region":region,"city":city},
		                success: function(result) {
		                    executivesList = JSON.parse(result);
							 if(executivesList==""){
		                    	
		                    	var newrow = $('<tr><label>No Technicians Available<label></tr>');
		            			
		            	         $('.executiveRow').after(newrow);
		                    }else{
		                   
		                    //document.getElementById('openModal').style.display="";
		                	for(i=0;i<executivesList.length;i++){
		            			var newrow = $('<tr><td><a href="#" onclick=saveExecutives(this)>'+executivesList[i].executiveId+'</a></td><td>'+executivesList[i].executiveName+'</td> <td>'+executivesList[i].region+'</td> <td>'+executivesList[i].city+'</td> </tr>');
		            			
		            	         $('.executiveRow').after(newrow);
		            			}
						}
		                }
					
		       		 });
			 
                });
		}
			});
		}
		
		
		function saveExecutives(value){
			var techId=value.innerHTML;
			 $('#loading').show();
			$.ajax({
                type:"get",
                url:"assignExecutive",
                contentType: 'application/json',
                datatype : "json",     
                data: {"executiveId":techId,"ticketId":ticketId},
                success:function(data) {
                	 $('#loading').hide();
                	
					var content = document.createElement('div');
					    content.innerHTML = 'Ticket <strong>'+ticketId+'</strong> assigned to technician <strong>'+techId+'</strong>';
		                 swal(content, {
	                	buttons: {        			
	    					confirm: {
	    						className : 'btn btn-success'
	    					}
	    				},
					});
  					
  				
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
                  //$('#closedTicketCount')[0].innerHTML=jsonArr[1];
                  $('#historyTicketCount')[0].innerHTML=jsonArr[1];
                  $('#totalTicketCount')[0].innerHTML=jsonArr[2];
                    
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
	
	//$("#sysAdminSidebar").hide();
	document.getElementById("openModal").style.display = "block";
	//}

	// When the user clicks on <span> (x), close the modal
	document.getElementsByClassName("close")[0].onclick = function() {
		 $("#executiveTable").find("tr:gt(0)").remove();
		document.getElementById("openModal").style.display = "none";
	}

}

// function off() {
// 	//document.getElementById("overlay").style.display = "none";
// 	 $("#executiveTable").find("tr:gt(0)").remove();
// }
</script>

</head>
<body>
	<div class="wrapper"  >
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
<div id="sysAdminSidebar">
</div>
		<!-- End Sidebar -->

		<div class="main-panel" >
			<div class="content">
				<div class="page-inner" >
				<div id="loading" style="display:none">
				  <img id="loading-image" src="<c:url value='resources/assets/img/ajax-loader.gif' />" alt="Loading..."  />
				</div>
					<div class="page-header">
					
						<h4 class="page-title">Dashboard</h4>						
					</div>
					
					<div class="row" >
						<div class="col-sm-6 col-md-3">
							<div class="card card-stats card-round">
								<div class="card-body " onclick="location.href='/RFIDAssetTracking/openTickets'" style="background-color:#00B1BF;border-radius: 10px;cursor:pointer;">
									<div class="row align-items-center">
										<div class="col-icon">
											<div class="icon-big text-center bubble-shadow-small" style="background:#f3545d;border-radius: 5px">
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
								<div class="card-body" onclick="location.href='/RFIDAssetTracking/historyTickets'" style="cursor:pointer;">
									<div class="row align-items-center">
										<div class="col-icon">
											<div class="icon-big text-center bubble-shadow-small" style="background:#808080;border-radius: 5px;">
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
						<div class="col-sm-6 col-md-3">
							<div class="card card-stats card-round">
								<div class="card-body" onclick="location.href='/RFIDAssetTracking/totalTickets'" style="cursor:pointer;">
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
										<table id="openTickets" style="width:100%" class="display table table-striped table-hover" >
											
										</table>
									</div>
								</div>
							</div>
						</div>
	
	

			</div>
			
			<!-- popup -->
<!-- 			<div id="openModal" align="center" style="display:none"> -->
<!-- 			<div onclick="off()"><span class="close">&times;</span></div> -->
<!-- 		<div class="card"> -->
<!-- 								<div class="card-header"> -->
<!-- 									<div class="card-title">Field Technicians List</div> -->
<!-- 								</div> -->
<!-- 								<div class="card-body"> -->
		
		
<!-- 		<table id="executiveTable" class="table table-hover" border=1 style="width:100%;margin-top:10px;margin-bottom:10px;">   -->
<!-- 			<tr class="executiveRow"><th scope="col">Technician Id</th><th scope="col">Technician Name</th></tr>		 -->
<!-- 		</table> -->
<!-- 		<div id="executivesData"></div> -->
		
<!-- 		</div> -->
<!-- 		</div> -->
<!-- 		</div> -->

<!-- popup -->
					<div id="openModal" class="modal2" align="center">
						<div class="modal-content">
							<div>
								<span class="close">&times;</span>
							</div>
							<div>
								<div>
									<div><h1>Field Technicians List</h1></div>
								</div>
								<br>
								<div>


									<table id="executiveTable" class="table table-hover" border=1
										style="width: 80%; margin-top: 10px; margin-bottom: 10px;">
										<tr class="executiveRow">
											<th scope="col">Technician Id</th>
											<th scope="col">Technician Name</th>
											<th scope="col">Region</th>
											<th scope="col">City</th>
										</tr>
									</table>



									<!-- <div id="executivesData"></div>-->

								</div>
							</div>
							<div id="loading-image" style="display: none;">
							<img src="<c:url value='resources/assets/img/ajax-loader.gif'  />" alt="navbar brand" class="navbar-brand">
							</div>
							

          <button type="button"  class="closeBtn" style=' background-color: #00B1BF;border: none;  color: white;  padding: 5px 25px;  text-align: center;  text-decoration: none;  display: inline-block;  font-size: 16px;  margin: 4px 2px;  cursor: pointer; width:80px;'>Close</button>
        
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