package projeto._sem.agilizaVeiculos.entity.Locacao;

import java.time.LocalDateTime;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import projeto._sem.agilizaVeiculos.Enuns.SituacaoLocacao;

@Entity
public class Locacao {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idLocacao;

    @ManyToOne
    @JoinColumn(name = "idVeiculo")
    private int idVeiculo;
    
    @ManyToOne
    @JoinColumn(name = "idUsuario")
    private int idUsuario;
    
    @Enumerated(EnumType.STRING)
    private SituacaoLocacao situacaoLocacao;
    
    private LocalDateTime dataLocacao;
    private LocalDateTime dataDevolvido;
    private LocalDateTime dataDevolucao;
    private boolean devolvido;
    
   @OneToMany(mappedBy = "locacao", cascade = CascadeType.ALL)   
    private List<LocacaoPagamento> pagamentos;

    public int getIdLocacao() {
        return idLocacao;
    }

    public void setIdLocacao(int idLocacao) {
        this.idLocacao = idLocacao;
    }

    public int getIdVeiculo() {
        return idVeiculo;
    }

    public void setIdVeiculo(int idVeiculo) {
        this.idVeiculo = idVeiculo;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public SituacaoLocacao getSituacaoLocacao() {
        return situacaoLocacao;
    }

    public void setSituacaoLocacao(SituacaoLocacao situacaoLocacao) {
        this.situacaoLocacao = situacaoLocacao;
    }

    public LocalDateTime getDataLocacao() {
        return dataLocacao;
    }

    public void setDataLocacao(LocalDateTime dataLocacao) {
        this.dataLocacao = dataLocacao;
    }

    public LocalDateTime getDataDevolvido() {
        return dataDevolvido;
    }

    public void setDataDevolvido(LocalDateTime dataDevolvido) {
        this.dataDevolvido = dataDevolvido;
    }

    public LocalDateTime getDataDevolucao() {
        return dataDevolucao;
    }

    public void setDataDevolucao(LocalDateTime dataDevolucao) {
        this.dataDevolucao = dataDevolucao;
    }

    public boolean isDevolvido() {
        return devolvido;
    }

    public void setDevolvido(boolean devolvido) {
        this.devolvido = devolvido;
    }

    public List<LocacaoPagamento> getPagamentos() {
        return pagamentos;
    }

    public void setPagamentos(List<LocacaoPagamento> pagamentos) {
        this.pagamentos = pagamentos;
    }
    
    

}
