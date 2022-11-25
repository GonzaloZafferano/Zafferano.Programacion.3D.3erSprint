<?php
require_once './models/Mesa.php';
require_once './interfaces/IApiUsable.php';
require_once './controllers/LogController.php';


class MesaController extends Mesa implements IApiUsable
{
  public function CargarUno($request, $response, $args)
  {
    $parametros = $request->getParsedBody();

    $estado = $parametros['estado'];

    $mesa = new Mesa();
    $mesa->estado = $estado;

    $mesa->crearMesa();

    $payload = json_encode(array("mensaje" => "Mesa creada con exito"));

    $response->getBody()->write($payload);
    return $response
      ->withHeader('Content-Type', 'application/json');
  }

  public function TraerUno($request, $response, $args)
  {
    $mesaId = $args['id'];

    if(is_numeric($mesaId)){

      $mesa = Mesa::obtenerMesaPorId($mesaId);
  
      if ($mesa) {
        $payload = json_encode($mesa);
  
        $response->getBody()->write($payload);
        return $response
          ->withHeader('Content-Type', 'application/json');
      } else {
        $payload = json_encode(array("mensaje" => "No se encontro la mesa de id: " . $mesaId));
  
        $response->getBody()->write($payload);
        return $response
          ->withHeader('Content-Type', 'application/json');
      }
    }else{
      $payload = json_encode(array("mensaje" => "El id debe ser numerico."));
 
      $response->getBody()->write($payload);
      return $response
        ->withHeader('Content-Type', 'application/json');
     }
  }

  public function TraerTodos($request, $response, $args)
  {
    $lista = Mesa::obtenerTodos();
    $payload = json_encode(array("listaMesas" => $lista));

    $response->getBody()->write($payload);
    return $response
      ->withHeader('Content-Type', 'application/json');
  }


  public function TraerEstadosDeMesas($request, $response, $args)
  {
    $lista = Mesa::obtenerEstadosDeMesas();
    $payload = json_encode(array("listaMesas" => $lista));

    LogController::CargarUno($request, "Socio pide mesas y estados");

    $response->getBody()->write($payload);
    return $response
      ->withHeader('Content-Type', 'application/json');
  }

  public function ModificarUno($request, $response, $args)
  {
    $parametros = $request->getParsedBody();

    $mesaId = $args["id"];

    if(is_numeric($mesaId)){

      $mesa = Mesa::obtenerMesaPorId($mesaId);
  
      if ($mesa) {
        $mesa->estado = $parametros['estado'];
  
        if (Mesa::modificarMesa($mesa)) {
  
          $payload = json_encode(array("mensaje" => "Mesa modificada con exito"));
  
          $response->getBody()->write($payload);
          return $response
            ->withHeader('Content-Type', 'application/json');
        } else {
          $payload = json_encode(array("mensaje" => "No se ha podido modificar la mesa. Revise que los datos enviados sean correctos."));
          $response->getBody()->write($payload);
          return $response
            ->withHeader('Content-Type', 'application/json');
        }
      } else {
        $payload = json_encode(array("mensaje" => "No se ha encontrado la mesa de id: " . $mesaId));
        $response->getBody()->write($payload);
        return $response
          ->withHeader('Content-Type', 'application/json');
      }
    }else{
      $payload = json_encode(array("mensaje" => "El id debe ser numerico."));
 
      $response->getBody()->write($payload);
      return $response
        ->withHeader('Content-Type', 'application/json');
     }
  }


  public function cerrarMesa($request, $response, $args)
  {
    $parametros = $request->getParsedBody();

    LogController::CargarUno($request, "Socio cierra mesa");

    $mesaId = $args["id"];

    if(is_numeric($mesaId)){

      $mesa = Mesa::obtenerMesaPorId($mesaId);
  
      if ($mesa) {
  
        if (strcasecmp($mesa->estado, "cerrada") != 0) {
  
          if (strcasecmp($mesa->estado, "con cliente pagando") == 0) {
  
            $mesa->estado = "Cerrada";
  
            if (Mesa::modificarMesa($mesa)) {
  
              $payload = json_encode(array("mensaje" => "Mesa cerrada con exito"));
  
              $response->getBody()->write($payload);
            }
          } else {
            $payload = json_encode(array("mensaje" => "La mesa debe estar con cliente pagando para ser cerrada."));
            $response->getBody()->write($payload);
          }
        } else {
  
          $payload = json_encode(array("mensaje" => "La mesa ya esta cerrada."));
          $response->getBody()->write($payload);
        }
      } else {
        $payload = json_encode(array("mensaje" => "No se ha encontrado la mesa de id: " . $mesaId));
        $response->getBody()->write($payload);
      }
    }else{
      $payload = json_encode(array("mensaje" => "El id debe ser numerico.")); 
      $response->getBody()->write($payload);
     }
    return $response
      ->withHeader('Content-Type', 'application/json');
  }


