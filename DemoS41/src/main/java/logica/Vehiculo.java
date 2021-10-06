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
    /*private String nombre;
    private String apellido;
    private String genero;
    private String tipoPlaca;
    private String telefono;
    private String direccion;
    private String correo;*/
    
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

   /* public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public String getGenero() {
        return genero;
    }

    public void setGenero(String genero) {
        this.genero = genero;
    }

    public String getTipoPlaca() {
        return tipoPlaca;
    }

    public void setTipoPlaca(String tipoPlaca) {
        this.tipoPlaca = tipoPlaca;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }
    */
    
    public void llenarContacto(String placa) {
        this.placa = placa;
        /*this.nombre = nombre;
        this.apellido = apellido;
        this.genero = genero;
        this.tipoPlaca = tipoPlaca;
        this.telefono = telefono;
        this.direccion = direccion;
        this.correo = correo;*/
    }
    
    public boolean guardarVehiculo() {
        System.out.println("bien");
        ConexionBD conexion = new ConexionBD();
        String sentencia = "INSERT INTO vehiculo(no_placa) "
                + " VALUES ( '" + this.placa + "');  ";
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
            /*c.setNombre(rs.getString("nombre"));
            c.setApellido(rs.getString("apellido"));
            c.setGenero(rs.getString("genero"));
            c.setTipoPlaca(rs.getString("tipoPlaca"));
            c.setTelefono(rs.getString("telefono"));
            c.setDireccion(rs.getString("direccion"));
            c.setCorreo(rs.getString("correo"));*/
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
            /*this.nombre = rs.getString("nombre");
            this.apellido = rs.getString("apellido");
            this.genero = rs.getString("genero");
            this.tipoPlaca = rs.getString("tipoPlaca");
            this.telefono = rs.getString("telefono");
            this.direccion = rs.getString("direccion");
            this.correo = rs.getString("correo");*/
            conexion.cerrarConexion();
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
