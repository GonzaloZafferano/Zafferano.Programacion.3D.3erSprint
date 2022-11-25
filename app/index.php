<?php
//Zafferano Gonzalo
// Error Handling
error_reporting(-1);
ini_set('display_errors', 1);

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Server\RequestHandlerInterface;
use Slim\Factory\AppFactory;
use Slim\Routing\RouteCollectorProxy;
use Slim\Routing\RouteContext;

require __DIR__ . '/../vendor/autoload.php';

//SI O SI
require_once './db/AccesoDatos.php';
require_once './controllers/UsuarioController.php';
require_once './controllers/ProductoController.php';
require_once './controllers/MesaController.php';
require_once './controllers/EncuestaController.php';
require_once './controllers/PedidoController.php';
require_once './controllers/LogController.php';

require_once './middlewares/ValidarCamposUsuario.php';
require_once './middlewares/ValidarBartender.php';
require_once './middlewares/ValidarCervecero.php';
require_once './middlewares/ValidarMozo.php';
require_once './middlewares/ValidarSocio.php';
require_once './middlewares/ValidarUsuario.php';
require_once './middlewares/ValidarCocinero.php';
require_once './middlewares/ValidarCamposLogin.php';
require_once './middlewares/ValidarEstadosDeMesa.php';
require_once './middlewares/ValidarCamposPedido.php';
require_once './middlewares/ValidarMozoOSocio.php';
require_once './middlewares/ValidarProducto.php';
require_once './middlewares/ValidarFoto.php';
require_once './middlewares/ValidarCamposEncuesta.php';
require_once './middlewares/ValidarArchivoCSV.php';

// Load ENV
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
$dotenv->safeLoad();

// Instantiate App
$app = AppFactory::create();

//http://localhost:666/app es el LINK BASE
$app->setBasePath('/app');  //AGREGO ESTA LINEA.

// Add error middleware
$app->addErrorMiddleware(true, true, true);

// Add parse body
$app->addBodyParsingMiddleware();


