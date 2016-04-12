<?php
/**
 * @author Carl Lawrence Mariano
 * definition of a View - basic example
 */
class View {
	private $model;
	private $controller;
	
	public function __construct($controller, $model) {
		 $this -> controller = $controller;
 		 $this -> model = $model;
	}
	
	public function output() {
		$data = $this -> model -> str ;
		 return '<a href =" index.php?action=clicked">' . $data . '</a>';
		
	}
}
?>