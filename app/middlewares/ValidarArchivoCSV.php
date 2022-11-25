<?php

use Illuminate\Support\Arr;
use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Server\RequestHandlerInterface as RequestHandler;
use Slim\Psr7\Response;

class ValidarArchivoCSV
{
    /**
     * Example middleware invokable class
     *
     * @param  ServerRequest  $request PSR-7 request
     * @param  RequestHandler $handler PSR-15 request handler
     *
     * @return Response
     */
    
    public function __invoke(Request $request, RequestHandler $handler): Response
    {    
        $r = new Response();
        $uploadedFiles = $request->getUploadedFiles(); 



       if(isset($uploadedFiles['archivo'])){        
            if(!empty($uploadedFiles['archivo']->getFilePath())){
                $nombreArchivo = $uploadedFiles['archivo']->getClientFilename();

                if(strtolower(pathinfo($nombreArchivo)["extension"]) == "csv"){
                    $respuesta = $handler->handle($request); 
                    $existingContent = json_decode($respuesta->getBody()); 
                    $payload = json_encode($existingContent);
                    $r = $r->withStatus(200);
                }else{
                    $payload = json_encode(array("mensaje" => "ERROR. El archivo es invalido. Debe utilizarse un archivo 'csv'."));
                    $r = $r->withStatus(400);
                }
            }else{
                $payload = json_encode(array("mensaje" => "ERROR. Falta cargar el archivo 'csv'."));
                $r = $r->withStatus(400);
            }
       }else{
            $payload = json_encode(array("mensaje" => "ERROR. Faltan parametros."));
            $r = $r->withStatus(400);
       }

          





        
        
        $r->getBody()->write($payload);
        return $r
            ->withHeader('Content-Type', 'application/json');
    }
}