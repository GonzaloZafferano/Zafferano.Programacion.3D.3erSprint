<?php

use Illuminate\Support\Arr;
use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Server\RequestHandlerInterface as RequestHandler;
use Slim\Psr7\Response;

class ValidarEstadosDeMesa
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
        $respuesta = "";
        $parametros = $request->getParsedBody();

        if(isset($parametros["estado"]) && !empty($parametros["estado"])){
            $estado = $parametros["estado"];

            if (strcasecmp($estado, "con cliente pagando") == 0 || 
            strcasecmp($estado, "con cliente comiendo") == 0 ||
            strcasecmp($estado, "con cliente esperando pedido") == 0){
                $respuesta = $handler->handle($request);       
                $respuesta = json_decode($respuesta->getBody());                      
                $respuesta = json_encode($respuesta);    
                $r = $r->withStatus(200);  
            }else{
                $respuesta = json_encode(array("mensaje" => "ERROR. Estado de mesa invalido. Estados posibles: 'con cliente pagando', 'con cliente comiendo', 'con cliente esperando pedido'."));
                $r = $r->withStatus(400);
            }   
        }else{
            $respuesta = json_encode(array("mensaje" => "ERROR. Falta indicar el estado de mesa."));
            $r = $r->withStatus(400);
        }       
        
        $r->getBody()->write($respuesta);
        return $r
            ->withHeader('Content-Type', 'application/json');
    }
}