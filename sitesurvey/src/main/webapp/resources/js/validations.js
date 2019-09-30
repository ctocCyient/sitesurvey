function validateEmailId(email,emailId,emailIdMsg) {
	  
	  if (validateEmail(email)) {
		  $("#"+emailIdMsg).css("display","none");
	  } 
	  else {
		  $("#"+emailIdMsg).css("display","block");
		  $('#'+emailId).val('');
  	} 
}
	 
function validateEmail(email) {
	  var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
	  return re.test(email);
	}
	
function isCharacters(e)
{
	/*var key = e.keyCode;
	if (key >= 48 && key <= 57) {
		e.preventDefault();
	}*/
	
	//Does'nt allow Special characters and numbers allows only Characters
	var k = e.keyCode || e.which;
	var ok = k >= 65 && k <= 90 || // A-Z
		k >= 96 && k <= 105 || // a-z
		k == 9 || //tab
		k == 8 ||		// backspaces
		(k > 64 && k < 91) ||
		(k > 96 && k < 123) ||
		 k == 8 ||
		 k == 32 ;
		
	if(!ok || (e.ctrlKey && e.altKey && e.shiftKey)){
			e.preventDefault();
		
	}
	
}
	
function isNumber(evt) {
	  evt = (evt) ? evt : window.event;
	  var charCode = (evt.which) ? evt.which : evt.keyCode;
	  if (charCode > 31 && (charCode < 48 || charCode > 57)) {
	    //alert("Please enter only Numbers.");
	    return false;
	  }
	  return true;
	}

	function ValidateNumber(id,mobileIdMsg) {
	  var phoneNo = document.getElementById(id);

	  if (phoneNo.value.length < 10 || phoneNo.value.length > 10) {
		  $("#"+mobileIdMsg).css("display","block");
	   // alert("Mobile Number is not valid, Please Enter 10 Digit Mobile Number");
	     $('#'+id).val('');
	  }
	  else
	  {
		  $("#"+mobileIdMsg).css("display","none");
	  }
	}
	
	
	function ValidatePinCode(id,pinIdMsg) {
		  var pincode = document.getElementById(id);

		  if (pincode.value.length < 6 || pincode.value.length > 6) {
			  $("#"+pinIdMsg).css("display","block");
		      $('#'+id).val('');
		  }
		  else
		  {
			  $("#"+pinIdMsg).css("display","none");
		  }

		}
	
	function GST_valid(id)
	{
	///   36AAACI4487J1Z9
	var panVal = $('#'+id).val();
	var regpan = /^([0]{1}[1-9]{1}|[1-2]{1}[0-9]{1}|[3]{1}[0-7]{1})([a-zA-Z]{5}[0-9]{4}[a-zA-Z]{1}[1-9a-zA-Z]{1}[zZ]{1}[0-9a-zA-Z]{1})+$/;
	if(regpan.test(panVal)){
	  
	} else {
	   alert("Invalid GST Number");
	   $('#'+id).val('');
	}
	}
	
	function validatePAN(id)
	{
		 var pan_no = document.getElementById(id).value;
		 var panPattern = /^([A-Z]{5})(\d{4})([A-Z]{1})$/.test(pan_no);

		 if(panPattern==false){
			 alert("Enter valid Pan no");	
			 $('#'+id).val('');
		 }
		
	}
	
	function ValidateFileUpload(id) {
		
        var fuData = document.getElementById(id);
        var FileUploadPath = fuData.value;

//To check if user upload any file
        if (FileUploadPath == '') {
            alert("Please upload an image");

        } else {
            var Extension = FileUploadPath.substring(
                    FileUploadPath.lastIndexOf('.') + 1).toLowerCase();

//The file uploaded is an image

if (Extension == "gif" || Extension == "png" || Extension == "bmp"
                    || Extension == "jpeg" || Extension == "jpg") {

// To Display
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
	swal("Invalid Image Format", {
		icon : "error",
		buttons: {        			
			confirm: {
				className : 'btn btn-danger'
			}
		},
	});
                document.getElementById(id).value="";
            }
        }
    }

	function Validate_latlong(text_box)
	{
	var text_value = document.getElementById(text_box.id).value;

	var reg = new RegExp("^-?([1-8]?[1-9]|[1-9]0)\.{1}\d{1,6}");

	if( reg.exec(text_value) ) {
	 //do nothing
	} else {
		swal("Invalid "+text_box.id+" Format", {
			icon : "error",
			buttons: {        			
				confirm: {
					className : 'btn btn-danger'
				}
			},
		});
	}


	}
 
