package org.sebas.bj_21.model;

import java.io.Serializable;

/**
 * Gestiona la lógica principal del juego de Blackjack
 */
public class Juego implements Serializable {
    private static final long serialVersionUID = 1L;

    private Mazo mazo;
    private Jugador jugador;
    private Jugador dealer;
    private EstadoJuego estado;
    private String mensaje;

    public enum EstadoJuego {
        NUEVO_JUEGO,
        EN_JUEGO,
        JUGADOR_SE_PASO,
        DEALER_SE_PASO,
        AMBOS_SE_PASARON,
        JUGADOR_BLACKJACK,
        DEALER_BLACKJACK,
        JUEGO_TERMINADO
    }

    public Juego() {
        this.mazo = new Mazo();
        this.jugador = new Jugador("Jugador");
        this.dealer = new Jugador("Dealer");
        this.estado = EstadoJuego.NUEVO_JUEGO;
        this.mensaje = "";
    }

    /**
     * Inicia una nueva ronda del juego
     */
    public void iniciarRonda() {
        limpiar();
        mazo.reiniciar();

        // Repartir dos cartas a cada uno
        jugador.agregarCarta(mazo.sacarCarta());
        dealer.agregarCarta(mazo.sacarCarta());
        jugador.agregarCarta(mazo.sacarCarta());
        dealer.agregarCarta(mazo.sacarCarta());

        estado = EstadoJuego.EN_JUEGO;

        // Verificar blackjack inicial
        if (jugador.tieneBlackjack() && dealer.tieneBlackjack()) {
            estado = EstadoJuego.JUEGO_TERMINADO;
            mensaje = "¡Empate! Ambos tienen Blackjack.";
        } else if (jugador.tieneBlackjack()) {
            estado = EstadoJuego.JUGADOR_BLACKJACK;
            mensaje = "¡Blackjack! ¡Has ganado!";
        } else if (dealer.tieneBlackjack()) {
            estado = EstadoJuego.DEALER_BLACKJACK;
            mensaje = "El dealer tiene Blackjack. ¡Perdiste!";
        }
    }

    /**
     * El jugador pide una carta
     */
    public void pedir() {
        if (estado != EstadoJuego.EN_JUEGO) {
            return;
        }

        jugador.agregarCarta(mazo.sacarCarta());

        if (jugador.sePaso()) {
            estado = EstadoJuego.JUGADOR_SE_PASO;
            mensaje = "¡Te pasaste! El dealer gana.";
        }
    }

    /**
     * El jugador se planta
     */
    public void plantarse() {
        if (estado != EstadoJuego.EN_JUEGO) {
            return;
        }

        // El dealer juega automáticamente
        jugarDealer();

        // Determinar ganador
        determinarGanador();
    }

    /**
     * El dealer juega automáticamente hasta tener 17 o más puntos
     */
    private void jugarDealer() {
        while (dealer.calcularValor() < 17) {
            dealer.agregarCarta(mazo.sacarCarta());
        }
    }

    /**
     * Determina el ganador de la ronda
     */
    private void determinarGanador() {
        estado = EstadoJuego.JUEGO_TERMINADO;

        int valorJugador = jugador.calcularValor();
        int valorDealer = dealer.calcularValor();

        if (dealer.sePaso()) {
            mensaje = "El dealer se pasó. ¡Ganaste!";
        } else if (valorJugador > valorDealer) {
            mensaje = "¡Ganaste!";
        } else if (valorJugador < valorDealer) {
            mensaje = "El dealer gana.";
        } else {
            mensaje = "¡Empate!";
        }
    }

    /**
     * Limpia las manos para una nueva ronda
     */
    private void limpiar() {
        jugador.limpiarMano();
        dealer.limpiarMano();
    }

    // Getters
    public Jugador getJugador() {
        return jugador;
    }

    public Jugador getDealer() {
        return dealer;
    }

    public EstadoJuego getEstado() {
        return estado;
    }

    public String getMensaje() {
        return mensaje;
    }

    public boolean estaEnJuego() {
        return estado == EstadoJuego.EN_JUEGO;
    }

    public boolean juegoTerminado() {
        return estado == EstadoJuego.JUEGO_TERMINADO ||
               estado == EstadoJuego.JUGADOR_SE_PASO ||
               estado == EstadoJuego.DEALER_BLACKJACK ||
               estado == EstadoJuego.JUGADOR_BLACKJACK;
    }
}

