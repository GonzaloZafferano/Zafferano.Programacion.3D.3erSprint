<?php
require_once './models/Pedido.php';
require_once './interfaces/IApiUsable.php';
require_once './controllers/ProductoController.php';
require_once './controllers/DetallesPedidoController.php';
require_once './controllers/MesaController.php';
require_once './controllers/LogController.php';

class PedidoController extends Pedido implements IApiUsable
{
    public function asignarFotoAlPedido($request, $response, $args){
       
      $codigoPedido =  $args["codigoAlfanumerico"];
     
      $uploadedFiles = $request->getUploadedFiles(); 

      $pedido = Pedido::obtenerPedidoPorCodigo($codigoPedido);

      if($pedido){

          if(isset($uploadedFiles['fotoUrl']) && !empty($uploadedFiles['fotoUrl']->getFilePath())){ 
            $tempFile = $uploadedFiles['fotoUrl']->getFilePath();   
            $nombreArchivo = $uploadedFiles['fotoUrl']->getClientFilename();
            
            $extension = ".jpg";
    
            if(strpos($nombreArchivo, ".")){
              $extension = "." . explode(".", $nombreArchivo)[1];    
            }
            
            if(!is_dir("./FotosPedidos")){   
              mkdir("./FotosPedidos");
            }
    
            $ruta = "./FotosPedidos/cliente-" . $pedido->nombreCliente . "-codigoAlfanumericoPedido-" . $pedido->codigoAlfanumerico . $extension;
      
            move_uploaded_file($tempFile, $ruta);
    
            $fotoUrl = $ruta;
            $pedido->fotoUrl = $fotoUrl;     
            Pedido::asignarFotoPedido($pedido);

            LogController::CargarUno($request, "Mozo Asocia foto al pedido");

            $payload = json_encode(array("mensaje" => "Foto asociada al pedido con exito. URL: " . $fotoUrl)); 
          }else{
            $payload = json_encode(array("mensaje" => "ERROR. No hay foto."));
        } 
      }else{
        $payload = json_encode(array("mensaje" => "ERROR. No existe un pedido con ese codigo."));
      }

      $response->getBody()->write($payload);
      return $response
        ->withHeader('Content-Type', 'application/json');
    }


    public function CargarUno($request, $response, $args)
    {
      $header = $request->getHeaderLine('Authorization'); 
      $payload = "Ha ocurrido un error de autentificacion.";

      if(isset(explode("Bearer", $header)[1])){
          
          $token = trim(explode("Bearer", $header)[1]);
          $data = AutentificadorJWT::ObtenerData($token);          

          $mozo = UsuarioController::obtenerUsuario($data->nombre);         

          LogController::CargarUno($request, "Mozo Carga el pedido");

          $parametros = $request->getParsedBody();
 
          $nombreCliente = $parametros['nombreCliente'];
          $mesaId = $parametros['mesaId'];
          $estado = "En preparacion";  
     
        $mesa = MesaController::obtenerMesaPorId($mesaId);
    
          $pedido = new Pedido();
          $pedido->codigoAlfanumerico = substr(md5(time()), 0, 5);;
          $pedido->nombreCliente = $nombreCliente;      
          $pedido->mesaId = $mesaId;      
          $pedido->estado = $estado;  
          $pedido->mozoId = $mozo->empleadoId;  
          
          $uploadedFiles = $request->getUploadedFiles(); 
  
          if(isset($uploadedFiles['fotoUrl']) && !empty($uploadedFiles['fotoUrl']->getFilePath())){ 
            $tempFile = $uploadedFiles['fotoUrl']->getFilePath();   
            $nombreArchivo = $uploadedFiles['fotoUrl']->getClientFilename();
            
            $extension = ".jpg";
    
            if(strpos($nombreArchivo, ".")){
              $extension = "." . explode(".", $nombreArchivo)[1];    
            }
            
            if(!is_dir("./FotosPedidos")){   
              mkdir("./FotosPedidos");
            }
  
            $ruta = "./FotosPedidos/cliente-" . $nombreCliente . "-codigoAlfanumericoPedido-" . $pedido->codigoAlfanumerico . $extension;
      
            move_uploaded_file($tempFile, $ruta);
  
            $fotoUrl = $ruta;
  
          }else{
            $fotoUrl = null;
          }
      
          $pedido->fotoUrl = $fotoUrl;      
  
         $productos = $parametros['productos'];       
         $productos = json_decode($productos);
  
         foreach($productos as $producto){  
           $productoExistente = ProductoController::obtenerProducto($producto->producto); 
           
           if($productoExistente){
            MesaController::modificarEstadoMesa("con cliente esperando pedido", $mesaId);
  
             DetallesPedidoController::CargarUno($pedido->codigoAlfanumerico,
            "Pendiente", $productoExistente->productoId, $producto->cantidad, $productoExistente->perfil);
           }    
         }
  
          $pedido->crearPedido();
  
          $payload = json_encode(array("mensaje" => "Pedido creado con exito. Su codigo alfanumerico de pedido es: " . $pedido->codigoAlfanumerico . 
          " y el codigo de mesa es: " . $mesa->codigoMesa)); 
      }
        
        $response->getBody()->write($payload);
        return $response
          ->withHeader('Content-Type', 'application/json');
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

        if(count($lista) > 0){
          $payload = json_encode(array("listaPedidos" => $lista));
        }else{
          $payload = json_encode(array("mensaje" => "No hay pedidos."));
        }

        $response->getBody()->write($payload);
        return $response
          ->withHeader('Content-Type', 'application/json');
    }
    
