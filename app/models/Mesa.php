<?php

class Mesa
{
    public $mesaId;
    public $estado;
    public $activo;
    public $codigoMesa;

    public function crearMesa()
    {
        $objAccesoDatos = AccesoDatos::obtenerInstancia();

        $consulta = $objAccesoDatos->prepararConsulta("INSERT INTO mesas (estado, codigoMesa, activo)
         VALUES (:estado, :codigoMesa, :activo)");

       
        $alfanumerico = substr(md5(time()), 0, 5);

        $consulta->bindValue(':estado', $this->estado, PDO::PARAM_STR);
        $consulta->bindValue(':codigoMesa', $alfanumerico, PDO::PARAM_STR);
        $consulta->bindValue(':activo', true, PDO::PARAM_BOOL);
        $consulta->execute();

        return $objAccesoDatos->obtenerUltimoId();
    }

    public static function obtenerTodos()
    {
        $objAccesoDatos = AccesoDatos::obtenerInstancia();
        $consulta = $objAccesoDatos->prepararConsulta("SELECT mesaId, estado, codigoMesa, activo FROM mesas
        where activo != false");
        $consulta->execute();

        return $consulta->fetchAll(PDO::FETCH_CLASS, 'Mesa');
    }

    public static function obtenerEstadosDeMesas()
    {
        $objAccesoDatos = AccesoDatos::obtenerInstancia();
        $consulta = $objAccesoDatos->prepararConsulta("SELECT mesaId, estado FROM mesas
        where activo != false");
        $consulta->execute();

        return $consulta->fetchAll(PDO::FETCH_CLASS);
    }

    public static function obtenerMesa($mesaId)
    {
        $objAccesoDatos = AccesoDatos::obtenerInstancia();
        $consulta = $objAccesoDatos->prepararConsulta("SELECT mesaId, estado, activo, codigoMesa 
        FROM mesas WHERE mesaId = :mesaId and activo = true");
      
        $consulta->bindValue(':mesaId', $mesaId, PDO::PARAM_INT);
        $consulta->execute();

        return $consulta->fetchObject('Mesa');
    }

    public static function modificarEstadoMesa($estado, $mesaId){
        try{
            if(isset($estado) && isset($mesaId)){
     
                $objAccesoDato = AccesoDatos::obtenerInstancia();

                $consulta = $objAccesoDato->prepararConsulta("UPDATE mesas
                 SET estado = :estado WHERE mesaId = :mesaId");
               
                $consulta->bindValue(':estado', $estado, PDO::PARAM_STR);
                $consulta->bindValue(':mesaId', $mesaId, PDO::PARAM_INT);

                $consulta->execute();
    
                return true;
            }
        }catch(Exception $ex){
            echo "Excepcion: " . $ex->getMessage();
        }
        return false;
    }


    public static function modificarMesa($mesa)
    {
        try{
            if(isset($mesa)){
     
                $objAccesoDato = AccesoDatos::obtenerInstancia();

                $consulta = $objAccesoDato->prepararConsulta("UPDATE mesas
                 SET estado = :estado WHERE mesaId = :mesaId");
               
                $consulta->bindValue(':estado', $mesa->estado, PDO::PARAM_STR);
                $consulta->bindValue(':mesaId', $mesa->mesaId, PDO::PARAM_STR);

                $consulta->execute();
    
                return true;
            }
        }catch(Exception $ex){
            echo "Excepcion: " . $ex->getMessage();
        }
        return false;
    }

    public static function borrarMesa($mesaId)
    {
        try{
            if(Mesa::obtenerMesaPorId($mesaId)){            
                $objAccesoDato = AccesoDatos::obtenerInstancia();

                $consulta = $objAccesoDato->prepararConsulta("UPDATE mesas
                 SET activo = false WHERE mesaId = :mesaId and activo != false");
               
                $consulta->bindValue(':mesaId', $mesaId, PDO::PARAM_INT);

                $consulta->execute();
                
                return true;             
            }
        }catch(Exception $ex){
            echo "Excepcion: " . $ex->getMessage();
        }
        return false;
    }

    public static function obtenerMesaPorId($mesaId)
    {
        $objAccesoDatos = AccesoDatos::obtenerInstancia();
       
        $consulta = $objAccesoDatos->prepararConsulta("SELECT estado, activo, codigoMesa, mesaId FROM mesas
         WHERE mesaId = :mesaId AND activo = true");

        $consulta->bindValue(':mesaId', $mesaId, PDO::PARAM_INT);
       
        $consulta->execute();

        return $consulta->fetchObject('Mesa');
    }


    public static function obtenerMesaPorCodigo($codigo)
    {
        $objAccesoDatos = AccesoDatos::obtenerInstancia();
       
        $consulta = $objAccesoDatos->prepararConsulta("SELECT estado, activo, codigoMesa, mesaId FROM mesas
         WHERE codigoMesa = :codigo");

        $consulta->bindValue(':codigo', $codigo, PDO::PARAM_STR);
       
        $consulta->execute();

        return $consulta->fetchObject('Mesa');
    }

    public static function MesaMasUsada(){
        $objAccesoDatos = AccesoDatos::obtenerInstancia();
       
        $consulta = $objAccesoDatos->prepararConsulta("SELECT mesas.codigoMesa, 
        m.cantidadUsos, m.idMesa FROM mesas INNER JOIN (SELECT * FROM 
        (SELECT COUNT(*) as cantidadUsos, pedidos.mesaId as idMesa 
              FROM pedidos GROUP BY pedidos.mesaId) 
        as maximo WHERE maximo.cantidadUsos = (SELECT MAX(m.maximo) 
        FROM (SELECT COUNT(*) as maximo FROM pedidos GROUP BY
         pedidos.mesaId) as m)) as m on mesas.mesaId = m.idMesa");       
       
        $consulta->execute();

        return $consulta->fetchObject();
    }
}