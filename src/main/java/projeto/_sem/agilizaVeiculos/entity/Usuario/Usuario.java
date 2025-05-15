package projeto._sem.agilizaVeiculos.entity.Usuario;

import java.time.LocalDate;
import java.util.List;

import jakarta.persistence.CascadeType; // verificar compatibilidade
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import projeto._sem.agilizaVeiculos.Enuns.Acesso;
import projeto._sem.agilizaVeiculos.entity.Locacao.Locacao;
import projeto._sem.agilizaVeiculos.entity.Locacao.LocacaoPagamento;

@Entity
public class Usuario {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idUsuario;
    
    @Enumerated(EnumType.STRING)
    private Acesso acesso; //admin ou cliente
    
    private String cpf;
    private String rg;
    private String nome; // na database recebe nome completo
    private int idade;
    private LocalDate nascimento;

    @OneToMany(mappedBy = "usuario", cascade = CascadeType.ALL)
    private List<UsuarioEndereco> enderecos;

    @OneToMany(mappedBy = "usuario", cascade = CascadeType.ALL)
    private List<UsuarioLogin> logins;

    @OneToMany(mappedBy = "usuario", cascade = CascadeType.ALL)
    private List<UsuarioTelefone> telefones;

    @OneToMany(mappedBy = "usuario", cascade = CascadeType.ALL)
    private List<Locacao> locacoes;

    @OneToMany(mappedBy = "usuario", cascade = CascadeType.ALL)
    private List<LocacaoPagamento> pagamentos;

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
