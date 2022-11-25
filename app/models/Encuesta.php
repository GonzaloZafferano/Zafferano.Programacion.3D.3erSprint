<?php

class Encuesta
{
    public $comentarioId;
    public $mesaId;
    public $puntuacionMesa;
    public $mozoId;
    public $puntuacionMozo;
    public $cocineroId;
    public $puntuacionCocinero;
    public $puntuacionRestaurante;
    public $comentarios;

    public function crearEncuesta()
    {    
        $objAccesoDatos = AccesoDatos::obtenerInstancia();
        $consulta = $objAccesoDatos->prepararConsulta("INSERT INTO comentarios 
        (mesaId, puntuacionMesa, mozoId, puntuacionMozo, cocineroId,
        puntuacionCocinero , puntuacionRestaurante,comentarios )
         VALUES 
         (:mesaId, :puntuacionMesa, :mozoId, :puntuacionMozo, :cocineroId, 
         :puntuacionCocinero , :puntuacionRestaurante ,:comentarios)");

        $consulta->bindValue(':mesaId', $this->mesaId, PDO::PARAM_INT);
        $consulta->bindValue(':puntuacionMesa', $this->puntuacionMesa, PDO::PARAM_INT);
        $consulta->bindValue(':mozoId', $this->mozoId, PDO::PARAM_INT);
        $consulta->bindValue(':puntuacionMozo', $this->puntuacionMozo, PDO::PARAM_INT);
        $consulta->bindValue(':cocineroId', $this->cocineroId, PDO::PARAM_INT);
        $consulta->bindValue(':puntuacionCocinero', $this->puntuacionCocinero, PDO::PARAM_INT);
        $consulta->bindValue(':puntuacionRestaurante', $this->puntuacionRestaurante, PDO::PARAM_INT);
        $consulta->bindValue(':comentarios', $this->comentarios, PDO::PARAM_STR);

        $consulta->execute();

        return $objAccesoDatos->obtenerUltimoId();
    }

    public static function obtenerTodos()
    {
        $objAccesoDatos = AccesoDatos::obtenerInstancia();
        $consulta = $objAccesoDatos->prepararConsulta("SELECT * FROM comentarios");
        $consulta->execute();

        return $consulta->fetchAll(PDO::FETCH_CLASS, 'Encuesta');
    }

    public static function obtenerMejoresComentarios()
    {
        $objAccesoDatos = AccesoDatos::obtenerInstancia();
        $consulta = $objAccesoDatos->prepararConsulta("SELECT * FROM comentarios
         where puntuacionMesa >= 7 and puntuacionCocinero >= 7 
         and puntuacionRestaurante  >= 7 and puntuacionMozo >= 7");
        $consulta->execute();

        return $consulta->fetchAll(PDO::FETCH_CLASS, 'Encuesta');
    }
}