    public function ModificarUno($request, $response, $args)
    {
      $parametros = $request->getParsedBody();

      $pedidoId = $args["id"];
      
      if(is_numeric($pedidoId)){

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
      }else{
        $payload = json_encode(array("mensaje" => "El id debe ser numerico."));
   
        $response->getBody()->write($payload);
        return $response
          ->withHeader('Content-Type', 'application/json');
       }
    }

    public function BorrarUno($request, $response, $args)
    {   
        $pedidoId =  $args["id"];

        if(is_numeric($pedidoId)){
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

        }else{
          $payload = json_encode(array("mensaje" => "El id debe ser numerico."));
     
          $response->getBody()->write($payload);
          return $response
            ->withHeader('Content-Type', 'application/json');
         }
    }

    public static function verificarListoParaServir($request, $response, $args){
      PedidoController::establecerTiempoDePedidos();
      PedidoController::revisarPedidosListosParaServir();   
      $pedidos = Pedido::obtenerTodos();
      $listosParaServir = 0;

      $header = $request->getHeaderLine('Authorization');
      if(isset(explode("Bearer", $header)[1])){
            
        $token = trim(explode("Bearer", $header)[1]);

        $data = AutentificadorJWT::ObtenerData($token);            
      
        $nombre = $data->nombre;
        $usuario = UsuarioController::obtenerUsuario($nombre);

        LogController::CargarUno($request, "Mozo (id: ".$usuario->empleadoId.") verifica si hay pedidos listos para servir");
  
        if($pedidos){
  
          $tiempoActual =  new DateTime();   
          $tiempoActual = $tiempoActual->getTimestamp();
          foreach($pedidos as $pedido){ 
            if(strcasecmp($pedido->estado, "listo para servir") == 0 &&
              $pedido->mozoId == $usuario->empleadoId){                            
              if(isset($pedido->tiempoPreparacion)){
                if($pedido->tiempoPreparacion < $tiempoActual){   
                  $pedido->estado = "Entregado";  
                  Pedido::modificarPedido($pedido);
                  MesaController::modificarEstadoDeMesa("con cliente comiendo", $pedido->mesaId);
                  $listosParaServir++;
                }            
              }
            }
          }
        }
  
        if($listosParaServir > 0){
          $mensaje = "Se entregaron ".$listosParaServir." pedidos listos para servir por el empleado: " . $usuario->nombre;
        }else{
          $mensaje  = "No hay pedidos listos para servir para el empleado: " . $usuario->nombre;
        }
  
        $payload = json_encode(array("mensaje" => $mensaje));  
      }

      $response->getBody()->write($payload);
      return $response
        ->withHeader('Content-Type', 'application/json');
    }

