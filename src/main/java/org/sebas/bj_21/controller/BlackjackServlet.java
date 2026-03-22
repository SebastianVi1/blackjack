package org.sebas.bj_21.controller;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.sebas.bj_21.model.Juego;

import java.io.IOException;

/**
 * Servlet controlador del juego de Blackjack
 * Maneja las acciones del jugador y gestiona la sesión HTTP
 */
public class BlackjackServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        procesarSolicitud(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        procesarSolicitud(request, response);
    }

    /**
     * Procesa las solicitudes GET y POST
     */
    private void procesarSolicitud(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession sesion = request.getSession();

        // Obtener o crear el juego en la sesión
        Juego juego = (Juego) sesion.getAttribute("juego");
        if (juego == null) {
            juego = new Juego();
            sesion.setAttribute("juego", juego);
        }

        // Obtener la acción solicitada
        String accion = request.getParameter("accion");

        if (accion != null) {
            switch (accion) {
                case "nuevoJuego":
                    juego.iniciarRonda();
                    break;
                case "pedir":
                    if (juego.estaEnJuego()) {
                        juego.pedir();
                    }
                    break;
                case "plantarse":
                    if (juego.estaEnJuego()) {
                        juego.plantarse();
                    }
                    break;
            }
        } else if (juego.getEstado() == Juego.EstadoJuego.NUEVO_JUEGO) {
            // Si no hay acción y el juego es nuevo, iniciar automáticamente
            juego.iniciarRonda();
        }

        // Guardar el juego en la sesión
        sesion.setAttribute("juego", juego);

        // Redirigir al JSP
        request.getRequestDispatcher("/game.jsp").forward(request, response);
    }
}
