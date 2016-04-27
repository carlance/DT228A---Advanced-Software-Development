<?php
require_once "../Slim/Slim.php";
Slim\Slim::registerAutoloader ();

$app = new \Slim\Slim (); // slim run-time object

require_once "conf/config.inc.php";
function authenticate(\Slim\Route $route) {
	$app = \Slim\Slim::getInstance ();//gets instance of slim app 
	$parameters = null;
	$headers = $app->request->headers;
	$action = ACTION_AUTHENTICATE_USER;
	//TODO: READ username and password from headers
	
	
	//authenticate the user
	// TODO perform authentication
	//var_dump($headers);
	$object =  new loadRunMVCComponents ( "UserModel", "UserController", "View", $action, $app, $parameters );
	
	
		
		echo "Hello There";
		
		return (true);
	
	
	//$app->halt($object->model->apiResponse );
}

// Create Resource
$app->get ( "/search/:user", function ($search = null) use ($app) {
	
	$httpMethod = $app->request->getMethod ();
	$action = null;
	$parameters ["SearchingString"] = $search;
	
	$action = ACTION_SEARCH_USERS;
	
	return new loadRunMVCComponents ( "UserModel", "UserController", "View", $action, $app, $parameters );
} );

// Create Resource
$app->map ( "/users(/:id)","authenticate", function ($userID = null) use ($app) {
	
	$httpMethod = $app->request->getMethod ();
	$action = null;
	$parameters ["id"] = $userID; // prepare parameters to be passed to the controller (example: ID)
	
	if (($userID == null) or is_numeric ( $userID )) {
		switch ($httpMethod) {
			case "GET" :
				if ($userID != null)
					$action = ACTION_GET_USER;
				else
					$action = ACTION_GET_USERS;
				break;
			case "POST" :
				$action = ACTION_CREATE_USER;
				break;
			case "PUT" :
				$action = ACTION_UPDATE_USER;
				break;
			case "DELETE" :
				$action = ACTION_DELETE_USER;
				break;
			default :
		}
	}
	return new loadRunMVCComponents ( "UserModel", "UserController", "View", $action, $app, $parameters );
} )->via ( "GET", "POST", "PUT", "DELETE" );

$app->run ();
class loadRunMVCComponents {
	public $model, $controller, $view;
	public function __construct($modelName, $controllerName, $viewName, $action, $app, $parameters = null) {
		include_once "models/" . $modelName . ".php";
		include_once "controllers/" . $controllerName . ".php";
		include_once "views/" . $viewName . ".php";
		
		$this->model = new $modelName (); // common model
		$this->controller = new $controllerName ( $this->model, $action, $app, $parameters );
		$this->view = new $viewName ( $this->controller, $this->model, $app, $app->headers ); // common view
		$this->view->output (); // this returns the response to the requesting client
	}
}

?>