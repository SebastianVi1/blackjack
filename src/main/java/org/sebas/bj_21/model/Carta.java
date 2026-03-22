package org.sebas.bj_21.model;

import java.io.Serializable;

/**
 * Representa una carta de una baraja estándar de 52 cartas
 */
public class Carta implements Serializable {
    private static final long serialVersionUID = 1L;

    public enum Palo {
        CORAZONES("♥"), DIAMANTES("♦"), TRÉBOLES("♣"), PICAS("♠");

        private final String simbolo;

        Palo(String simbolo) {
            this.simbolo = simbolo;
        }

        public String getSimbolo() {
            return simbolo;
        }
    }

    public enum Valor {
        AS("A", 1),
        DOS("2", 2),
        TRES("3", 3),
        CUATRO("4", 4),
        CINCO("5", 5),
        SEIS("6", 6),
        SIETE("7", 7),
        OCHO("8", 8),
        NUEVE("9", 9),
        DIEZ("10", 10),
        JOTA("J", 10),
        REINA("Q", 10),
        REY("K", 10);

        private final String simbolo;
        private final int puntos;

        Valor(String simbolo, int puntos) {
            this.simbolo = simbolo;
            this.puntos = puntos;
        }

        public String getSimbolo() {
            return simbolo;
        }

        public int getPuntos() {
            return puntos;
        }
    }

    private Valor valor;
    private Palo palo;

    public Carta(Valor valor, Palo palo) {
        this.valor = valor;
        this.palo = palo;
    }

    public Valor getValor() {
        return valor;
    }

    public Palo getPalo() {
        return palo;
    }

    public int getPuntos() {
        return valor.getPuntos();
    }

    @Override
    public String toString() {
        return valor.getSimbolo() + palo.getSimbolo();
    }
}

