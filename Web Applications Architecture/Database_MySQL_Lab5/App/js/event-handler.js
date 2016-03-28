var elFirstName = document.getElementById('firstname'); // Get username input
var elLastName = document.getElementById('lastname');
var elEmail = document.getElementById('email');
var elPassword = document.getElementById('password');
var elForm = document.getElementById('newuser');  
var elUsersMessage = document.getElementById('termsHint');
var warningMessage = document.getElementById('warning');



function checkUsername() {                            // Declare function
  var elMsg = document.getElementById('feedback');    // Get feedback element
  if (this.value.length < 5) {                        // If username too short
    elMsg.textContent = 'Username must be 5 characters or more';  // Set msg
  } else {                                            // Otherwise
    elMsg.textContent = '';                           // Clear message
  }
}

function checkPassword() {                            // Declare function
	  var elMsg = document.getElementById('feedback3');    // Get feedback element
	  if (this.value.length < 5) {                        // If username too short
	    elMsg.textContent = 'Password must be 5 characters or more';  // Set msg
	  } else {                                            // Otherwise
	    elMsg.textContent = '';                           // Clear message
	  }
	}


function newUserSuccessfulMessage(event) {                          // Declare function	 
		elUsersMessage.innerHTML = 'New User Added.'; // Show message
	    //event.preventDefault();                         // Don't direct to another page
		window.location.href="http://localhost/WAA/Database_MySQL_Lab5/App/index.php"; 
	}


function checkform(event) {
    // get all the inputs within the submitted form
    var inputs = event.getElementsByTagName('input');
    for (var i = 0; i < inputs.length; i++) {
        // only validate the inputs that have the required attribute
        if(inputs[i].hasAttribute("required")){
            if(inputs[i].value === ""){
                // found an empty field that is required
            	warningMessage.innerHTML = 'Please fill all required fields';
                return false;
            }
            
            else
            	return true;
        }
    }
    return true;
}


elFirstName.onblur;
elLastName.onblur ;
elEmail.onblur ;
//elUsername.onblur = checkUsername;  // When it loses focus call checkuserName()
elPassword.onblur = checkPassword ; //add event, call checkPassword function
elForm.addEventListener('submit', newUserSuccessfulMessage, false);//add event listener



