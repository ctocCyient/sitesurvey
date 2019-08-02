<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String details=(String)request.getParameter("listDetails"); %>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<title>RFID</title>
	<meta content='width=device-width, initial-scale=1.0, shrink-to-fit=no' name='viewport' />
	
	<link rel="icon" href="<c:url value='resources/assets/img/icon.ico' />" type="image/x-icon"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<script type="javascript" src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script type="javascript" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/1.5.6/css/buttons.dataTables.min.css">

<style>
.backBtn
{
position:fixed;
    right: 36px;
    top: 84px;
}
</style>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">

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
	var details=<%=details%>;
	console.log(details);
	var designDataset=[],invDataset=[],custDataset=[];
	 var ticketId;
	 var designDetails,invDetails,custDetails;
	$(function(){
		  $("#navbar").load('<c:url value="/resources/common/header.jsp" />'); 
		  $("#systemAdminSidebar").load('<c:url value="/resources/common/systemAdminSidebar.jsp" />'); 
		  
			
			
			 designDetails=details[0];
			 invDetails=details[1];
			 custDetails=details[2];
			 
			 console.log("designDetails"+designDetails);
			 console.log("invDetails"+invDetails);
			 console.log("custDetails"+custDetails);
			 
		  tableData();
		});
	

	
	function tableData()
	{			
		
               for(var i=0;i<designDetails.length;i++)
    		   {
            	   designDataset.push([designDetails[i].tagId,designDetails[i].exchangeName,designDetails[i].shelfName,designDetails[i].startPoint,designDetails[i].endPoint,designDetails[i].length,designDetails[i].address,designDetails[i].floor,designDetails[i].suite,designDetails[i].vertIn]);
    			   
    		   }
               
               for(var i=0;i<invDetails.length;i++)
    		   {
            	   invDataset.push([invDetails[i].equipmentId,invDetails[i].exchangeName,invDetails[i].shelfName,invDetails[i].length,invDetails[i].inventoryStatusCode,invDetails[i].ownershipTypeCode,invDetails[i].siteName,invDetails[i].installedDate,invDetails[i].operationalState]);
    			   
    		   }
               
               for(var i=0;i<custDetails.length;i++)
    		   {
            	   custDataset.push([custDetails[i].customerId,custDetails[i].customerName,custDetails[i].address,custDetails[i].city,custDetails[i].customerStatus,custDetails[i].fax,custDetails[i].partial,custDetails[i].phoneNum,custDetails[i].postalCode,custDetails[i].surname,custDetails[i].userId]);
    			   
    		   }
              
               
		 var table1=$('#designTable').DataTable({
				destroy:true,
				language: {
				  emptyTable: "No Data Available"
				},	
				dom: 'Bfrtip',
		        buttons: [
		            'copy', 'csv', 'excel', 'pdf', 'print'
		        ],
		        data: designDataset,
		        columns: [
					{title: "Tag Id" },
					{title: "Exchange Name" },
					{title: "Shelf Name" },	
					{title: "Start Point" },
					{title: "End Point" },
					{title: "Length" },	
					
					{title: "Address" },
					{title: "Floor" },
					{title: "Suite" },
					{title: "Vert In" }
		        ]
		    } );
		 
		 var table2=$('#invTable').DataTable({
				destroy:true,
				language: {
				  emptyTable: "No Data Available"
				},								
		        data: invDataset,
		        columns: [
		        	{title: "Equipment Id" },
					{title: "Exchange Name" },
					{title: "Shelf Name" },	
					{title: "Length" },
					{title: "Inventory Status Code" },
					{title: "Ownership Type Code" },	
					
					{title: "Site Name" },
					{title: "Installed Date" },
					{title: "Operational State" }	
		        ]
		    } );
		 
		 var table3=$('#custTable').DataTable({
				destroy:true,
				language: {
				  emptyTable: "No Data Available"
				},								
		        data: custDataset,
		        columns: [
		        	{title: "Customer Id" },
		        	{title: "Customer Name" },
					{title: "Address" },
					{title: "City" },	
					{title: "Customer Status" },
					{title: "Fax" },
					{title: "Partial" },	
					
					{title: "Phone Number" },
					{title: "Postal Code" },
					{title: "Surname" }	,
					{title: "USer Id" }	
		        ]
		    } );
			

	}
		
	
	
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

		
<div id="systemAdminSidebar">
</div>
    

		<div class="main-panel">
			<div class="content">
				<div class="page-inner">
					<div class="page-header">
						<h4 class="page-title">Details</h4>	
						<span style="float:right;font-size:24px" onclick="javascript:history.back()" class="hover6"><i class="fas fa-arrow-circle-left backBtn"></i></span>					
					</div>
					
					<div class="row">
					<div class="col-md-6">
					<div class="card">
								<div class="card-header">
									<h4 class="card-title">New</h4>
								</div>
								</div>
								</div>
								<div class="col-md-6">
					<div class="card">
								<div class="card-header">
									<h4 class="card-title">Old</h4>
								</div>
								</div>
								</div>
						<div class="col-md-4">
							<div class="card">
								<div class="card-header">
									<h4 class="card-title">Inventory Details</h4>
								</div>
								<div class="card-body">
									
									<form method="post" id="inventoryForm" >
			<div class="login-form">			
				<div class="form-group ">
					<label for="equiment_id" class="placeholder">Equipment Id</label>
					<input id="equiment_id" class="form-control input-border-bottom"  />
					
					
				</div>
				
					<div class="form-group ">
					<label for="exchange_name" class="placeholder">Exchange Name</label>
					<input id="exchange_name"  class="form-control input-border-bottom"   />
						
					</div>
				
				
            	
					<div class="form-group ">
						<label for="shelf Name" class="placeholder">Shelf Name</label>
						<input id="shelf_name" class="form-control input-border-bottom"   />				
					</div>
				
				
				<div class="form-group ">
					<label for="Length" class="placeholder">Length</label>
					<input id="length" class="form-control input-border-bottom"  />
												
				</div>
				
					<div class="form-group">
						<label for="Inventory Status Code" class="placeholder">Inventory Status Code</label>
						<input id="inv_status_code" class="form-control input-border-bottom"  />
					</div>	
				
				
					<div class="form-group ">
						<label for="OwnerShip Type Code" class="placeholder">OwnerShip Type Code</label>
						<input id="owner_type_code" class="form-control input-border-bottom" />									
					</div>
				
				
				<div class="form-group ">
					<label for="Site Name" class="placeholder">Site Name</label>
					<input id="site_name" class="form-control input-border-bottom"   />
										
				</div>
				<div class="form-group ">
				<label for="Installed Date" class="placeholder">Installed Date</label>
				<input id="installed_date" type="date" value="" class="form-control input-border-bottom"  />
									
				</div>
				
				<div class="form-group ">
					<label for="Operational State" class="placeholder">Operational State</label>
					<input id="operational_state" class="form-control input-border-bottom"  />								
				</div>	
				
				
				
				<div class="form-action" id="typeDiv" style="display:none">	
					<a href="home" id="" class="btn  btn-rounded btn-login mr-3" style="background-color: #E4002B;color: white;">Cancel</a>				
					<input type="button" onclick="saveInventoryData()" id="inventoryBtn" value="Update" class="btn  btn-rounded btn-login"  style="background-color: #012169;color: white;">
				</div>
				<div class="form-action" id="statusDiv" style="display:none">			
					<input type="button" onclick="window.history.back();" value="Prev" class="btn btn-rounded btn-login mr-3" style="background-color: #E4002B;color: white;">								
					<input type="button" onclick="saveInventoryData()" id="inventoryBtn" value="Next" class="btn btn-rounded btn-login"  style="background-color: #012169;color: white;">
				</div>
			</div>
			</form>			
									
								</div>
							</div>
						</div>
						<div class="col-md-4">
							<div class="card">
								<div class="card-header">
									<h4 class="card-title">Design Details</h4>
								</div>
								<div class="card-body">
									<form method="post" id="designForm" >
       
	           <div class="login-form">
		
				<label for="tagId" class="placeholder" >Tag ID</label>	
                <input id="tagId" name="tagId" class="form-control input-border-bottom" />
            	
            	
	            	<label for="exchanges" class="placeholder">Exchange Name</label>
	            	<input id="exchanges"  name="exchanges" class="form-control input-border-bottom"  />
            	
            	
            	
            	
	            	<label for="shelfName" class="placeholder">Shelf Name</label>
	                <input id="shelfName"  name="shelfName" class="form-control input-border-bottom" />
              
             
            	
            	<label for="startPoint" class="placeholder">Start Point</label>
            	<input id="startPoint" name="startPoint" class="form-control input-border-bottom" onkeypress="return startSpecialChar(event)" maxlength="2" onfocus="$('#startMsg').css('display','none')" />
            	
            	
           		<label for="endPoint" class="placeholder" >End Point</label>	
                <input id="endPoint"  name="endPoint" class="form-control input-border-bottom" onkeypress="return endSpecialChar(event)" maxlength="2" onfocus="$('#endMsg').css('display','none')" />
            	
            	<label for="length" class="placeholder">Length</label>
            	<input id="length" name="length" class="form-control input-border-bottom"  />
            	
            	
            	<label for="address" class="placeholder">Address</label>
                <input id="address" name="address" class="form-control input-border-bottom" />
                
            	
            	<label for="floors" class="placeholder">Floor</label>
            	<input id="floors" name="floors" class="form-control input-border-bottom" />
            	
            	
            	
	            	<label for="suites" class="placeholder">Suite</label>
	            	<input id="suites" name="suites" class="form-control input-border-bottom"  />
            	
            	
            	
            	<label for="vertIn" class="placeholder">Vert_In</label>
                <input id="vertIn" name="vertIn" class="form-control input-border-bottom" onkeypress="return blockSpecialChar(event)" onfocus="$('#vertMsg').css('display','none')"/>
                     <span id="vertMsg" style="color:red;display:none;font-size:15px">Allows only AlphaNumeric</span>   
                                              
               
	           </div>
       
        </form>
									
								</div>
							</div>
						</div>
						<div class="col-md-4">
							<div class="card">
								<div class="card-header">
									<h4 class="card-title">Customer Details</h4>
								</div>
								<div class="card-body">
									<form method="post" id="custmerForm" >
				<div class="customerdetails-form">
					<div class="form-group ">
						<label for="address" class="placeholder">Address</label>
						<input id="address" name="address"	class="form-control input-border-bottom" /> 
					</div>

					<div class="form-group ">

						 <label for="city" class="placeholder">City</label><input id="city" name="city" class="form-control input-border-bottom" />
					</div>

					<div class="form-group ">

						 <label for="c_id"
							class="placeholder">Customer ID</label>
							<input id="c_id" name="c_id"
							class="form-control input-border-bottom" onkeypress="return (event.charCode >= 49 && 
	event.charCode <= 57) || (event.charCode ==67)" maxlength="2" onfocus="$('#uniqueIdMsg').css('display','none')" />
							<span id="uniqueIdMsg" style="color:red;display:none;font-size:15px">Allows only C1 to C9</span> 
					</div>

					<div class="form-group ">

						 <label for="c_name"
							class="placeholder">Customer Name</label>
							<input id="c_name" name="c_name"
							class="form-control input-border-bottom" />
					</div>

					<div class="form-group ">

						 <label
							for="c_status" class="placeholder">Customer Status</label>
							<input id="c_status" name="c_status"
							class="form-control input-border-bottom" />
					</div>
					<div class="form-group ">
						 <label for="fax"
							class="placeholder">Fax</label>
							<input id="fax" name="fax"
							class="form-control input-border-bottom" />
					</div>
					<div class="form-group ">
						 <label for="partial"
							class="placeholder">Partial</label>
							<input id="partial" name="partial"
							class="form-control input-border-bottom" />
					</div>
					<div class="form-group ">
						 <label for="phn_no"
							class="placeholder">Phone Number</label>
							<input id="phn_no" name="phn_no"
							class="form-control input-border-bottom"  onblur="validateAusMobileNo(this.value);"/>
					</div>
					<div class="form-group ">
						 <label
							for="postal_code" class="placeholder">Postal Code</label>
							<input id="postal_code" name="postal_code"
							class="form-control input-border-bottom" />
					</div>
					<div class="form-group ">
						 <label for="surname"
							class="placeholder">Surname</label>
							<input id="surname" name="surname"
							class="form-control input-border-bottom" />
					</div>
					<div class="form-group ">
						<label for="userid"
							class="placeholder">User ID</label>
							<input id="userid" name="userid"
							class="form-control input-border-bottom" /> 
					</div>
					<div class="form-action mb-3" id="newBtnDiv" style="display:none">
						<a href="home" id="" class="btn btn-rounded btn-login mr-3" style="background-color: #E4002B;color: white;">Cancel</a>
						<input type="button" onclick="saveNewData()" class="btn btn-rounded btn-login" value="Confirm" style="background-color: #012169;color: white;">
					</div>
					<div class="form-action mb-3" id="existingBtnDiv" style="display:none">
						<a href="home" id="" class="btn btn-danger btn-rounded btn-login mr-3" style="background-color: #E4002B;color: white;">Cancel</a>
						<input type="button" onclick="saveExistingData()" class="btn  btn-rounded btn-login" value="Update" style="background-color: #012169;color: white;">
					</div>
					<div class="form-action" id="statusDiv" style="display:none">	
                		<input type="button" onclick="window.history.back();" value="Prev" class="btn btn-rounded btn-login mr-3" style="background-color: #E4002B;color: white;">				
						<a href="home" class="btn btn-rounded btn-login" style="background-color: #012169;color: white;">Ok</a>
					</div>

				</div>
			</form>
									
								</div>
							</div>
						</div>
						
																	</div>
					
					
					
					
