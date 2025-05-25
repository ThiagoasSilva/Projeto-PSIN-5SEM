/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Enum.java to edit this template
 */
package Enuns;

/**
 *
 * @author thiagosilva
 */
public enum CategoriaVeiculo {
    CARRO, MOTO;

    public static CategoriaVeiculo fromString(String categoria) {
        return CategoriaVeiculo.valueOf(categoria.toUpperCase());
    }
}
