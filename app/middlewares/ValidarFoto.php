<?php

use Illuminate\Support\Arr;
use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Server\RequestHandlerInterface as RequestHandler;
use Slim\Psr7\Response;

class ValidarFoto
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
         $parametros = $request->getParsedBody();
         $uploadedFiles = $request->getUploadedFiles();

        if($request->getMethod() === 'POST'){

            if(isset($uploadedFiles['fotoUrl'])){

                if(!empty($uploadedFiles['fotoUrl']->getFilePath())){   
                    $respuesta = $handler->handle($request);     
                    $respuesta = json_decode($respuesta->getBody());                    
                    $respuesta = json_encode($respuesta);    
                    $r = $r->withStatus(200);                      
                }else{
                    $respuesta = json_encode(array("mensaje" => "ERROR. Hay parametros vacios."));
                    $r = $r->withStatus(400);
                }
            }else{
                $respuesta = json_encode(array("mensaje" => "ERROR. Faltan parametros."));
                $r = $r->withStatus(400);
            }
        }
        $r->getBody()->write($respuesta);

        return $r->withHeader('Content-Type', 'application/json');
    }
}