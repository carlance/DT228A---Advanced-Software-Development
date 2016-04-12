<?php
/**
 * @author Carl Lawrence Mariano
 * definition of a Controller - basic example
 */
 class Controller
 {
 private $model ;
 private $action;

 public function __construct ( $model,$action ) {
 $this -> model = $model ;
 $this -> action = $action;
 
 switch ( $action ){
 	 case "clicked": $this -> handleClick () ;
 		 break ;
 	 }
 
 }
 
 public function handleClick () {
 	 $this -> model -> updateData () ;
 	 }
 
 
 }
 ?>