  public function cobrarMesa($request, $response, $args)
  {
    $mesaId = $args["id"];

    LogController::CargarUno($request, "Mozo cobra mesa");

    if(is_numeric($mesaId)){

      $mesa = Mesa::obtenerMesaPorId($mesaId);    
  
      if ($mesa) {
  
        if (strcasecmp($mesa->estado, "con cliente pagando") != 0) {
  
          if (strcasecmp($mesa->estado, "con cliente comiendo") == 0) {
  
            $mesa->estado = "con cliente pagando";
  
            Mesa::modificarMesa($mesa);
  
              $pedido = PedidoController::obtenerPedidoParaCobrarPorMesaId($mesa->mesaId);
  
              if($pedido){
      
  
                $total = 0;
                $detallesPedido = DetallesPedidoController::obtenerDetallesPorCodigoDePedido($pedido->codigoAlfanumerico);
                
                if($detallesPedido){
                  
                  foreach($detallesPedido as $detalle){
                    $producto = ProductoController::obtenerProductoPorId($detalle->productoId);
                    $total += $detalle->cantidad * $producto->precio;
                  }
                  $pedido->estado = "Terminado";
      
                  PedidoController::modificarEstadoPedido($pedido);
      
                  $payload = json_encode(array("mensaje" => "Mesa cobrada con exito. Total a pagar $". $total));

                }
              }else{
                $payload = json_encode(array("Error" => "No se encontro un pedido para la Mesa: " . $mesa->mesaId));
              }
  
  
            }else{
              $payload = json_encode(array("Error" => "La mesa debe tener un cliente comiendo para poder cobrarle."));
            }
          } else {
    
            $payload = json_encode(array("mensaje" => "La mesa ya tiene al cliente pagando."));
          }
        } else {
          $payload = json_encode(array("Error" => "No se ha encontrado la mesa de id: " . $mesaId));
        }
    }
    else{
      $payload = json_encode(array("mensaje" => "El id debe ser numerico."));
     }
    $response->getBody()->write($payload);
    return $response
      ->withHeader('Content-Type', 'application/json');
  }

  public function BorrarUno($request, $response, $args)
  {
    $mesaId =  $args["id"];

    if(is_numeric($mesaId)){
      if (Mesa::borrarMesa($mesaId)) {
  
        $payload = json_encode(array("mensaje" => "Mesa borrada con exito"));
  
        $response->getBody()->write($payload);
        return $response
          ->withHeader('Content-Type', 'application/json');
      } else {
        $payload = json_encode(array("mensaje" => "No se ha encontrado la mesa para borrar."));
  
        $response->getBody()->write($payload);
        return $response
          ->withHeader('Content-Type', 'application/json');
      }

    }else{
      $payload = json_encode(array("mensaje" => "El id debe ser numerico."));
 
      $response->getBody()->write($payload);
      return $response
        ->withHeader('Content-Type', 'application/json');
     }
  }

  public function TraerMesaMasUsada($request, $response, $args)
  {  
    LogController::CargarUno($request, "Socio pide mesa mas usada");

      $mesaMasUsada = Mesa::MesaMasUsada();

      if($mesaMasUsada){
        $payload = json_encode(array("Mesa mas usada" => $mesaMasUsada));
      }else{
        $payload = json_encode(array("mensaje" => "No hay mesas."));
      }

      $response->getBody()->write($payload);
      return $response
        ->withHeader('Content-Type', 'application/json');    
  }
  

  public static function TraerMesaPorId($id)
  {    
    return Mesa::obtenerMesaPorId($id);
  }

  public static function modificarEstadoDeMesa($estado, $id)
  {
    return Mesa::modificarEstadoMesa($estado, $id);
  }
}
