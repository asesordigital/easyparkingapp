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
    
    private String nombreEnSqlPlaca = "no_placa";
    private String nombretablaEnSql = "vehiculo";

    public Vehiculo() {
        
    }
    public Vehiculo(String placa) {
        this.placa = placa;
    }
    
    public String getPlaca() {
        return placa;
    }

    public void setPlaca(String placa) {
        this.placa = placa;
    }

    public boolean guardarVehiculo() {
        System.out.println("bien");
        ConexionBD conexion = new ConexionBD();
        String sentencia = "INSERT INTO "+nombretablaEnSql+"("+nombreEnSqlPlaca+") "
                + " VALUES ( '" + this.placa + "');";
        return EnviarSentencia(sentencia);
    }

    public boolean borrarVehiculo(int placa) {
        String Sentencia = "DELETE FROM `"+nombretablaEnSql+"` WHERE `"+nombreEnSqlPlaca+"`='" + placa + "'";
        ConexionBD conexion = new ConexionBD();

        return EnviarSentencia(Sentencia);
    }

    public boolean actualizarVehiculo() {
        ConexionBD conexion = new ConexionBD();
        String Sentencia = "UPDATE `"+nombretablaEnSql+"` SET "+nombreEnSqlPlaca+"='" + this.placa
                + "' WHERE "+nombreEnSqlPlaca+"=" + this.placa + ";";
        return EnviarSentencia(Sentencia);
    }
    
    private boolean EnviarSentencia(String sentencia){
        ConexionBD conexion = new ConexionBD();
        if (conexion.setAutoCommitBD(false)) {
            if (conexion.actualizarBD(sentencia)) {
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
        String sql = "select * from "+nombretablaEnSql+" order by "+nombreEnSqlPlaca+" asc";
        ResultSet rs = conexion.consultarBD(sql);
        Vehiculo c;
        while (rs.next()) {
            c = new Vehiculo();
            c.setPlaca(rs.getString(nombreEnSqlPlaca));
            listaVehiculos.add(c);

        }
        conexion.cerrarConexion();
        return listaVehiculos;
    }

    public Vehiculo getVehiculo() throws SQLException {
        ConexionBD conexion = new ConexionBD();
        String sql = "select * from "+nombretablaEnSql+" where "+nombreEnSqlPlaca+"='" + this.placa + "'";
        ResultSet rs = conexion.consultarBD(sql);
        if (rs.next()) {            
            this.placa = rs.getString(nombreEnSqlPlaca);
            conexion.cerrarConexion();
            return this;

        } else {
            conexion.cerrarConexion();
            return null;
        }

    }

    @Override
    public String toString() {
        return nombretablaEnSql+"{" + nombreEnSqlPlaca + "=" + placa + '}';
    }

}
