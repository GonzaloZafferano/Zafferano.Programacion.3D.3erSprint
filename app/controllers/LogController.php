<?php
require_once './models/Log.php';
require_once './controllers/UsuarioController.php';
require_once "./utils/AutentificatorJWT.php";

class LogController extends Log
{
    public static function CargarUno($request, $accion)
    {
      $header = $request->getHeaderLine('Authorization'); 
      $token = trim(explode("Bearer", $header)[1]);
      $data = AutentificadorJWT::ObtenerData($token); 
      $usuario = UsuarioController::obtenerUsuario($data->nombre);   

      $log = new Log();
      $log->idUsuario = $usuario->empleadoId;
      $log->accion = $accion;
      $log->crearLog();
    } 

    public function TraerTodos($request, $response, $args)
    {
      LogController::CargarUno($request, "Socio pide lista de logs");
 
        $lista = Log::obtenerTodos();

        if(count($lista) > 0){
         $payload = json_encode(array("Logs" => $lista));
        }else{
          $payload = json_encode(array("Logs" => "No hay logs."));
        }

        $response->getBody()->write($payload);
        return $response
          ->withHeader('Content-Type', 'application/json');
    }
}
