<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blackjack 21 - Inicio</title>
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
            text-align: center;
            background: rgba(0, 0, 0, 0.7);
            border-radius: 15px;
            padding: 60px 40px;
            max-width: 600px;
            border: 2px solid #00ff00;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
        }

        h1 {
            color: #00ff00;
            font-size: 3em;
            margin-bottom: 20px;
            text-shadow: 0 0 20px #00ff00;
        }

        .subtitle {
            color: #aaa;
            font-size: 1.1em;
            margin-bottom: 40px;
        }

        .description {
            color: #ddd;
            font-size: 0.95em;
            line-height: 1.6;
            margin-bottom: 40px;
            text-align: left;
            background: rgba(0, 255, 0, 0.05);
            padding: 20px;
            border-radius: 8px;
            border-left: 3px solid #00ff00;
        }

        .links {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        a {
            display: inline-block;
            padding: 15px 40px;
            font-size: 1.1em;
            font-weight: bold;
            border: 2px solid #0099ff;
            border-radius: 8px;
            background-color: #0099ff;
            color: white;
            text-decoration: none;
            transition: all 0.3s ease;
            text-transform: uppercase;
        }

        a:hover {
            background-color: #00bbff;
            box-shadow: 0 0 20px #0099ff;
            transform: scale(1.05);
        }

        .info {
            color: #888;
            font-size: 0.85em;
            margin-top: 40px;
        }

        .icon {
            font-size: 1.2em;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>♠ BLACKJACK ♥<br>21</h1>
    <p class="subtitle">¡Bienvenido al juego de Blackjack!</p>

    <div class="description">
        <strong>Cómo jugar:</strong>
        <ul style="list-style-position: inside; margin-top: 10px;">
            <li>Intenta alcanzar 21 puntos sin pasarte</li>
            <li>Pide cartas (Hit) o plántate (Stand)</li>
            <li>El dealer juega automáticamente después de que te plantas</li>
            <li>¡La mejor mano gana!</li>
        </ul>
    </div>

    <div class="links">
        <a href="<%= request.getContextPath() %>/juego"><span class="icon">🎮</span> Iniciar Juego</a>
    </div>

    <div class="info">
        <p>Aplicación de Blackjack desarrollada con Jakarta EE (Servlets y JSP)</p>
    </div>
</div>
</body>
</html>