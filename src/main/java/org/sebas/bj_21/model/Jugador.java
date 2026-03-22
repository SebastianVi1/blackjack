package org.sebas.bj_21.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * Representa un jugador de Blackjack (puede ser humano o dealer)
 */
public class Jugador implements Serializable {
    private static final long serialVersionUID = 1L;

    private List<Carta> mano;
    private String nombre;

    public Jugador(String nombre) {
        this.nombre = nombre;
        this.mano = new ArrayList<>();
    }

    /**
     * Añade una carta a la mano del jugador
     */
    public void agregarCarta(Carta carta) {
        mano.add(carta);
    }

    /**
     * Obtiene la mano actual del jugador
     */
    public List<Carta> getMano() {
        return new ArrayList<>(mano);
    }

    /**
     * Calcula el valor total de la mano, considerando el As como 1 u 11
     * @return El valor total de la mano
     */
    public int calcularValor() {
        int valor = 0;
        int ases = 0;

        // Sumar todos los valores (contando As como 1)
        for (Carta carta : mano) {
            if (carta.getValor() == Carta.Valor.AS) {
                ases++;
                valor += 1;
            } else {
                valor += carta.getPuntos();
            }
        }

        // Intentar contar un As como 11 si es posible sin superar 21
        while (ases > 0 && valor + 10 <= 21) {
            valor += 10;
            ases--;
        }

        return valor;
    }

    /**
     * Determina si el jugador tiene blackjack (21 con dos cartas)
     */
    public boolean tieneBlackjack() {
        return mano.size() == 2 && calcularValor() == 21;
    }

    /**
     * Determina si el jugador se ha pasado (valor > 21)
     */
    public boolean sePaso() {
        return calcularValor() > 21;
    }

    /**
     * Limpia la mano del jugador (para una nueva ronda)
     */
    public void limpiarMano() {
        mano.clear();
    }

    /**
     * Obtiene el nombre del jugador
     */
    public String getNombre() {
        return nombre;
    }

    /**
     * Obtiene el número de cartas en la mano
     */
    public int getNumeroCartas() {
        return mano.size();
    }
}

