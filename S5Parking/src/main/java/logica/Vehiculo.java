/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package logica;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import persistencia.ConexionBD;

/**
 *
 * @author FERNANDO
 */
public class Vehiculo {
    
    private String placa;
   
    
     public Vehiculo() {
    }

    public Vehiculo getVehiculo(String placa) throws SQLException {
        this.placa = placa;
        return this.getVehiculo();
    }

    public String getPlaca() {
        return placa;
    }

    public void setPlaca(String placa) {
        this.placa = placa;
    }

    
    
    public void llenarVehiculo(String placa) {
        this.placa = placa;
      
    }
    
    public boolean guardarVehiculo() {
        System.out.println("bien");
        ConexionBD conexion = new ConexionBD();
        String sentencia = "INSERT INTO vehiculo(no_placa)"
                + " VALUES ( '" + this.placa + "'); ";
        if (conexion.setAutoCommitBD(false)) {
            if (conexion.insertarBD(sentencia)) {
                conexion.commitBD();
                conexion.cerrarConexion();
                return true;
            } else {
                conexion.rollbackBD();
                conexion.cerrarConexion();
                return false;
            }
        } else {
            conexion.cerrarConexion();
            return false;
        }
    }
    
     public boolean borrarVehiculo(String placa) {
        String Sentencia = "DELETE FROM `vehiculo` WHERE `no_placa`='" + placa + "'";
        ConexionBD conexion = new ConexionBD();
        if (conexion.setAutoCommitBD(false)) {
            if (conexion.actualizarBD(Sentencia)) {
                conexion.commitBD();
                conexion.cerrarConexion();
                return true;
            } else {
                conexion.rollbackBD();
                conexion.cerrarConexion();
                return false;
            }
        } else {
            conexion.cerrarConexion();
            return false;
        }
    }
     
     public boolean actualizarVehiculo() {
        ConexionBD conexion = new ConexionBD();
        String Sentencia = "UPDATE `vehiculo` SET no_placa='" + this.placa + "' WHERE no_placa=" + this.placa + ";";
        if (conexion.setAutoCommitBD(false)) {
            if (conexion.actualizarBD(Sentencia)) {
                conexion.commitBD();
                conexion.cerrarConexion();
                return true;
            } else {
                conexion.rollbackBD();
                conexion.cerrarConexion();
                return false;
            }
        } else {
            conexion.cerrarConexion();
            return false;
        }
    }
     
      public List<Vehiculo> listarVehiculos() throws SQLException {
        ConexionBD conexion = new ConexionBD();
        List<Vehiculo> listaVehiculos = new ArrayList<>();
        String sql = "select * from vehiculo order by no_placa asc";
        ResultSet rs = conexion.consultarBD(sql);
        Vehiculo v;
        while (rs.next()) {
            v = new Vehiculo();
            v.setPlaca(rs.getString("no_placa"));
         
            listaVehiculos.add(v);

        }
        conexion.cerrarConexion();
        return listaVehiculos;
    }
      
       public Vehiculo getVehiculo() throws SQLException {
        ConexionBD conexion = new ConexionBD();
        String sql = "select * from vehiculo where no_placa='" + this.placa + "'";
        ResultSet rs = conexion.consultarBD(sql);
        if (rs.next()) {
            this.placa = rs.getString("no_placa");
          
            return this;

        } else {
            conexion.cerrarConexion();
            return null;
        }

    }
       
    @Override
    public String toString() {
        return "Vehiculo{" + "no_placa=" + placa + '}';
    }
    
}
