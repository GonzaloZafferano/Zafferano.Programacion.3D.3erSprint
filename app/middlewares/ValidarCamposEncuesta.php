<?php

use Illuminate\Support\Arr;
use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Server\RequestHandlerInterface as RequestHandler;
use Slim\Psr7\Response;

require_once './controllers/ProductoController.php';
require_once './controllers/MesaController.php';


class ValidarCamposEncuesta
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

            if(isset($parametros['puntuacionMesa']) && isset($parametros['puntuacionMozo']) &&
            isset($parametros['puntuacionCocinero']) && isset($parametros['puntuacionRestaurante']) &&
                isset($parametros['comentarios']) &&  isset($parametros['codigoAlfanumerico']) &&
                isset($parametros['codigoMesa'])){

                if(!empty($parametros['puntuacionMesa']) && !empty($parametros['puntuacionMozo']) &&
                !empty($parametros['puntuacionCocinero']) && !empty($parametros['puntuacionRestaurante']) &&
                !empty($parametros['comentarios']) &&  !empty($parametros['codigoAlfanumerico']) &&
                !empty($parametros['codigoMesa'])){



                    if(is_numeric($parametros['puntuacionMesa']) &&
                     is_numeric($parametros['puntuacionMozo']) && 
                     is_numeric($parametros['puntuacionCocinero']) && 
                     is_numeric($parametros['puntuacionRestaurante'])){

                        $puntuacionMesa = $parametros['puntuacionMesa'];
                        $puntuacionMozo = $parametros['puntuacionMozo'];
                        $puntuacionCocinero = $parametros['puntuacionCocinero'];
                        $puntuacionRestaurante = $parametros['puntuacionRestaurante'];

                        if($puntuacionMesa > 0 && $puntuacionMesa < 11 &&
                            $puntuacionCocinero > 0 && $puntuacionCocinero  < 11 &&
                            $puntuacionMozo > 0 && $puntuacionMesa <11 &&
                            $puntuacionRestaurante >0 && $puntuacionRestaurante <11){
                            $codigoMesa = $parametros['codigoMesa'];
                            $codigoPedido = $parametros['codigoAlfanumerico'];
                            
                            $mesa = MesaController::obtenerMesaPorCodigo($codigoMesa);
                        
                            if($mesa){
                                $pedido = PedidoController::obtenerPedidoPorCodigo($codigoPedido);
                        
                                if($pedido){
                                    if($pedido->mesaId == $mesa->mesaId){
                            
                                        if(strcasecmp($mesa->estado, "con cliente pagando") == 0 ||
                                        strcasecmp($mesa->estado, "cerrada") == 0){
                                            $respuesta = $handler->handle($request);       
                                            $respuesta = json_decode($respuesta->getBody());                      
                                            $respuesta = json_encode($respuesta);    
                                            $r = $r->withStatus(200);   
                                        }else{
                                            $respuesta = json_encode(array("mensaje" => "Para dejar un comentario debe haber abonado el pedido."));  
                                        }
                                    }else{
                                    $respuesta = json_encode(array("mensaje" => "No existe una relacion de ese codigo de pedido con el codigo de mesa."));  
                                    }   
                                }else{
                                    $respuesta = json_encode(array("mensaje" => "No existe una pedido con ese codigo."));  
                                }                      
                                
                            }else{
                                $respuesta = json_encode(array("mensaje" => "No existe una mesa con ese codigo."));  
                            }
                        }else{
                            $respuesta = json_encode(array("mensaje" => "Las puntuaciones deben ser entre 1 y 10."));  
                        }

                    }else{
                        $respuesta = json_encode(array("mensaje" => "Las puntuaciones deben ser numericas."));  
                    }        
                }else{
                    $respuesta = json_encode(array("mensaje" => "ERROR. Hay parametros vacios."));    
                }  
                
            }else{
                $respuesta = json_encode(array("mensaje" => "ERROR. Faltan parametros."));
            }
        }        

        $r->getBody()->write($respuesta);
        return $r
            ->withHeader('Content-Type', 'application/json');
    }
}