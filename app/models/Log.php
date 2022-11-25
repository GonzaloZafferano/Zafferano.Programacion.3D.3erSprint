<?php

class Log
{
    public $idLog;
    public $idUsuario;
    public $fecha;
    public $accion;

    public function crearLog()
    {
        $objAccesoDatos = AccesoDatos::obtenerInstancia();
        $consulta = $objAccesoDatos->prepararConsulta("INSERT INTO logs
         (idUsuario, fecha, accion)
         VALUES (:idUsuario, :fecha, :accion)");

        $consulta->bindValue(':idUsuario', $this->idUsuario, PDO::PARAM_INT);
        $consulta->bindValue(':accion', $this->accion, PDO::PARAM_STR);    

        date_default_timezone_set('America/Argentina/Buenos_Aires');

        $fecha = date('d-m-y h:i:s');
        $consulta->bindValue(':fecha', $fecha, PDO::PARAM_STR);

        $consulta->execute();

        return $objAccesoDatos->obtenerUltimoId();
    }

    public static function obtenerTodos()
    {
        $objAccesoDatos = AccesoDatos::obtenerInstancia();
        $consulta = $objAccesoDatos->prepararConsulta("SELECT * FROM logs");
        $consulta->execute();

        return $consulta->fetchAll(PDO::FETCH_CLASS, 'Log');
    }    
}