$app->group('/usuarios', function (RouteCollectorProxy $group) {
    $group->post('/agregar[/]',  \UsuarioController::class . ':CargarUno')->add(new ValidarCamposUsuario());
    $group->get('[/]',  \UsuarioController::class . ':TraerTodos')->add(new ValidarSocio());
    $group->put('/{id}[/]',  \UsuarioController::class . ':ModificarUno')->add(new ValidarCamposUsuario());
    $group->delete('/{id}[/]',  \UsuarioController::class . ':BorrarUno')->add(new ValidarSocio());
    $group->post('/login[/]',  \UsuarioController::class . ':validarLogin')->add(new ValidarCamposLogin());
  });

  $app->group('/productos', function (RouteCollectorProxy $group) {
    $group->post('/agregar[/]',  \ProductoController::class . ':CargarUno')->add(new ValidarProducto());
    $group->get('[/]',  \ProductoController::class . ':TraerTodos');
    $group->put('/{id}[/]',  \ProductoController::class . ':ModificarUno');
    $group->delete('/{id}[/]',  \ProductoController::class . ':BorrarUno');  
    $group->post('/descargar[/]',  \ProductoController::class . ':GenerarArchivoCSV');  
    $group->post('/archivo[/]',  \ProductoController::class . ':LeerArchivoCSV')->add(new ValidarArchivoCSV());
  })->add(new ValidarSocio());

  $app->group('/mesas', function (RouteCollectorProxy $group) {
    $group->post('/agregar[/]',  \MesaController::class . ':CargarUno')->add(new ValidarSocio());
    $group->get('/mesaMasUsada[/]',  \MesaController::class . ':TraerMesaMasUsada')->add(new ValidarSocio());
    $group->get('[/]',  \MesaController::class . ':TraerTodos')->add(new ValidarSocio());
    $group->get('/estados[/]',  \MesaController::class . ':TraerEstadosDeMesas')->add(new ValidarSocio());
    $group->put('/cerrarMesa/{id}[/]',  \MesaController::class . ':cerrarMesa')->add(new ValidarSocio());
    $group->delete('/{id}[/]',  \MesaController::class . ':BorrarUno')->add(new ValidarSocio());
    $group->get('/cobrar/{id}[/]',  \MesaController::class . ':cobrarMesa')->add(new ValidarMozo());
    $group->put('/{id}[/]',  \MesaController::class . ':ModificarUno')->add(new ValidarEstadosDeMesa())->add(new ValidarMozo());
  });

  $app->group('/pedidos', function (RouteCollectorProxy $group) {
    $group->post('/agregar[/]',  \PedidoController::class . ':CargarUno')->add(new ValidarCamposPedido())->add(new ValidarMozo());
    $group->get('[/]',  \PedidoController::class . ':TraerTodos')->add(new ValidarMozoOSocio());
    $group->put('/{id}[/]',  \PedidoController::class . ':ModificarUno')->add(new ValidarMozo());
    $group->delete('/{id}[/]',  \PedidoController::class . ':BorrarUno')->add(new ValidarMozo());
    $group->get('/tiempoYEstado[/]',  \PedidoController::class . ':verEstadoYTiempoDeEsperaDePedidos')->add(new ValidarSocio());
    $group->get('/listos[/]',  \PedidoController::class . ':verificarListoParaServir')->add(new ValidarMozo());
    $group->get('/verTiempoPedido[/]',  \PedidoController::class . ':tiempoRestanteDePedidoCliente')->add(new ValidarCamposPedido());
    $group->post('/foto/{codigoAlfanumerico}[/]',  \PedidoController::class . ':asignarFotoAlPedido')->add(new ValidarFoto())->add(new ValidarMozo());
  });

  $app->group('/detallesPedidos', function (RouteCollectorProxy $group) {
    $group->post('/levantarCervecero[/]',  \DetallesPedidoController::class . ':LevantarPedidosCervecero')->add(new ValidarCervecero());
    $group->post('/levantarBartender[/]',  \DetallesPedidoController::class . ':LevantarPedidosBartender')->add(new ValidarBartender());
    $group->post('/levantarCocinero[/]',  \DetallesPedidoController::class . ':LevantarPedidosCocinero')->add(new ValidarCocinero());      
    $group->get('/pendientesCervecero[/]',  \DetallesPedidoController::class . ':VerPendientesCervecero')->add(new ValidarCervecero());
    $group->get('/pendientesBartender[/]',  \DetallesPedidoController::class . ':VerPendientesBartender')->add(new ValidarBartender());
    $group->get('/pendientesCocinero[/]',  \DetallesPedidoController::class . ':VerPendientesCocinero')->add(new ValidarCocinero()); 
    $group->post('/listosCervecero[/]',  \DetallesPedidoController::class . ':ListoParaServirCervecero')->add(new ValidarCervecero());
    $group->post('/listosBartender[/]',  \DetallesPedidoController::class . ':ListoParaServirBartender')->add(new ValidarBartender());
    $group->post('/listosCocinero[/]',  \DetallesPedidoController::class . ':ListoParaServirCocinero')->add(new ValidarCocinero());  
  });


  $app->group('/encuesta', function (RouteCollectorProxy $group) {
    $group->post('/agregar[/]',  \EncuestaController::class . ':CargarUno')->add(new ValidarCamposEncuesta());
    $group->get('[/]',  \EncuestaController::class . ':TraerTodos')->add(new ValidarSocio()); 
    $group->get('/mejoresComentarios[/]',  \EncuestaController::class . ':TraerMejoresComentarios')->add(new ValidarSocio()); 
  });

  $app->group('/logs', function (RouteCollectorProxy $group) {
    $group->get('[/]',  \LogController::class . ':TraerTodos')->add(new ValidarSocio()); 
  });

$app->get('[/]', function (Request $request, Response $response) {    
    $response->getBody()->write("Aplicacion funcionando correctamente.");
    return $response;
});

$app->run();
