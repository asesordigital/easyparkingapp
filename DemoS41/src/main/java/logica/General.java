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
public class General {

    private ArrayList listaPropiedadesValues = new ArrayList<>();
    
    private String nameTable = "";
    private String[] nameColumn;
    

    public General(String nameTable, String[] nameColumn, ArrayList values) {
        listaPropiedadesValues = values;
        this.nameTable = nameTable;
        this.nameColumn = nameColumn;        
        
    }
/*
    public ArrayList getListaPropiedadesValues() {
        return listaPropiedadesValues;
    }*/

    public Object getListaPropiedadesValues(int index) {
        return listaPropiedadesValues.get(index);
    }

    public void setListaPropiedadesValues(int index, Object value) {
        this.listaPropiedadesValues.set(index, value);
    }
    
    

    public String getNameTable() {
        return nameTable;
    }

    public String[] getNameColumn() {
        return nameColumn;
    }
    
    
    public boolean guardarContacto() {        
        String columns = "";
        String values = "";
        //insert into estructura
        int l = nameColumn.length -1;
        for(int i = 0; i < l; i++){
            if(i < l){
                columns += nameColumn[i]+", ";
                values += "'"+listaPropiedadesValues.get(i)+"', ";
            }
            else{
                columns += nameColumn[i];
                values += "'"+listaPropiedadesValues.get(i)+"'";
            }            
        }        
        String sentencia = "INSERT INTO "+nameTable+"("+columns+") VALUES ("+values+");";
        return EnviarSentencia(sentencia);
    }

    public boolean borrarObjeto(String nameColumn, String value) {
        String Sentencia = "DELETE FROM `"+nameTable+"` WHERE `"+nameColumn+"`='" + value + "'";
        ConexionBD conexion = new ConexionBD();

        return EnviarSentencia(Sentencia);
    }

    public boolean actualizarObjeto(String nameColumn, String value) {
        
        String setValues = "";
        int l = this.nameColumn.length -1;
        for(int i = 0; i < l; i++){
            if(i < l){
                setValues += this.nameColumn[i]+"='"+listaPropiedadesValues.get(i)+"',";
            }else{
                setValues += this.nameColumn[i]+"='"+listaPropiedadesValues.get(i)+"'";
            }
        }        
        
        String Sentencia = "UPDATE `"+nameTable+"` SET "+setValues
                + " WHERE "+nameColumn+"=" + value + ";";

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
    

    public ArrayList<General> listarObjetos(String nameColumn) throws SQLException {
        ConexionBD conexion = new ConexionBD();
        ArrayList<General> listaContactos = new ArrayList<General>();
        String sql = "select * from "+nameTable+" order by "+nameColumn+" asc";
        ResultSet rs = conexion.consultarBD(sql);
        General c;
        
        while(rs.next()){
            ArrayList list = new ArrayList<>();
            for(int i = 0; i < this.nameColumn.length; i++){
                list.add(rs.getObject(this.nameColumn[i]));
            }            
            c = new General(nameTable,this.nameColumn,list);
            listaContactos.add(c);            
        }
        /*
        while (rs.next()) {
            c = new General();
            c.setIdentificacion(rs.getInt("identificacion"));
            c.setNombre(rs.getString("nombre"));
            c.setApellido(rs.getString("apellido"));
            c.setGenero(rs.getString("genero"));
            c.setTipoIdentificacion(rs.getString("tipoIdentificacion"));
            c.setTelefono(rs.getString("telefono"));
            c.setDireccion(rs.getString("direccion"));
            c.setCorreo(rs.getString("correo"));
            listaContactos.add(c);

        }*/
        conexion.cerrarConexion();
        return listaContactos;
    }

    public General getObjeto(String nameColumn, String value) throws SQLException {
        ConexionBD conexion = new ConexionBD();
        String sql = "select * from "+nameTable+" where "+nameColumn+"='" + value + "'";
        ResultSet rs = conexion.consultarBD(sql);
        
        
        if (rs.next()) {
            ArrayList list = new ArrayList<>();
            for(int i = 0; i < this.nameColumn.length; i++){
                list.add(rs.getObject(this.nameColumn[i]));
            }
            listaPropiedadesValues = list;
            /*
            this.identificacion = rs.getInt("identificacion");
            this.nombre = rs.getString("nombre");
            this.apellido = rs.getString("apellido");
            this.genero = rs.getString("genero");
            this.tipoIdentificacion = rs.getString("tipoIdentificacion");
            this.telefono = rs.getString("telefono");
            this.direccion = rs.getString("direccion");
            this.correo = rs.getString("correo");
            conexion.cerrarConexion();*/
            
            return this;

        } else {
            conexion.cerrarConexion();
            return null;
        }

    }

    @Override
    public String toString() {
        String toString = "";
        int l = this.nameColumn.length;
        for(int i = 0; i < l; i++){
            if(i < l-1)
                toString += nameColumn[i]+"= "+listaPropiedadesValues.get(i)+", ";
            else
                toString += nameColumn[i]+"= "+listaPropiedadesValues.get(i);
        }
        return "Contacto{"+toString+"}";
        //return "Contacto{" + "identificacion=" + identificacion + ", nombre=" + nombre + ", apellido=" + apellido + ", genero=" + genero + ", tipoIdentificacion=" + tipoIdentificacion + ", telefono=" + telefono + ", direccion=" + direccion + ", correo=" + correo + '}';
    }

}
