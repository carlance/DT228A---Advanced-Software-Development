<?php
class View {
	private $model, $controller, $slimApp;
	public function __construct($controller, $model, $slimApp) {
		$this->controller = $controller;
		$this->model = $model;
		$this->slimApp = $slimApp;
	}
	public function output() {
		
		// Request content type from header
		$contentType = $this->slimApp->request->getMediaType ();
		// $contentType = $this->slimApp->request->headers->get ('Content-Type');
		// var_dump ($contentType);
		
		// var_dump($data = $this->model->apiResponse);
		
		switch ($contentType) {
			
			case "application/xml" :
				// prepare xml response
				// sets content format for response
				$this->slimApp->response->header ( 'Content-Type', 'application/xml' );
				
				$xml = new SimpleXMLElement ( '<users/>' );
				$data = $this->model->apiResponse;
				
				foreach ( $data as $value ) {
					
					$item = $xml->addChild ( 'user' );
					$item->addChild ( 'id', $value ['id'] );
					$item->addChild ( 'name', $value ['name'] );
					$item->addChild ( 'surname', $value ['surname'] );
					$item->addChild ( 'email', $value ['email'] );
					$item->addChild ( 'password', $value ['password'] );
				}
				
				$this->slimApp->response->write ( $xml->asXML () );
				break; // Break here prevents the next case from firing
			
			case "application/json" :
				// prepare json response
				// sets content format for response
				$this->slimApp->response->header ( 'Content-Type', 'application/json' );
				$jsonResponse = json_encode ( $this->model->apiResponse );
				$this->slimApp->response->write ( $jsonResponse );
			
			default :
		}
	}
}
?>