<?php

use Illuminate\Support\Arr;
use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Server\RequestHandlerInterface as RequestHandler;
use Slim\Psr7\Response;

require_once './controllers/ProductoController.php';
require_once './controllers/MesaController.php';


class ValidarCamposPedido
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
        $esValido = true;
        $esNumeroValido = true;

        if($request->getMethod() === 'POST'){
            if(isset($parametros['nombreCliente']) && isset($parametros['mesaId']) &&
            isset($parametros['productos'])){

              if(!empty($parametros['nombreCliente']) && !empty($parametros['mesaId']) &&
                  !empty($parametros['productos'])){

                    if(is_numeric($parametros['mesaId'])){

                        $mesa = MesaController::obtenerMesaPorId($parametros["mesaId"]);
    
                        if($mesa){
    
                            if(strcasecmp($mesa->estado, "cerrada") == 0){
    
                                $productos = $parametros["productos"];
                                $productos = json_decode($productos);
                                if(is_array($productos)){
            
                                    foreach($productos as $producto){
                                        $unProducto = ProductoController::obtenerProducto($producto->producto);
                                        if(!$unProducto){
                                            $esValido = false;
                                            break;
                                        }
    
                                        if(!is_numeric($producto->cantidad)){
                                            $esNumeroValido = false;
                                            break;
                                        }
                                    }
                                    if($esValido){
    
                                        if($esNumeroValido){
                                            $respuesta = $handler->handle($request);       
                                            $respuesta = json_decode($respuesta->getBody());                      
                                            $respuesta = json_encode($respuesta);    
                                            $r = $r->withStatus(200);   
                                        }else{
                                            $respuesta = json_encode(array("mensaje" => "ERROR. La cantidad de producto debe ser numerica."));
                                            $r = $r->withStatus(400);
                                        }
                                    }else{
                                        $respuesta = json_encode(array("mensaje" => "ERROR. No se han encontrado algunos productos."));
                                        $r = $r->withStatus(400);
                                    }
            
                                }else{
                                    $respuesta = json_encode(array("mensaje" => "ERROR. Formato incorrecto de productos. Debe enviarse como lista."));
                                    $r = $r->withStatus(400);
                                }
                            }else{
                                $respuesta = json_encode(array("mensaje" => "ERROR. La mesa esta ocupada."));
                                $r = $r->withStatus(400);
                            }
                        }else{
                            $respuesta = json_encode(array("mensaje" => "ERROR. No existe la mesa."));
                            $r = $r->withStatus(400);
                        }
                    }else{
                        $respuesta = json_encode(array("mensaje" => "ERROR. El id de la mesa debe ser un numero."));
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
            }else if($request->getMethod() === 'GET'){
    
                if(isset($request->getQueryParams()["codigoMesa"]) && isset($request->getQueryParams()["codigoPedido"])){
  
    
                    if(!empty($request->getQueryParams()["codigoMesa"]) && !empty($request->getQueryParams()["codigoPedido"])){
    
    
                        $codigoMesa = $request->getQueryParams()["codigoMesa"];
                        $codigoPedido = $request->getQueryParams()["codigoPedido"];
                       
                        $mesa = MesaController::obtenerMesaPorCodigo($codigoMesa);
                  
                        if($mesa){
                          $pedido = PedidoController::obtenerPedidoPorCodigo($codigoPedido);
                  
                          if($pedido){                            
                            if($pedido->mesaId == $mesa->mesaId){
                            
                                $respuesta = $handler->handle($request);       
                                $respuesta = json_decode($respuesta->getBody());                      
                                $respuesta = json_encode($respuesta);    
                                $r = $r->withStatus(200);                                  
                            }else{
                            $respuesta = json_encode(array("mensaje" => "No existe una relacion del codigo de pedido con el codigo de mesa."));  

                            }
                        }else{
                          $respuesta = json_encode(array("mensaje" => "No existe una pedido con ese codigo."));  
                        }
                        
                        
                    }else{
                      $respuesta = json_encode(array("mensaje" => "No existe una mesa con ese codigo."));  
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