<?php
require_once './models/DetallesPedido.php';
require_once './interfaces/IApiUsable.php';
require_once './controllers/LogController.php';

class DetallesPedidoController extends DetallesPedido
{
    public static function CargarUno($codigoAlfanumerico, $estado, $productoId, $cantidad, $perfil)
    {        
        $detallesPedido = new DetallesPedido();
        $detallesPedido->codigoAlfanumerico = $codigoAlfanumerico;
        $detallesPedido->productoId = $productoId;      
        $detallesPedido->estado = $estado;      
        $detallesPedido->cantidad = $cantidad;      
        $detallesPedido->perfil = $perfil;      
        
        $detallesPedido->crearDetalles();
    }

    public function TraerUno($request, $response, $args)
    {
        $codigoAlfanumerico = $args['codigoAlfanumerico'];
        $pedido = Pedido::obtenerPedido($codigoAlfanumerico);

        if($pedido){
          $payload = json_encode($pedido);
  
          $response->getBody()->write($payload);
          return $response
            ->withHeader('Content-Type', 'application/json');           
        }else{
          $payload = json_encode(array("mensaje" => "No se encontro el pedido de codigo: " . $codigoAlfanumerico));
    
          $response->getBody()->write($payload);
          return $response
            ->withHeader('Content-Type', 'application/json');
        }
    }

    public function TraerTodos($request, $response, $args)
    {
        $lista = Pedido::obtenerTodos();
        $payload = json_encode(array("listaPedidos" => $lista));

        $response->getBody()->write($payload);
        return $response
          ->withHeader('Content-Type', 'application/json');
    }
    
    public function ModificarUno($request, $response, $args)
    {
      $parametros = $request->getParsedBody();

      $pedidoId = $args["id"];
      
      $pedido = Pedido::obtenerPedidoPorId($pedidoId);

      if($pedido){
        $pedido->estado = $parametros['estado'];
  
        if(Pedido::modificarPedido($pedido)){
  
          $payload = json_encode(array("mensaje" => "Pedido modificado con exito"));
    
          $response->getBody()->write($payload);
          return $response
            ->withHeader('Content-Type', 'application/json');

        }else{
          $payload = json_encode(array("mensaje" => "No se ha podido modificar el pedido. Revise que los datos enviados sean correctos."));  
          $response->getBody()->write($payload);
          return $response
            ->withHeader('Content-Type', 'application/json');
        }

      }else{
        $payload = json_encode(array("mensaje" => "No se ha encontrado al pedido de id: " . $pedidoId));  
        $response->getBody()->write($payload);
        return $response
          ->withHeader('Content-Type', 'application/json');
      }
    }

    public function BorrarUno($request, $response, $args)
    {   
        $pedidoId =  $args["id"];

        if(Pedido::borrarPedido($pedidoId)){

          $payload = json_encode(array("mensaje" => "Pedido cancelado con exito"));
  
          $response->getBody()->write($payload);
          return $response
            ->withHeader('Content-Type', 'application/json');
        }else{
          $payload = json_encode(array("mensaje" => "No se ha encontrado al pedido para borrar."));
  
          $response->getBody()->write($payload);
          return $response
            ->withHeader('Content-Type', 'application/json');
        }
    }


    public function LevantarPedidosCervecero($request, $response, $args){

      $header = $request->getHeaderLine('Authorization');
      $payload = json_encode(array("mensaje" => "No se han encontrado pedidos pendientes."));

      $pedidosPorPerfil = DetallesPedido::pendientesPerfil("cervecero");

      $cantidadPendientes = count($pedidosPorPerfil);

      if($cantidadPendientes > 0){
        if(isset(explode("Bearer", $header)[1])){
            
        $token = trim(explode("Bearer", $header)[1]);

            $data = AutentificadorJWT::ObtenerData($token);            
          
            $nombre = $data->nombre;
            $usuario = UsuarioController::obtenerUsuario($nombre);

            foreach($pedidosPorPerfil as $pedido){
            $pedido->empleadoId = $usuario->empleadoId;
            DetallesPedido::levantarPedido($pedido);
          }

            LogController::CargarUno($request, "Cervecero levanta pedidos");

          $payload = json_encode(array("mensaje" => "Se han levantado " .$cantidadPendientes. " pedidos."));

        }
      }

      $response->getBody()->write($payload);
      return $response
        ->withHeader('Content-Type', 'application/json');
    }

