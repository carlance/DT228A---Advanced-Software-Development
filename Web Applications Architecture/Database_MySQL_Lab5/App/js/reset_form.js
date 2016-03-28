/**
 * 
 */

function clearForm(oForm) {
    
  /**
   * In this function, we would first need to acquire a reference 
   * to all the elements in the form object:
   */
  var elements = oForm.elements; 
  
  oForm.reset();
  
  /**
   * We would then have to iterate over the individual 
   * form element objects of the frm_elements array (Step 1), using a for-loop construct:
   */
  for(i=0; i<elements.length; i++) {
      
	  
/**
 * We can find out the type of each form element in the frm_elements array by retrieving it’s type property:
 */	  
  field_type = elements[i].type.toLowerCase();
  
  switch(field_type) {
  
    case "name": 
    case "surname": 
    case "email":
    case "password":   
      
    	/**
    	 * If frm_elements[i] holds a reference to any of the <name>, <username>, <email> and <password> elements, 
    	 * it’s value can be cleared by simply setting it to an empty string:
    	 */
      elements[i].value = ""; 
      break;
       
      
     /**
      * Additional functionalities
      */
    case "radio":
    case "checkbox":
        if (elements[i].checked) {
          elements[i].checked = false; 
      }
      break;

    case "select-one":
    case "select-multi":
                elements[i].selectedIndex = -1;
      break;

    default: 
      break;
  }
    }
}