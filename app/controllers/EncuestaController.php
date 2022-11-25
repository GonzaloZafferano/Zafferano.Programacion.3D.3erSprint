<?php
require_once './models/Encuesta.php';
require_once './interfaces/IApiUsable.php';
require_once "./utils/AutentificatorJWT.php";
require_once './controllers/LogController.php';


class EncuestaController extends Encuesta 
{
    public function CargarUno($request, $response, $args)
    {
        $parametros = $request->getParsedBody();

        $puntuacionMesa = $parametros['puntuacionMesa'];
        $puntuacionMozo = $parametros['puntuacionMozo'];
        $puntuacionCocinero = $parametros['puntuacionCocinero'];
        $puntuacionRestaurante = $parametros['puntuacionRestaurante'];
        $comentarios = $parametros['comentarios'];
        $codigoAlfanumerico = $parametros['codigoAlfanumerico'];

        $pedido = PedidoController::obtenerPedidoPorCodigo($codigoAlfanumerico);

        if($pedido){
          $detalles = DetallesPedidoController::obtenerDetallesPorCodigoDePedido($codigoAlfanumerico);
          $idCocinero = 0;

          foreach($detalles as $detalle){
            if(strcasecmp($detalle->perfil, "cocinero") == 0){
              $idCocinero = $detalle->empleadoId;
              break;
            }
          }
          
          $encuesta = new Encuesta();
          $encuesta->mesaId = $pedido->mesaId;
          $encuesta->mozoId = $pedido->mozoId;
          $encuesta->cocineroId = $idCocinero;
          $encuesta->puntuacionMesa = $puntuacionMesa;
          $encuesta->puntuacionMozo = $puntuacionMozo;
          $encuesta->puntuacionCocinero = $puntuacionCocinero;
          $encuesta->puntuacionRestaurante = $puntuacionRestaurante;
          $encuesta->comentarios = $comentarios;
          $encuesta->crearEncuesta();
  
          $payload = json_encode(array("mensaje" => "Comentario guardado con exito."));
        }else{
          $payload = json_encode(array("Error" => "No se encontro el pedido."));
        }    

        $response->getBody()->write($payload);
        return $response
          ->withHeader('Content-Type', 'application/json');
    }
      
    public function TraerTodos($request, $response, $args)
    {
    LogController::CargarUno($request, "Socio pide todos los comentarios");

        $lista = Encuesta::obtenerTodos();
        $payload = json_encode(array("Todos los Comentarios" => $lista));

        $response->getBody()->write($payload);
        return $response
          ->withHeader('Content-Type', 'application/json');
    }

    public function TraerMejoresComentarios($request, $response, $args)
    {
    LogController::CargarUno($request, "Socio pide mejores comentarios");

        $lista = Encuesta::obtenerMejoresComentarios();
        $payload = json_encode(array("Mejores Comentarios" => $lista));

        $response->getBody()->write($payload);
        return $response
          ->withHeader('Content-Type', 'application/json');
    }    
}
