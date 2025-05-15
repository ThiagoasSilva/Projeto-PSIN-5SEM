package projeto._sem.agilizaVeiculos.entity.Locacao;

import java.time.LocalDateTime;

import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import projeto._sem.agilizaVeiculos.Enuns.FormaPagamento;
import projeto._sem.agilizaVeiculos.entity.Usuario.Usuario;

@Entity
public class LocacaoPagamento {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idLocacaoPagamento;

    @ManyToOne
    @JoinColumn(name = "idLocacao")
    private Locacao locacao;

    @ManyToOne
    @JoinColumn(name = "idUsuario")
    private Usuario usuario;

    @Enumerated(EnumType.STRING)
    private FormaPagamento formaPagamento;

    private LocalDateTime dataPagamento;
    private int parcelas;
    private float valorLocacao;

    public int getIdLocacaoPagamento() {
        return idLocacaoPagamento;
    }

    public void setIdLocacaoPagamento(int idLocacaoPagamento) {
        this.idLocacaoPagamento = idLocacaoPagamento;
    }

    public Locacao getLocacao() {
        return locacao;
    }

    public void setLocacao(Locacao locacao) {
        this.locacao = locacao;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public FormaPagamento getFormaPagamento() {
        return formaPagamento;
    }

    public void setFormaPagamento(FormaPagamento formaPagamento) {
        this.formaPagamento = formaPagamento;
    }

    public LocalDateTime getDataPagamento() {
        return dataPagamento;
    }

    public void setDataPagamento(LocalDateTime dataPagamento) {
        this.dataPagamento = dataPagamento;
    }

    public int getParcelas() {
        return parcelas;
    }

    public void setParcelas(int parcelas) {
        this.parcelas = parcelas;
    }

    public float getValorLocacao() {
        return valorLocacao;
    }

    public void setValorLocacao(float valorLocacao) {
        this.valorLocacao = valorLocacao;
    }
    
    

    
}
