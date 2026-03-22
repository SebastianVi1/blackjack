# Blackjack 21

Aplicación de Blackjack con **Java EE** y patrón **MVC**.

## 🏗️ Estructura

| Componente | Archivo | Función |
|-----------|---------|---------|
| **Modelo** | Carta, Mazo, Jugador, Juego | Lógica del juego |
| **Controlador** | BlackjackServlet | Procesa acciones HTTP |
| **Vista** | index.jsp, game.jsp | Interfaz visual |

## 🔄 Flujo Backend Sencillo

```
1. Usuario hace clic → POST a /juego
                ↓
2. BlackjackServlet recibe la petición
                ↓
3. Obtiene el Juego de la sesión (o crea uno nuevo)
                ↓
4. Ejecuta la acción (pedir, plantarse, nuevo juego)
                ↓
5. Guarda cambios en la sesión
                ↓
6. Redirige a game.jsp que renderiza HTML
                ↓
7. Navegador muestra resultado
```

## 📝 Clases Principales

**Carta.java** → Representa una carta (palo + valor)

**Mazo.java** → Gestiona 52 cartas, baraja y saca cartas

**Jugador.java** → Mano de cartas, calcula puntos (As = 1 u 11)

**Juego.java** → Lógica principal: inicia ronda, dealer juega, determina ganador

**BlackjackServlet.java** → Escucha `/juego`, procesa acciones, maneja sesión HTTP

## 🎮 Qué Pasa en Cada Acción

| Acción | Qué hace |
|--------|----------|
| **Pedir** | Saca 1 carta al jugador, verifica si se pasó |
| **Plantarse** | Dealer pide hasta 17+, compara puntos, determina ganador |
| **Nuevo Juego** | Limpia manos, baraja, reparte 2 cartas |

## 💾 HttpSession (Persistencia)

```
- HTTP es stateless (sin memoria)
- Usamos sesión para recordar el juego entre peticiones
- Cada usuario tiene su propia sesión con su juego
```

## 🚀 Deploy

```bash
mvn clean package
# Copia: target/BJ_21-1.0-SNAPSHOT.war → TOMCAT_HOME/webapps/
```

**Stack**: Java 11 + Tomcat 9 + Maven
