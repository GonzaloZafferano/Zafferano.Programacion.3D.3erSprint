<?php

class Archivo
{
    public static function Guardar($ruta, $array, callable $callback)
    {
        if (isset($ruta) && isset($array) && isset($callback)) {
            $archivo = null;
            try {
                $file = fopen($ruta, "w");
                if (isset($file)) {
                    foreach ($array as $item) {
                        $data = $callback($item);

                        fputs($file, $data);
                    }
                    return true;
                }
            } catch (Exception $ex) {
                echo "Ha ocurrido un error: " . $ex->getMessage();
            } finally {
                if (isset($archivo)) {
                    fclose($archivo);
                }
            }
        }
        return false;
    }

    public static function Leer($ruta, callable $callback)
    {
        $archivo = null;
        $lista = array();

        if (isset($ruta) && !empty($ruta) && isset($callback)) {
            try {
                $archivo = fopen($ruta, "r");

                while (!feof($archivo)) {
                    $linea = fgets($archivo);

                    if ($linea && !empty($linea)) {
                        $linea = str_replace(PHP_EOL, "", $linea);
                        $datos = explode(",", $linea);
                        $item = $callback($datos);
                        array_push($lista, $item);
                    }
                }
            } catch (Exception $ex) {
                echo "Ha ocurrido un error: " . $ex->getMessage();
            } finally {
                if (isset($archivo)) {
                    fclose($archivo);
                }
            }
        }
        return $lista;
    }

    public static function AgregarItem($ruta, $item, callable $callback)
    {
        $archivo = null;
        if (isset($item) && isset($ruta) && !empty($ruta) && isset($callback)) {
            try {
                $archivo = fopen($ruta, "a+");
                $itemSerializado = $callback($item);

                if (isset($archivo) && isset($itemSerializado) && !empty($itemSerializado)) {
                    if (fputs($archivo, $itemSerializado)) {
                        return true;
                    }
                }
            } catch (Exception $ex) {
                echo "Ha ocurrido un error: " . $ex->getMessage();
            } finally {
                if (isset($archivo)) {
                    fclose($archivo);
                }
            }
        }
        return false;
    }
}
