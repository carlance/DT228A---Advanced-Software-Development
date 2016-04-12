<?php
/**
 * @author Carl Lawrence Mariano
 * setting up relationships between M-V-C components - basic example
 */
include "Model.php";
include "Controller.php";
include "View.php";


$action = null;

if (! empty ( $_GET ['action'])) {
	
	$action = $_GET ['action'];
}

$model = new Model ();
$controller = new Controller ( $model, $action );
$view = new View ( $controller, $model );

echo $view->output ();


?>