<?php
/** 
 * 
 * Class implemented to test emails, number ranges and string lengths
 * @author Luke
 *
 */
class Validation {
	/**
	 *
	 * Test whether the variable $email is a valid email string usign a regular expression
	 *
	 * @param
	 *        	email string
	 * @return true if $email matches the regular expression or false otherwise
	 */
	public function isEmailValid($email) {
		if (is_string ( $email )) {
			$pattern = "^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,3})$^";
			return preg_match ( $pattern, $email, $matches );
		}
		
		return false;
	}
	
	/**
	 *
	 * Test whether the variable $number is a valid number and is inside the range [$min, $max].
	 *
	 * @param
	 *        	an input number
	 * @param
	 *        	a number indicating the lowerbound of the range
	 * @param
	 *        	a number indicating the upperbound of the range
	 * @return true if $number is within [$min, $max] or false otherwise
	 */
	public function isNumberInRangeValid($number, $min, $max) {
		if (is_numeric ( $number ) && is_numeric ( $max ) && 
				is_numeric ( $min ) && ($min<=$max) && 
					($number >= $min) && ($number <= $max))
			return true;
		
		return false;
	}
	
	/**
	 *
	 * Test if the length of an input string is within a specified limit
	 *
	 * @param
	 *        	an input string
	 * @param
	 *        	the maximumg length of the input string allowed
	 * @return true if the input string's lenght is within the specified limit
	 */
	public function isLenghtStringValid($string, $number) {
		if (is_int ( $number ) && is_string ( $string ) && (strlen ( $string ) < $number))
			return true;
		return false;
	}
}

?>