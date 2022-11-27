<?php
require_once './models/Producto.php';
require_once './interfaces/IApiUsable.php';
require_once "./utils/Archivo.php";
require_once './controllers/LogController.php';


class ProductoController extends Producto
{
  public function CargarUno($request, $response, $args)
  {
    $parametros = $request->getParsedBody();

    $nombre = $parametros['nombre'];
    $precio = $parametros['precio'];
    $perfil = $parametros['perfil'];

    $producto = new Producto();
    $producto->nombre = $nombre;
    $producto->precio = $precio;
    $producto->perfil = $perfil;

    $producto->crearProducto();

    $payload = json_encode(array("mensaje" => "Producto creado con exito"));

    $response->getBody()->write($payload);
    return $response
      ->withHeader('Content-Type', 'application/json');
  }

  public function TraerUno($request, $response, $args)
  {
    $nombre = $args['nombre'];
    $producto = Producto::obtenerProducto($nombre);

    if ($producto) {
      $payload = json_encode($producto);

      $response->getBody()->write($payload);
      return $response
        ->withHeader('Content-Type', 'application/json');
    } else {
      $payload = json_encode(array("mensaje" => "No se encontro al producto: " . $nombre));

      $response->getBody()->write($payload);
      return $response
        ->withHeader('Content-Type', 'application/json');
    }
  }

  public function TraerTodos($request, $response, $args)
  {
    $lista = Producto::obtenerTodos();
    $payload = json_encode(array("listaProductos" => $lista));

    $response->getBody()->write($payload);
    return $response
      ->withHeader('Content-Type', 'application/json');
  }

  public function ModificarUno($request, $response, $args)
  {
    $parametros = $request->getParsedBody();

    $productoId = $args["id"];

    if (is_numeric($productoId)) {

      $producto = Producto::obtenerProductoPorId($productoId);

      if ($producto) {
        $producto->precio = $parametros['precio'];

        if (Producto::modificarProducto($producto)) {

          $payload = json_encode(array("mensaje" => "Producto modificado con exito"));

          $response->getBody()->write($payload);
          return $response
            ->withHeader('Content-Type', 'application/json');
        } else {
          $payload = json_encode(array("mensaje" => "No se ha podido modificar el producto. Revise que los datos enviados sean correctos."));
          $response->getBody()->write($payload);
          return $response
            ->withHeader('Content-Type', 'application/json');
        }
      } else {
        $payload = json_encode(array("mensaje" => "No se ha encontrado al producto de id: " . $productoId));
        $response->getBody()->write($payload);
        return $response
          ->withHeader('Content-Type', 'application/json');
      }
    } else {
      $payload = json_encode(array("mensaje" => "El id debe ser numerico."));

      $response->getBody()->write($payload);
      return $response
        ->withHeader('Content-Type', 'application/json');
    }
  }

  public function BorrarUno($request, $response, $args)
  {
    $productoId = $args["id"];

    if (is_numeric($productoId)) {
      if (Producto::borrarProducto($productoId)) {

        $payload = json_encode(array("mensaje" => "Producto borrado con exito"));

        $response->getBody()->write($payload);
        return $response
          ->withHeader('Content-Type', 'application/json');
      } else {
        $payload = json_encode(array("mensaje" => "No se ha encontrado al producto para borrar."));

        $response->getBody()->write($payload);
        return $response
          ->withHeader('Content-Type', 'application/json');
      }
    } else {
      $payload = json_encode(array("mensaje" => "El id debe ser numerico."));

      $response->getBody()->write($payload);
      return $response
        ->withHeader('Content-Type', 'application/json');
    }
  }

  public function GenerarArchivoCSV($request, $response, $args)
  {
    try {
      $productos = Producto::obtenerTodos();

      $filename = "productos.csv";
      header('Content-Type: application/csv');
      header("Content-Disposition: attachment;filename=$filename");

      Archivo::Guardar("php://output", $productos, function ($item) {
        return "$item->productoId,$item->nombre,$item->precio,$item->activo,$item->perfil" . PHP_EOL;
      });
    } catch (Exception $ex) {
      echo "Ha ocurrido un error: " . $ex->getMessage();
    }

    return $response
      ->withHeader('Content-Type', 'application/json');
  }

  public function LeerArchivoCSV($request, $response, $args)
  {
    try {
      $uploadedFiles = $request->getUploadedFiles();
      $tempFile = $uploadedFiles['archivo']->getFilePath();
      $nombreArchivo = $uploadedFiles['archivo']->getClientFilename();

      $productosBBDD = Producto::obtenerTodos();

      $productosCVS = Archivo::Leer($tempFile, function ($datos) {
        $producto = new Producto();
        $producto->productoId = $datos[0];
        $producto->nombre = $datos[1];
        $producto->precio = $datos[2];
        $producto->activo = $datos[3];
        $producto->perfil = $datos[4];
        return $producto;
      });

      foreach ($productosCVS as $productoCSV) {
        $existe = false;

        foreach ($productosBBDD as $productoBBDD) {
          if ($productoBBDD->productoId == $productoCSV->productoId) {

            $existe = true;
            break;
          }
        }

        if ($existe == true) {
          Producto::modificarProductoCompleto($productoCSV);
        } else {
          $productoCSV->crearProductoConId();
        }
      }
      LogController::CargarUno($request, "Socio actualiza BBDD con archivo csv.");

      $payload = json_encode(array("mensaje" => "Base de datos actualizada correctamente."));
    } catch (Exception $ex) {
      $payload = json_encode(array("mensaje" => "Ha ocurrido un error al intentar leer el archivo: " . $nombreArchivo . " - " . $ex->getMessage()));
    }

    $response->getBody()->write($payload);
    return $response
      ->withHeader('Content-Type', 'application/json');
  }
}
