package org.sebas.bj_21.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * Representa una baraja de cartas que puede ser barajeada y de la cual se pueden sacar cartas
 */
public class Mazo implements Serializable {
    private static final long serialVersionUID = 1L;

    private List<Carta> cartas;

    public Mazo() {
        this.cartas = new ArrayList<>();
        inicializar();
    }

    /**
     * Inicializa el mazo con 52 cartas (una baraja estándar)
     */
    private void inicializar() {
        cartas.clear();
        for (Carta.Palo palo : Carta.Palo.values()) {
            for (Carta.Valor valor : Carta.Valor.values()) {
                cartas.add(new Carta(valor, palo));
            }
        }
    }

    /**
     * Baraja aleatoriamente todas las cartas
     */
    public void barajar() {
        Collections.shuffle(cartas);
    }

    /**
     * Extrae la siguiente carta del mazo
     * @return La siguiente carta o null si el mazo está vacío
     */
    public Carta sacarCarta() {
        if (cartas.isEmpty()) {
            // Reinicializar el mazo si está vacío
            inicializar();
            barajar();
        }
        return cartas.remove(0);
    }

    /**
     * Obtiene el número de cartas restantes
     */
    public int getCartasRestantes() {
        return cartas.size();
    }

    /**
     * Reinicia el mazo (lo baraja de nuevo)
     */
    public void reiniciar() {
        inicializar();
        barajar();
    }
}

