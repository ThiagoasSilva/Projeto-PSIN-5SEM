package projeto._sem.agilizaVeiculos.entity.Locacao;

import java.time.LocalDate;
import java.time.LocalDateTime;

import projeto._sem.agilizaVeiculos.Enuns.SituacaoLocacao;

public class Locacao {
 private int idLocacao;
    private int idVeiculo;
    private int idUsuario;
    private SituacaoLocacao situacaoLocacao;
    private LocalDate dataLocacao;
    private LocalDateTime dataDevolvido;
    private LocalDateTime dataDevolucao;
    private boolean devolvido;
    
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
    public LocalDate getDataLocacao() {
        return dataLocacao;
    }
    public void setDataLocacao(LocalDate dataLocacao) {
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

    
}
