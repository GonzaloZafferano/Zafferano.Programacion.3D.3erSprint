<?php

use Illuminate\Support\Arr;
use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Server\RequestHandlerInterface as RequestHandler;
use Slim\Psr7\Response;

require_once './controllers/UsuarioController.php';


class ValidarCamposUsuario
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

        if($request->getMethod() === 'POST'){
            if(isset($parametros['nombre']) && isset($parametros['perfil']) &&
            isset($parametros['clave']) && isset($parametros['fechaIngreso'])){

              if(!empty($parametros['nombre']) && !empty($parametros['perfil']) &&
                  !empty($parametros['clave']) && !empty($parametros['fechaIngreso'])){

                  $perfil = $parametros["perfil"];

                  if(!UsuarioController::ExisteNombreDeUsuario($parametros["nombre"])){
                      if(strcasecmp($perfil, "socio") == 0){
                            if(UsuarioController::cantidadDeSocios() < 3){
                                $respuesta = $handler->handle($request);       
                                $respuesta = json_decode($respuesta->getBody());                      
                                $respuesta = json_encode($respuesta);    
                                $r = $r->withStatus(200);   
                            }else{
                                $respuesta = json_encode(array("mensaje" => "ERROR. Solo pueden existir 3 socios."));
                                $r = $r->withStatus(400);
                            }
                        } else if (strcasecmp($perfil,"mozo") == 0 ||
                                strcasecmp($perfil,"cervecero") == 0 ||
                                strcasecmp($perfil,"bartender") == 0 ||
                                strcasecmp($perfil,"cocinero") == 0){
                            $respuesta = $handler->handle($request);       
                            $respuesta = json_decode($respuesta->getBody());                      
                            $respuesta = json_encode($respuesta);    
                            $r = $r->withStatus(200);                        
                        }else{
                            $respuesta = json_encode(array("mensaje" => "ERROR. El perfil solo puede ser #socio, #mozo, #bartender, #cocinero o #cervecero."));
                            $r = $r->withStatus(400);
                        }
                  }else{
                    $respuesta = json_encode(array("mensaje" => "ERROR. El nombre de usuario ya existe."));
                    $r = $r->withStatus(400);
                  }

              }else{
                  $respuesta = json_encode(array("mensaje" => "ERROR. Hay parametros vacios."));
                  $r = $r->withStatus(400);
              }
          }else{
              $respuesta = json_encode(array("mensaje" => "ERROR. Faltan parametros."));
              $r = $r->withStatus(400);
          }
        }else if($request->getMethod() === 'PUT'){
            if(isset($parametros['nombre']) && isset($parametros['perfil']) &&
            isset($parametros['clave']) && isset($parametros['estado'])){

              if(!empty($parametros['nombre']) && !empty($parametros['perfil']) &&
                  !empty($parametros['clave']) && !empty($parametros['estado'])){

                  $perfil = $parametros["perfil"];

                  if(strcasecmp($perfil, "socio") == 0){
                    if(UsuarioController::cantidadDeSocios() < 3){
                        $respuesta = $handler->handle($request);       
                        $respuesta = json_decode($respuesta->getBody());                      
                        $respuesta = json_encode($respuesta);    
                        $r = $r->withStatus(200);   
                    }else{
                        $respuesta = json_encode(array("mensaje" => "ERROR. Solo pueden existir 3 socios."));
                        $r = $r->withStatus(400);
                    }

                  } else if (strcasecmp($perfil,"mozo") == 0 ||
                            strcasecmp($perfil,"cervecero") == 0 ||
                            strcasecmp($perfil,"bartender") == 0 ||
                            strcasecmp($perfil,"cocinero") == 0){
                      $respuesta = $handler->handle($request);       
                      $respuesta = json_decode($respuesta->getBody());                      
                      $respuesta = json_encode($respuesta);    
                      $r = $r->withStatus(200);                        
                  }else{
                      $respuesta = json_encode(array("mensaje" => "ERROR. El perfil solo puede ser #socio, #mozo, #bartender, #cocinero o #cervecero."));
                      $r = $r->withStatus(400);
                  }
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
        return $r
            ->withHeader('Content-Type', 'application/json');
    }
}