/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller;

import Enuns.Acesso;
import java.util.Date;

/**
 *
 * @author thiagosilva
 */
public class Usuario {

    private int idUsuario;
    private String Acesso;
    private String email;
    private String senha;
    private String cpf; // formatar cpf no banco ou frontend
    private String rg; // formatar rg ''
    private String nome; // Nome completo na database
    private int idade; // chegar se 
    private Date nascimento; // Alterado para java.sql.Date pq pega somente dia, mes e ano que é o objetivo do atributo.

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getAcesso() {
        return Acesso;
    }

    public void setAcesso(String Acesso) {
        this.Acesso = Acesso;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public String getCpf() {
        return cpf;
    }

    public void setCpf(String cpf) {
        this.cpf = cpf;
    }

    public String getRg() {
        return rg;
    }

    public void setRg(String rg) {
        this.rg = rg;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public int getIdade() {
        return idade;
    }

    public void setIdade(int idade) {
        this.idade = idade;
    }

    public Date getNascimento() {
        return nascimento;
    }

    public void setNascimento(Date nascimento) {
        this.nascimento = nascimento;
    }

    
}