<!-- 					<div class="col-md-12"> -->
<!-- 							<div class="card"> -->
								
								
<!-- 								<div class="card-header"> -->
<!-- 									<h4 class="card-title">Inventory</h4> -->
<!-- 								</div> -->
<!-- 								<div class="card-body"> -->
<!-- 									<div class="table-responsive"> -->
<!-- 										<table id="invTable" class="table table-striped table-hover" > -->
											
<!-- 										</table> -->
<!-- 									</div> -->
<!-- 								</div> -->
								
<!-- 								<div class="card-header"> -->
<!-- 									<h4 class="card-title">Design</h4> -->
<!-- 								</div> -->
<!-- 								<div class="card-body"> -->
<!-- 									<div class="table-responsive"> -->
<!-- 										<table id="designTable" class="table table-striped table-hover" > -->
											
<!-- 										</table> -->
<!-- 									</div> -->
<!-- 								</div> -->
								
<!-- 								<div class="card-header"> -->
<!-- 									<h4 class="card-title">Customer</h4> -->
<!-- 								</div> -->
<!-- 								<div class="card-body"> -->
<!-- 									<div class="table-responsive"> -->
<!-- 										<table id="custTable" class="table table-striped table-hover" > -->
											
<!-- 										</table> -->
<!-- 									</div> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</div> -->
					
					
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