    public static function revisarPedidosListosParaServir(){
      $pedidos = Pedido::obtenerTodos();

      foreach($pedidos as $pedido){
        $pedidoListo = true;
        if( strcasecmp($pedido->estado, "terminado") != 0 &&
        strcasecmp($pedido->estado, "entregado") != 0){

          $detallesDelPedido = DetallesPedido::obtenerProductosDeUnPedido($pedido->codigoAlfanumerico);

          foreach($detallesDelPedido as $detalle){
            if(strcasecmp($detalle->estado, "listo para servir") != 0){
              $pedidoListo = false;
              break;
            }
          }

          if($pedidoListo){
            $pedido->estado = "Listo para servir";
            Pedido::modificarPedido($pedido);
          }
        }
      }    
    }

    
    public static function verEstadoYTiempoDeEsperaDePedidos($request, $response, $args){
      PedidoController::establecerTiempoDePedidos();

      LogController::CargarUno($request, "Socio pide tiempo y estado de pedidos.");

      $pedidos = Pedido::obtenerTodos();
      $cantidadPedidos = 0;
      $pedidosConEstadoYTiempo = array();
      if($pedidos){        
        $tiempoActual =  new DateTime();   
        $tiempoActual = $tiempoActual->getTimestamp();
        foreach($pedidos as $pedido){
      
          if(strcasecmp($pedido->estado, "terminado") != 0){           
            $cantidadPedidos++;
            $estado = "En espera";
            $tiempoDeEspera = "Sin definir (Faltan productos por levantar)";
                      
            if(isset($pedido->tiempoPreparacion)){
              $estado = "En preparacion";
              if($pedido->tiempoPreparacion < $tiempoActual){
                $estado = "listo para servir";
                $tiempoDeEspera = "Terminado";
              }else{
                $tiempoDeEsperaRestante = DateTime::createFromFormat('U', $pedido->tiempoPreparacion - $tiempoActual);
                $tiempoDeEspera =  $tiempoDeEsperaRestante->format("i:s");              
              }
          }
          
          $mensaje = "Estado pedido n° " . $pedido->codigoAlfanumerico.  ": " . $estado .". Tiempo restate: " . $tiempoDeEspera;
          array_push($pedidosConEstadoYTiempo, $mensaje);
          }
        }
      }
  
      if($cantidadPedidos == 0){
          $pedidosConEstadoYTiempo = array("Mensaje" => "Sin pedidos pendientes.");    
      }
      $payload = json_encode($pedidosConEstadoYTiempo);

      $response->getBody()->write($payload);
      return $response
        ->withHeader('Content-Type', 'application/json');
    }

    public static function establecerTiempoDePedidos(){
      $pedidos = Pedido::obtenerTodos();
      if($pedidos){
        foreach($pedidos as $pedido){
          $mayor = 0;
          $esValido = true;

          $listaDetalles = DetallesPedidoController::obtenerProductosDeUnPedido($pedido->codigoAlfanumerico);

          foreach($listaDetalles as $detalle){
            if(isset($detalle->tiempoPreparacion)){
              if($detalle->tiempoPreparacion > $mayor){
                $mayor = $detalle->tiempoPreparacion;
              }
            }else{
              $esValido = false;
              break;
            }
          }

          if($esValido){
            $pedido->tiempoPreparacion = $mayor;
            Pedido::actualizarTiempoDePedido($pedido);
          }
        }
      }
    }

    public static function obtenerPedidoParaCobrarPorMesaId($mesaId)
    {
      return Pedido::obtenerPedidoParaCobrar($mesaId);
    }

    public static function modificarEstadoPedido($pedido)
    {
      return Pedido::modificarPedido($pedido);
    }

    public function tiempoRestanteDePedidoCliente($request, $response, $args){
      PedidoController::establecerTiempoDePedidos();
      $codigoMesa = $request->getQueryParams()["codigoMesa"];
      $codigoPedido = $request->getQueryParams()["codigoPedido"];
     
      $mesa = MesaController::obtenerMesaPorCodigo($codigoMesa);
      if($mesa){
        $pedido = PedidoController::obtenerPedidoPorCodigo($codigoPedido);
    
        if($pedido){
          if($pedido->mesaId == $mesa->mesaId){
            $tiempoDeEspera = "Sin definir (Faltan productos por levantar)";
            
            if(isset($pedido->tiempoPreparacion)){

              $tiempoActual =  new DateTime();   
              $tiempoActual = $tiempoActual->getTimestamp();

              if($pedido->tiempoPreparacion < $tiempoActual){
                $tiempoDeEspera = "Terminado";
              }else{
                $tiempoDeEsperaRestante = DateTime::createFromFormat('U', $pedido->tiempoPreparacion - $tiempoActual);
                $tiempoDeEspera =  $tiempoDeEsperaRestante->format("i:s");              
              }
            }

          $payload = json_encode(array("mensaje" => "Tiempo restante para su pedido: " . $tiempoDeEspera));  

          }else{
            $payload = json_encode(array("mensaje" => "Los codigos son incorrectos."));  
          }
        }else{
          $payload = json_encode(array("mensaje" => "No existe una pedido con ese codigo."));  
        }
      }else{
        $payload = json_encode(array("mensaje" => "No existe una mesa con ese codigo."));  
      }
      
      $response->getBody()->write($payload);
      return $response
        ->withHeader('Content-Type', 'application/json');
    }
}