    public function LevantarPedidosBartender($request, $response, $args){

      $header = $request->getHeaderLine('Authorization');
      $payload = json_encode(array("mensaje" => "No se han encontrado pedidos pendientes."));

      $pedidosPorPerfil = DetallesPedido::pendientesPerfil("bartender");

      $cantidadPendientes = count($pedidosPorPerfil);

      if($cantidadPendientes > 0){
        if(isset(explode("Bearer", $header)[1])){
            
            $token = trim(explode("Bearer", $header)[1]);
  
                $data = AutentificadorJWT::ObtenerData($token);            
             
                $nombre = $data->nombre;
                $usuario = UsuarioController::obtenerUsuario($nombre);
  
                foreach($pedidosPorPerfil as $pedido){
                  $pedido->empleadoId = $usuario->empleadoId;
                  DetallesPedido::levantarPedido($pedido);
                }
    
                LogController::CargarUno($request, "Bartender levanta pedidos");

              $payload = json_encode(array("mensaje" => "Se han levantado " .$cantidadPendientes. " pedidos."));
  
            }
      }

      $response->getBody()->write($payload);
      return $response
        ->withHeader('Content-Type', 'application/json');
    }

    public function LevantarPedidosCocinero($request, $response, $args){

      $header = $request->getHeaderLine('Authorization');
      $payload = json_encode(array("mensaje" => "No se han encontrado pedidos pendientes."));

      $pedidosPorPerfil = DetallesPedido::pendientesPerfil("cocinero");

      $cantidadPendientes = count($pedidosPorPerfil);

      if($cantidadPendientes > 0){
        if(isset(explode("Bearer", $header)[1])){
            
            $token = trim(explode("Bearer", $header)[1]);
  
                $data = AutentificadorJWT::ObtenerData($token);            
             
                $nombre = $data->nombre;
                $usuario = UsuarioController::obtenerUsuario($nombre);
  
              foreach($pedidosPorPerfil as $pedido){
                $pedido->empleadoId = $usuario->empleadoId;
                DetallesPedido::levantarPedido($pedido);
              }

              LogController::CargarUno($request, "Cocinero levanta pedidos");

              $payload = json_encode(array("mensaje" => "Se han levantado " .$cantidadPendientes. " pedidos."));
  
            }
      }

      $response->getBody()->write($payload);
      return $response
        ->withHeader('Content-Type', 'application/json');
    }



    public function VerPendientesCocinero($request, $response, $args){

      $payload = json_encode(array("mensaje" => "No se han encontrado pedidos pendientes."));

      $pedidosPorPerfil = DetallesPedido::pendientesPerfil("cocinero");

      if($pedidosPorPerfil){
        $cantidadPendientes = count($pedidosPorPerfil);

        if($cantidadPendientes > 0){         
          $payload = json_encode(array("Pendientes: " .$cantidadPendientes => $pedidosPorPerfil));    
        }
        LogController::CargarUno($request, "Cocinero revisa pedidos pendientes");
      }

      $response->getBody()->write($payload);
      return $response
        ->withHeader('Content-Type', 'application/json');
    }

    public function VerPendientesBartender($request, $response, $args){

      $payload = json_encode(array("mensaje" => "No se han encontrado pedidos pendientes."));

      $pedidosPorPerfil = DetallesPedido::pendientesPerfil("bartender");

      if($pedidosPorPerfil){
        $cantidadPendientes = count($pedidosPorPerfil);

        if($cantidadPendientes > 0){
          $payload = json_encode(array("Pendientes: " .$cantidadPendientes => $pedidosPorPerfil));    
        }
      }

      LogController::CargarUno($request, "Bartender revisa pedidos pendientes");

      $response->getBody()->write($payload);
      return $response
        ->withHeader('Content-Type', 'application/json');
    }

    public function VerPendientesCervecero($request, $response, $args){

      $payload = json_encode(array("mensaje" => "No se han encontrado pedidos pendientes."));

      $pedidosPorPerfil = DetallesPedido::pendientesPerfil("cervecero");

      if($pedidosPorPerfil){
        $cantidadPendientes = count($pedidosPorPerfil);

        if($cantidadPendientes > 0){
          $payload = json_encode(array("Pendientes: " .$cantidadPendientes => $pedidosPorPerfil));    
        }
      }
      LogController::CargarUno($request, "Cervecero revisa pedidos pendientes");

      $response->getBody()->write($payload);
      return $response
        ->withHeader('Content-Type', 'application/json');
    }

    public function ListoParaServirCervecero($request, $response, $args){
   
      $header = $request->getHeaderLine('Authorization');
      if(isset(explode("Bearer", $header)[1])){
            
        $token = trim(explode("Bearer", $header)[1]);

        $data = AutentificadorJWT::ObtenerData($token);            
      
        $nombre = $data->nombre;
        $usuario = UsuarioController::obtenerUsuario($nombre);

        $payload = json_encode(array("mensaje" => "No se han encontrado pedidos listos para servir del empleado: " . $usuario->nombre));

        $pedidosPorPerfil = DetallesPedido::obtenerListasParaServirUsuario($usuario);

        if($pedidosPorPerfil){
        $cantidadPendientes = count($pedidosPorPerfil);

          if($cantidadPendientes > 0){       
            DetallesPedido::setearListasParaServirUsuario($usuario);    
            $payload = json_encode(array("mensaje" => "(Cervecero) Hay " .$cantidadPendientes. " listos para servir del empleado: " . $usuario->nombre . " (Entregado al mozo)."));          
          }
        }
        LogController::CargarUno($request, "Cervecero (id: ".$usuario->empleadoId.") revisa pedidos listos para servir");
      }

      $response->getBody()->write($payload);
      return $response
        ->withHeader('Content-Type', 'application/json');
    }

