package Model;

import Controller.Usuario; // Mantém no pacote Controller, conforme sua solicitação

/**
 *
 * @author thiagosilva
 */
public class LoginDao extends DAO {

    public boolean inserirLogin(Usuario u) {
        try {
            abrirBanco();
            String query = "INSERT INTO usuario (idUsuario, cpf, email, senha) values (?, ?, ?)";
            pst = con.prepareStatement(query);
            pst.setString(1, u.getCpf());
            pst.setString(2, u.getEmail());
            pst.setString(3, u.getSenha());

            int linhasAfetadas = pst.executeUpdate();

            fecharBanco();
            return linhasAfetadas > 0;
        } catch (Exception e) {
            System.out.println("Erro ao inserir cliente: " + e.getMessage());
            return true;
        }
    }    
}
    /*
    public Usuario pesquisarLogin (Usuario u){
        try {
            abrirBanco();
            String query = "SELECT cpf, nome, email, senha FROM usuario where cpf = ?";
            pst = con.prepareStatement(query);
            pst.set
        }
    }
}
*/