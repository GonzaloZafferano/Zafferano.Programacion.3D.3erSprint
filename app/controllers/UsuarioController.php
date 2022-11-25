<?php
require_once './models/Usuario.php';
require_once './interfaces/IApiUsable.php';
require_once "./utils/AutentificatorJWT.php";


class UsuarioController extends Usuario implements IApiUsable
{
    public function CargarUno($request, $response, $args)
    {
        $parametros = $request->getParsedBody();

        $nombre = $parametros['nombre'];
        $fechaIngreso = $parametros['fechaIngreso'];
        $clave = $parametros['clave'];
        $perfil = $parametros['perfil'];

        // Creamos el usuario
        $nuevoUsuario = new Usuario();
        $nuevoUsuario->nombre = $nombre;
        $nuevoUsuario->clave = $clave;
        $nuevoUsuario->fechaIngreso = $fechaIngreso;
        $nuevoUsuario->perfil = $perfil;
        $nuevoUsuario->crearUsuario();

        $payload = json_encode(array("mensaje" => "Usuario creado con exito.", "Su token es:" =>  $this->crearToken($request)));

        $response->getBody()->write($payload);
        return $response
          ->withHeader('Content-Type', 'application/json');
    }

    public function crearToken ($request) {    
      $parametros = $request->getParsedBody();
      
      $nombre = $parametros['nombre'];
      $perfil = $parametros['perfil'];
      $clave = $parametros['clave'];
  
      $datos = array('nombre' => $nombre, 'perfil' => $perfil, 'clave' => $clave);
  
      $token = AutentificadorJWT::CrearToken($datos);
      return $token;
    }
    
    public static function cantidadDeSocios(){
      $socios = Usuario::obtenerSocios();

      if($socios){
        return count($socios);
      }
      return 0;
    }

    public function TraerUno($request, $response, $args)
    {
        $usr = $args['usuario'];
        $usuario = Usuario::obtenerUsuario($usr);

        if($usuario){
          $payload = json_encode($usuario);
  
          $response->getBody()->write($payload);
          return $response
            ->withHeader('Content-Type', 'application/json');           
        }else{
          $payload = json_encode(array("mensaje" => "No se encontro al usuario: " . $usr));
    
          $response->getBody()->write($payload);
          return $response
            ->withHeader('Content-Type', 'application/json');

        }
    }

    public function TraerTodos($request, $response, $args)
    {
        $lista = Usuario::obtenerTodos();
        $payload = json_encode(array("listaUsuario" => $lista));

        $response->getBody()->write($payload);
        return $response
          ->withHeader('Content-Type', 'application/json');
    }

    
    public static function ExisteNombreDeUsuario($nombre)
    {
        return Usuario::obtenerUsuario($nombre);
    }
    
    public function ModificarUno($request, $response, $args)
    {
      $parametros = $request->getParsedBody();

      $usuarioId = $args["id"];

      if(is_numeric($usuarioId)){

        $usuario = Usuario::obtenerUsuarioPorId($usuarioId);
  
        if($usuario){
          $usuario->nombre = $parametros['nombre'];
          $usuario->clave = $parametros['clave'];
          $usuario->perfil = $parametros['perfil'];
          $usuario->estado = $parametros['estado'];
    
          if(Usuario::modificarUsuario($usuario)){
    
            $payload = json_encode(array("mensaje" => "Usuario modificado con exito"));
      
            $response->getBody()->write($payload);
            return $response
              ->withHeader('Content-Type', 'application/json');
  
          }else{
            $payload = json_encode(array("mensaje" => "No se ha podido modificar el usuario. Revise que los datos enviados sean correctos."));  
            $response->getBody()->write($payload);
            return $response
              ->withHeader('Content-Type', 'application/json');
          }
  
        }else{
          $payload = json_encode(array("mensaje" => "No se ha encontrado al usuario de id: " . $usuarioId));  
          $response->getBody()->write($payload);
          return $response
            ->withHeader('Content-Type', 'application/json');
        }
      }else{
        $payload = json_encode(array("mensaje" => "El id debe ser numerico"));  
        $response->getBody()->write($payload);
        return $response
          ->withHeader('Content-Type', 'application/json');
      }
    }

    public function validarLogin($request, $response, $args){
     
      $parametros = $request->getParsedBody();
      $nombre = $parametros['nombre'];
      $clave = $parametros['clave'];
      $perfil = $parametros['perfil'];

     $usuario = Usuario::obtenerUsuario($nombre);  
     
     $payload = json_encode(array("mensaje" => "Usuario incorrecto!"));

     if($usuario){
       if(password_verify($clave, $usuario->clave)){
          if(strcasecmp($perfil, $usuario->perfil) == 0){
            $payload = json_encode(array("Respuesta" => "Bienvenido", "Token" => $this->crearToken($request)));

          }else{
            $payload = json_encode(array("mensaje" => "Perfil incorrecto"));
          }
       }else{
         $payload = json_encode(array("mensaje" => "Clave incorrecta"));
       }
     }

      $response->getBody()->write($payload);
      return $response
        ->withHeader('Content-Type', 'application/json');
    }

    public function BorrarUno($request, $response, $args)
    {
        $usuarioId = $args["id"];

        if(is_numeric($usuarioId)){
          if(Usuario::borrarUsuario($usuarioId)){
  
            $payload = json_encode(array("mensaje" => "Usuario borrado con exito"));
    
            $response->getBody()->write($payload);
            return $response
              ->withHeader('Content-Type', 'application/json');
          }else{
            $payload = json_encode(array("mensaje" => "No se ha encontrado al usuario para borrar."));
    
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

    public function ValidarUsuario($request, $response, $args){

      $parametros = $request->getParsedBody();
      $nombre = $parametros['usuario'];
      $clave = $parametros['clave'];

      $usuario = Usuario::obtenerUsuario($nombre);

      $payload = json_encode(array("mensaje" => "Usuario incorrecto!"));

      if($usuario){
        if(password_verify($clave, $usuario->clave)){
          $payload = json_encode(array("mensaje" => "Bienvenido!"));
        }else{
          $payload = json_encode(array("mensaje" => "Clave incorrecta"));
        }
      }

      $response->getBody()->write($payload);
      return $response
        ->withHeader('Content-Type', 'application/json');
    }   
}
