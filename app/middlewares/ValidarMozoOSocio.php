<?php

use Illuminate\Support\Arr;
use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Server\RequestHandlerInterface as RequestHandler;
use Slim\Psr7\Response;

class ValidarMozoOSocio
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
        $header = $request->getHeaderLine('Authorization');
        $r = new Response(); 

        if(isset(explode("Bearer", $header)[1])){
            
            $token = trim(explode("Bearer", $header)[1]);
            $esValido = false;        

            try {
                AutentificadorJWT::verificarToken($token);
                $esValido = true;
            } catch (Exception $e) {
                $payload = json_encode(array('error' => $e->getMessage() . ". Token INVALIDO."));                
            }
        
            if ($esValido) {
                $data = AutentificadorJWT::ObtenerData($token);

                if(strtolower($data->perfil) == "mozo" || strtolower($data->perfil) == "socio"){

                    $respuesta = $handler->handle($request); 
                    $existingContent = json_decode($respuesta->getBody()); 
                    $payload = json_encode($existingContent);
                    $r = $r->withStatus(200);
                }else{
                    $payload = json_encode(array("mensaje" => "ERROR. Solo 'mozo' o 'socio' puede operar."));
                    $r = $r->withStatus(400);
                }
            }
        }else{
            $payload = json_encode(array("mensaje" => "ERROR. Falta el token."));
            $r = $r->withStatus(400);
        }       
        
        $r->getBody()->write($payload);
        return $r
            ->withHeader('Content-Type', 'application/json');
    }
}