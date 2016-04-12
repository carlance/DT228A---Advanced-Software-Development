<?php
/**
 * @author Carl Lawrence Mariano
 * definition of a Model - basic example
 */
class Model {
	public $str;
	
	public function __construct() {
		$this->str = " Hello world! Click Here!";
	}
	
	public function updateData(){
		$this ->str = "Hello World! Click Here updated";
	}
}
?>