    public function ListoParaServirBartender($request, $response, $args){
   
      $header = $request->getHeaderLine('Authorization');
      if(isset(explode("Bearer", $header)[1])){
            
        $token = trim(explode("Bearer", $header)[1]);

        $data = AutentificadorJWT::ObtenerData($token);            
      
        $nombre = $data->nombre;
        $usuario = UsuarioController::obtenerUsuario($nombre);

        $payload = json_encode(array("mensaje" => "No se han encontrado pedidos listos para servir del empleado: " . $usuario->nombre));

        $pedidosPorPerfil = DetallesPedido::obtenerListasParaServirUsuario($usuario);

        if($pedidosPorPerfil){
        $cantidadPendientes = count($pedidosPorPerfil);

          if($cantidadPendientes > 0){       
            DetallesPedido::setearListasParaServirUsuario($usuario);    
            $payload = json_encode(array("mensaje" => "(Bartender) Hay " .$cantidadPendientes. " listos para servir del empleado: " . $usuario->nombre . " (Entregado al mozo)."));          
          }
        }
        LogController::CargarUno($request, "Bartender (id: ".$usuario->empleadoId.") revisa pedidos listos para servir");
      }

      $response->getBody()->write($payload);
      return $response
        ->withHeader('Content-Type', 'application/json');
  }
  

    public function ListoParaServirCocinero($request, $response, $args){
   
      $header = $request->getHeaderLine('Authorization');
      if(isset(explode("Bearer", $header)[1])){
            
        $token = trim(explode("Bearer", $header)[1]);

        $data = AutentificadorJWT::ObtenerData($token);            
      
        $nombre = $data->nombre;
        $usuario = UsuarioController::obtenerUsuario($nombre);

        $payload = json_encode(array("mensaje" => "No se han encontrado pedidos listos para servir del empleado: " . $usuario->nombre));

        $pedidosPorPerfil = DetallesPedido::obtenerListasParaServirUsuario($usuario);

        if($pedidosPorPerfil){
        $cantidadPendientes = count($pedidosPorPerfil);

          if($cantidadPendientes > 0){       
            DetallesPedido::setearListasParaServirUsuario($usuario);    
            $payload = json_encode(array("mensaje" => "(Cocinero) Hay " .$cantidadPendientes. " listos para servir del empleado: " . $usuario->nombre . " (Entregado al mozo)."));          
          }
        }
        LogController::CargarUno($request, "Cocinero (id: ".$usuario->empleadoId.") revisa pedidos listos para servir");
      }

      $response->getBody()->write($payload);
      return $response
        ->withHeader('Content-Type', 'application/json');
    }

    public static function obtenerDetallesPorCodigoDePedido($codigo){
      return DetallesPedido::obtenerProductosDeUnPedido($codigo);
    }

    public function mostrarDetallesDePedidosPendientes($request, $response, $args){

      $payload = json_encode(array("Productos pendientes" => "No se han encontrado pedidos pendientes."));
      $pendientes = DetallesPedido::mostrarPedidosPendientes();

      if(count($pendientes) > 0){
        $payload = json_encode(array("Pendientes" => $pendientes));

      }
      $response->getBody()->write($payload);
      return $response
        ->withHeader('Content-Type', 'application/json');
    }

    public function mostrarDetallesDePedidosEnPreparacion($request, $response, $args){

      $payload = json_encode(array("Productos en preparacion" => "No se han encontrado pedidos en preparacion."));
      $pedidosEnPreparacion =  DetallesPedido::mostrarPedidosEnPreparacion();

      if(count($pedidosEnPreparacion) > 0){

        $tiempoActual =  new DateTime();   
        $tiempoActual = $tiempoActual->getTimestamp();

        foreach($pedidosEnPreparacion as $pedidoEnPreparacion){

          if($pedidoEnPreparacion->tiempoPreparacion < $tiempoActual){
            $tiempoDeEspera = "Terminado";
          }else{
            $tiempoDeEsperaRestante = DateTime::createFromFormat('U', $pedidoEnPreparacion->tiempoPreparacion - $tiempoActual);
            $tiempoDeEspera =  $tiempoDeEsperaRestante->format("i:s");      
          }  
          $pedidoEnPreparacion->tiempoPreparacion = $tiempoDeEspera;
        }
        $payload = json_encode(array("En preparacion" => $pedidosEnPreparacion));        
      }
      $response->getBody()->write($payload);
      return $response
        ->withHeader('Content-Type', 'application/json');
    }
}
