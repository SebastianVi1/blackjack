<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.sebas.bj_21.model.Juego" %>
<%@ page import="org.sebas.bj_21.model.Jugador" %>
<%@ page import="org.sebas.bj_21.model.Carta" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blackjack - 21</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .container {
            background: rgba(0, 0, 0, 0.7);
            border-radius: 15px;
            padding: 40px;
            max-width: 900px;
            width: 100%;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
            border: 2px solid #00ff00;
        }

        h1 {
            text-align: center;
            color: #00ff00;
            margin-bottom: 10px;
            font-size: 2.5em;
            text-shadow: 0 0 10px #00ff00;
        }

        .subtitle {
            text-align: center;
            color: #aaa;
            margin-bottom: 30px;
            font-size: 0.9em;
        }

        .game-area {
            display: grid;
            grid-template-rows: 1fr 1fr;
            gap: 40px;
            margin-bottom: 30px;
        }

        .player-section, .dealer-section {
            border: 2px solid #00ff00;
            border-radius: 10px;
            padding: 20px;
            background: rgba(0, 30, 0, 0.5);
        }

        .section-title {
            color: #00ff00;
            font-size: 1.2em;
            margin-bottom: 15px;
            font-weight: bold;
        }

        .mano-container {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-bottom: 10px;
            min-height: 150px;
            align-content: flex-start;
        }

        .carta {
            width: 80px;
            height: 120px;
            background: white;
            border: 2px solid #333;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2em;
            font-weight: bold;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
            transition: transform 0.3s ease;
        }

        .carta:hover {
            transform: translateY(-5px);
        }

        .carta.corazones, .carta.diamantes {
            color: #ff0000;
        }

        .carta.treboles, .carta.picas {
            color: #000000;
        }

        .puntos {
            color: #00ff00;
            font-size: 1.1em;
            font-weight: bold;
            margin-top: 10px;
        }

        .puntos-label {
            color: #888;
            font-size: 0.9em;
        }

        .mensaje-resultado {
            background: rgba(255, 215, 0, 0.1);
            border: 2px solid #ffd700;
            border-radius: 8px;
            padding: 20px;
            text-align: center;
            margin-bottom: 30px;
            font-size: 1.3em;
            color: #ffd700;
            font-weight: bold;
        }

        .mensajeError {
            color: #ff4444;
        }

        .acciones {
            display: flex;
            justify-content: center;
            gap: 15px;
            flex-wrap: wrap;
        }

        button {
            padding: 12px 30px;
            font-size: 1em;
            border: 2px solid #00ff00;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            transition: all 0.3s ease;
            text-transform: uppercase;
        }

        .btn-pedir {
            background-color: #00ff00;
            color: #000;
        }

        .btn-pedir:hover:not(:disabled) {
            background-color: #00dd00;
            box-shadow: 0 0 15px #00ff00;
            transform: scale(1.05);
        }

        .btn-plantarse {
            background-color: #ff6600;
            color: white;
            border-color: #ff6600;
        }

        .btn-plantarse:hover:not(:disabled) {
            background-color: #ff7700;
            box-shadow: 0 0 15px #ff6600;
            transform: scale(1.05);
        }

        .btn-nuevo {
            background-color: #0099ff;
            color: white;
            border-color: #0099ff;
            padding: 15px 40px;
            font-size: 1.1em;
        }

        .btn-nuevo:hover {
            background-color: #00bbff;
            box-shadow: 0 0 15px #0099ff;
            transform: scale(1.05);
        }

        button:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        .info-juego {
            text-align: center;
            color: #888;
            font-size: 0.9em;
            margin-top: 20px;
        }

        .info-juego a {
            color: #0099ff;
            text-decoration: none;
        }

        .info-juego a:hover {
            text-decoration: underline;
        }

        @media (max-width: 600px) {
            .container {
                padding: 20px;
            }

            h1 {
                font-size: 1.8em;
            }

            .carta {
                width: 70px;
                height: 105px;
                font-size: 1.5em;
            }

            button {
                padding: 10px 20px;
                font-size: 0.9em;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>♠ BLACKJACK ♥</h1>
        <p class="subtitle">Alcanza 21 sin pasarte. El dealer debe llegar a 17.</p>

        <%
            Juego juego = (Juego) session.getAttribute("juego");
            if (juego == null) {
                juego = new Juego();
                session.setAttribute("juego", juego);
            }

            Jugador jugador = juego.getJugador();
            Jugador dealer = juego.getDealer();
            String mensaje = juego.getMensaje();
            boolean juegoTerminado = juego.juegoTerminado();
        %>

        <!-- Mensaje de resultado -->
        <% if (!mensaje.isEmpty()) { %>
            <div class="mensaje-resultado">
                <%= mensaje %>
            </div>
        <% } %>

        <!-- Área del juego -->
        <div class="game-area">
            <!-- Sección del Dealer -->
            <div class="dealer-section">
                <div class="section-title">Dealer</div>
                <div class="mano-container">
                    <%
                        List<Carta> manosDealer = dealer.getMano();
                        for (Carta carta : manosDealer) {
                            String paloClass = "";
                            switch(carta.getPalo()) {
                                case CORAZONES: paloClass = "corazones"; break;
                                case DIAMANTES: paloClass = "diamantes"; break;
                                case TRÉBOLES: paloClass = "treboles"; break;
                                case PICAS: paloClass = "picas"; break;
                            }
                    %>
                        <div class="carta <%= paloClass %>">
                            <%= carta.toString() %>
                        </div>
                    <% } %>
                </div>
                <div class="puntos">
                    <span class="puntos-label">Puntos del Dealer:</span>
                    <%= juegoTerminado ? dealer.calcularValor() : (dealer.getMano().isEmpty() ? "0" : "?") %>
                </div>
            </div>

            <!-- Sección del Jugador -->
            <div class="player-section">
                <div class="section-title">Tu Mano</div>
                <div class="mano-container">
                    <%
                        List<Carta> manosJugador = jugador.getMano();
                        for (Carta carta : manosJugador) {
                            String paloClass = "";
                            switch(carta.getPalo()) {
                                case CORAZONES: paloClass = "corazones"; break;
                                case DIAMANTES: paloClass = "diamantes"; break;
                                case TRÉBOLES: paloClass = "treboles"; break;
                                case PICAS: paloClass = "picas"; break;
                            }
                    %>
                        <div class="carta <%= paloClass %>">
                            <%= carta.toString() %>
                        </div>
                    <% } %>
                </div>
                <div class="puntos">
                    <span class="puntos-label">Tus Puntos:</span>
                    <%= jugador.calcularValor() %>
                </div>
            </div>
        </div>

        <!-- Botones de acción -->
        <div class="acciones">
            <% if (juegoTerminado) { %>
                <form method="post" action="<%= request.getContextPath() %>/juego" style="display: inline;">
                    <input type="hidden" name="accion" value="nuevoJuego">
                    <button type="submit" class="btn-nuevo">Nueva Mano</button>
                </form>
            <% } else { %>
                <form method="post" action="<%= request.getContextPath() %>/juego" style="display: inline;">
                    <input type="hidden" name="accion" value="pedir">
                    <button type="submit" class="btn-pedir">Pedir Carta</button>
                </form>
                <form method="post" action="<%= request.getContextPath() %>/juego" style="display: inline;">
                    <input type="hidden" name="accion" value="plantarse">
                    <button type="submit" class="btn-plantarse">Plantarse</button>
                </form>
            <% } %>
        </div>

        <div class="info-juego">
            <p><a href="<%= request.getContextPath() %>/index.jsp">← Volver al inicio</a></p>
        </div>
    </div>
</body>
</html>

