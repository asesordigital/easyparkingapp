<%--     Document   : Archivo de peticiones
    Created on : dd/mm/yyyy, hh:mm: AM/PM
    Author     : nombre autor

--%>

<%@page import="java.util.logging.Logger"%>
<%@page import="java.util.logging.Level"%>
<%@page import="java.sql.SQLException"%>
<%@page import="logica.Contacto"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="application/json;charset=iso-8859-1" language="java" pageEncoding="iso-8859-1" session="true"%>

<%    // Iniciando respuesta JSON.
    Contacto c1 = new Contacto();
    String respuesta = "{";

    //Lista de procesos o tareas a realizar 
    List<String> tareas = Arrays.asList(new String[]{
        "actualizarcontacto",
        "eliminarcontacto",
        "listarcontacto",
        "guardarContacto"
    });

    String proceso = "" + request.getParameter("proceso");

    // Validación de parámetros utilizados en todos los procesos.
    if (tareas.contains(proceso)) {
        respuesta += "\"ok\": true,";
        // ------------------------------------------------------------------------------------- //
        // -----------------------------------INICIO PROCESOS----------------------------------- //
        // ------------------------------------------------------------------------------------- //
        if (proceso.equals("guardarContacto")) {

            int ident = Integer.parseInt(request.getParameter("identificacion"));
            String nombre = request.getParameter("nombre");
            String apellido = request.getParameter("apellido");
            String genero = request.getParameter("genero");
            String tipoident = request.getParameter("tipoIdentificacion");
            String telefono = request.getParameter("telefono");
            String direccion = request.getParameter("direccion");
            String correo = request.getParameter("correo");
            boolean favorito = Boolean.parseBoolean(request.getParameter("favorito"));
//
            Contacto c = new Contacto();
            c.setIdentificacion(ident);
            c.setNombre(nombre);
            c.setApellido(apellido);
            c.setGenero(genero);
            c.setTipoIdentificacion(tipoident);
            c.setTelefono(telefono);
            c.setDireccion(direccion);
            c.setCorreo(correo);
            if (c.guardarContacto()) {
//            if (true) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("eliminarcontacto")) {
            Contacto c = new Contacto();
            int identificacion = Integer.parseInt(request.getParameter("identificacion"));
            if (c.borrarContacto(identificacion)) {
//            if (true) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("listarcontacto")) {
            Contacto c = new Contacto();
            try {
                List<Contacto> lista = c.listarContactos();
                respuesta += "\"" + proceso + "\": true,\"Contactos\":" + new Gson().toJson(lista);
            } catch (SQLException ex) {
                respuesta += "\"" + proceso + "\": true,\"Contactos\":[]";
                Logger.getLogger(Contacto.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (proceso.equals("actualizarcontacto")) {
            int ident = Integer.parseInt(request.getParameter("identificacion"));
            String nombre = request.getParameter("nombre");
            String apellido = request.getParameter("apellido");
            String genero = request.getParameter("genero");
            String tipoident = request.getParameter("tipoIdentificacion");
            String telefono = request.getParameter("telefono");
            String direccion = request.getParameter("direccion");
            String correo = request.getParameter("correo");
            boolean favorito = Boolean.parseBoolean(request.getParameter("favorito"));
//
            Contacto c = new Contacto();
            c.setIdentificacion(ident);
            c.setNombre(nombre);
            c.setApellido(apellido);
            c.setGenero(genero);
            c.setTipoIdentificacion(tipoident);
            c.setTelefono(telefono);
            c.setDireccion(direccion);
            c.setCorreo(correo);
            if (c.actualizarContacto()) {
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
                + " son inválidos. Corrijalos y vuelva a intentar por favor.\"";
    }
    // Usuario sin sesión.
    // Responder como objeto JSON codificación ISO 8859-1.
    respuesta += "}";
    response.setContentType("application/json;charset=iso-8859-1");
    out.print(respuesta);
%>
