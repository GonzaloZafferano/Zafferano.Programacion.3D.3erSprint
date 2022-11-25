<?php

class Pedido
{
    public $pedidoId;
    public $codigoAlfanumerico;
    public $nombreCliente;
    public $mesaId;
    public $estado;
    public $fotoUrl;
    public $tiempoPreparacion;
    public $mozoId;

    public function crearPedido()
    {
        $objAccesoDatos = AccesoDatos::obtenerInstancia();

        $consulta = $objAccesoDatos->prepararConsulta("INSERT INTO pedidos
        (codigoAlfanumerico, nombreCliente, mesaId, estado,  mozoId, fotoUrl)
        VALUES (:codigoAlfanumerico, :nombreCliente, :mesaId, :estado, :mozoId, :fotoUrl)");

        $consulta->bindValue(':codigoAlfanumerico', $this->codigoAlfanumerico, PDO::PARAM_STR);
        $consulta->bindValue(':nombreCliente', $this->nombreCliente, PDO::PARAM_STR);
        $consulta->bindValue(':mesaId', $this->mesaId, PDO::PARAM_INT);
        $consulta->bindValue(':mozoId', $this->mozoId, PDO::PARAM_INT);
        $consulta->bindValue(':estado', $this->estado, PDO::PARAM_STR); 
        $consulta->bindValue(':fotoUrl', $this->fotoUrl, PDO::PARAM_STR); 

        $consulta->execute();

        return $objAccesoDatos->obtenerUltimoId();
    }

    public static function obtenerTodos()
    {
        $objAccesoDatos = AccesoDatos::obtenerInstancia();
 
        $consulta = $objAccesoDatos->prepararConsulta("SELECT pedidoId, 
        codigoAlfanumerico, nombreCliente, tiempoPreparacion, mesaId,mozoId, fotoUrl,
        estado FROM pedidos where estado != 'cancelado'");

        $consulta->execute();

        return $consulta->fetchAll(PDO::FETCH_CLASS, 'Pedido');
    }

    public static function obtenerPedido($codigoAlfanumerico)
    {
        $objAccesoDatos = AccesoDatos::obtenerInstancia();
        $consulta = $objAccesoDatos->prepararConsulta("SELECT *
        FROM pedidos WHERE codigoAlfanumerico = :codigoAlfanumerico and estado != 'cancelado'");
      
        $consulta->bindValue(':codigoAlfanumerico', $codigoAlfanumerico, PDO::PARAM_STR);
        $consulta->execute();

        return $consulta->fetchObject('Pedido');
    }

    public static function modificarPedido($pedido)
    {
        try{
            if(isset($pedido)){
     
                $objAccesoDato = AccesoDatos::obtenerInstancia();

                $consulta = $objAccesoDato->prepararConsulta("UPDATE pedidos
                 SET estado = :estado WHERE pedidoId = :pedidoId");
               
                $consulta->bindValue(':estado', $pedido->estado, PDO::PARAM_STR);
                $consulta->bindValue(':pedidoId', $pedido->pedidoId, PDO::PARAM_STR);

                $consulta->execute();
    
                return true;
            }
        }catch(Exception $ex){
            echo "Excepcion: " . $ex->getMessage();
        }
        return false;
    }

    public static function asignarFotoPedido($pedido)
    {
        try{
            if(isset($pedido)){
     
                $objAccesoDato = AccesoDatos::obtenerInstancia();

                $consulta = $objAccesoDato->prepararConsulta("UPDATE pedidos
                 SET fotoUrl = :fotoUrl WHERE pedidoId = :pedidoId");
               
                $consulta->bindValue(':fotoUrl', $pedido->fotoUrl, PDO::PARAM_STR);
                $consulta->bindValue(':pedidoId', $pedido->pedidoId, PDO::PARAM_STR);

                $consulta->execute();
    
                return true;
            }
        }catch(Exception $ex){
            echo "Excepcion: " . $ex->getMessage();
        }
        return false;
    }


    public static function actualizarTiempoDePedido($pedido)
    {
        try{
            if(isset($pedido)){
     
                $objAccesoDato = AccesoDatos::obtenerInstancia();

                $consulta = $objAccesoDato->prepararConsulta("UPDATE pedidos
                 SET estado = :estado, tiempoPreparacion = :tiempoPreparacion WHERE pedidoId = :pedidoId");
               
                $consulta->bindValue(':estado', $pedido->estado, PDO::PARAM_STR);
                $consulta->bindValue(':pedidoId', $pedido->pedidoId, PDO::PARAM_STR);
                $consulta->bindValue(':tiempoPreparacion', $pedido->tiempoPreparacion, PDO::PARAM_INT);

                $consulta->execute();
    
                return true;
            }
        }catch(Exception $ex){
            echo "Excepcion: " . $ex->getMessage();
        }
        return false;
    }

    public static function borrarPedido($pedidoId)
    {
        try{
            if(Pedido::obtenerPedidoPorId($pedidoId)){            
                $objAccesoDato = AccesoDatos::obtenerInstancia();

                $consulta = $objAccesoDato->prepararConsulta("UPDATE pedidos
                 SET estado = 'cancelado' WHERE pedidoId = :pedidoId and estado != 'cancelado'");
               
                $consulta->bindValue(':pedidoId', $pedidoId, PDO::PARAM_INT);

                $consulta->execute();
                
                return true;             
            }
        }catch(Exception $ex){
            echo "Excepcion: " . $ex->getMessage();
        }
        return false;
    }

    public static function obtenerPedidoPorId($pedidoId)
    {
        $objAccesoDatos = AccesoDatos::obtenerInstancia();
       
        $consulta = $objAccesoDatos->prepararConsulta("SELECT * FROM pedidos
         WHERE pedidoId = :pedidoId AND estado != 'cancelado'");

        $consulta->bindValue(':pedidoId', $pedidoId, PDO::PARAM_INT);
       
        $consulta->execute();

        return $consulta->fetchObject('Pedido');
    }

    public static function obtenerPedidoPorCodigo($codigo)
    {
        $objAccesoDatos = AccesoDatos::obtenerInstancia();
       
        $consulta = $objAccesoDatos->prepararConsulta("SELECT * FROM pedidos
         WHERE codigoAlfanumerico = :codigo");

        $consulta->bindValue(':codigo', $codigo, PDO::PARAM_STR);
       
        $consulta->execute();

        return $consulta->fetchObject('Pedido');
    }
    
    public static function obtenerPedidoParaCobrar($mesaId)
    {
        $objAccesoDatos = AccesoDatos::obtenerInstancia();       
        $consulta = $objAccesoDatos->prepararConsulta("SELECT * FROM pedidos
         WHERE mesaId = :mesaId AND estado = 'listo para servir' or estado = 'entregado'");
        $consulta->bindValue(':mesaId', $mesaId, PDO::PARAM_INT);
       
        $consulta->execute();

        return $consulta->fetchObject('Pedido');
    }
}