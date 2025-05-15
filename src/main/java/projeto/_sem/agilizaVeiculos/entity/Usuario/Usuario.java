package projeto._sem.agilizaVeiculos.entity.Usuario;

import java.time.LocalDate;

import projeto._sem.agilizaVeiculos.Enuns.Acesso;

public class Usuario {
 private int idUsuario;
    private Acesso acesso; //admin ou cliente
    private String cpf;
    private String rg;
    private String nome; // na database recebe nome completo
    private int idade;
    private LocalDate nascimento;

    public int getIdUsuario() {
        return idUsuario;
    } 

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public Acesso getAcesso() {
        return acesso;
    }

    public void setAcesso(Acesso acesso) {
        this.acesso = acesso;
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

    public LocalDate getNascimento() {
        return nascimento;
    }
    
    public void setNascimento(LocalDate nascimento) {
        this.nascimento = nascimento;
    }

    
}
