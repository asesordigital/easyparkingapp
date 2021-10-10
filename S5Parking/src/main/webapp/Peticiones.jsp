<%--     Document   : Archivo de peticiones
    Created on : dd/mm/yyyy, hh:mm: AM/PM
    Author     : color autor

--%>

<%@page import="java.util.logging.Logger"%>
<%@page import="java.util.logging.Level"%>
<%@page import="java.sql.SQLException"%>
<%@page import="logica.Vehiculo"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="application/json;charset=iso-8859-1" language="java" pageEncoding="iso-8859-1" session="true"%>

<%    // Iniciando respuesta JSON.
    Vehiculo v1 = new Vehiculo();
    Vehiculo v = new Vehiculo();
    String respuesta = "{";

    //Lista de procesos o tareas a realizar 
    List<String> tareas = Arrays.asList(new String[]{
        "actualizarehiculo",
        "eliminarvehiculo",
        "listarvehiculos",
        "guardarvehiculo"
    });

    String proceso = "" + request.getParameter("proceso");

    // Validación de parámetros utilizados en todos los procesos.
    if (tareas.contains(proceso)) {
        respuesta += "\"ok\": true,";
        // ------------------------------------------------------------------------------------- //
        // -----------------------------------INICIO PROCESOS----------------------------------- //
        // ------------------------------------------------------------------------------------- //
        if (proceso.equals("guardarvehiculo")) {

            String placa = request.getParameter("placa");
            
            //String apellido = request.getParameter("marca");
            //boolean favorito = Boolean.parseBoolean(request.getParameter("favorito"));
//
            // Vehiculo v = new Vehiculo();
            v.setPlaca(placa);
            //v.setMarca(marca);//

            if (v.guardarVehiculo()) {
//            if (true) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("eliminarvehiculo")) {
            // Vehiculo v = new Vehiculo();
            String placa = request.getParameter("placa");
            if (v.borrarVehiculo(placa)) {
//            if (true) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("listarvehiculos")) {

            try {
                List<Vehiculo> lista = v.listarVehiculos();
                respuesta += "\"" + proceso + "\": true,\"Vehiculos\":" + new Gson().toJson(lista);
            } catch (SQLException ex) {
                respuesta += "\"" + proceso + "\": true,\"Vehiculos\":[]";
                Logger.getLogger(Vehiculo.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (proceso.equals("actualizarvehiculo")) {
            String placa = request.getParameter("placa");
            
            boolean favorito = Boolean.parseBoolean(request.getParameter("favorito"));
//
            //  Vehiculo v = new Vehiculo();
            v.setPlaca(placa);
            
            if (v.actualizarVehiculo()) {
//            if (true) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }
        }

        // ------------------------------------------------------------------------------------- //
        // -----------------------------------FIN PROCESOS-------------------------------------- //
        // ------------------------------------------------------------------------------------- //
        // Proceso desconocido.
    } else {
        respuesta += "\"ok\": false,";
        respuesta += "\"error\": \"INVALID\",";
        respuesta += "\"errorMsg\": \"Lo sentimos, los datos que ha enviado,"
                + " Pepe son inválidos. Corrijalos y vuelva a intentar por favor.\"";
    }
    // Usuario sin sesión.
    // Responder como objeto JSON codificación ISO 8859-1.
    respuesta += "}";
    response.setContentType("application/json;charset=iso-8859-1");
    out.print(respuesta);
%>
