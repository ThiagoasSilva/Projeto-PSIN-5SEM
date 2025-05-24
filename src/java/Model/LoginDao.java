package Model;

import Controller.Usuario; // Mantém no pacote Controller, conforme sua solicitação
import jakarta.resource.cci.ResultSet;

/**
 *
 * @author thiagosilva
 */
public class LoginDao extends DAO {

    public boolean inserirLogin(Usuario u) {
        try {
            abrirBanco();
            String senhaCriptografada = BCrypt.hashpw(u.getSenha(), BCrypt.gensalt());
            String query = "INSERT INTO usuario (idUsuario, cpf, email, senha) values (null, ?, ?, ?)";
            pst = con.prepareStatement(query);
            pst.setString(1, u.getCpf());
            pst.setString(2, u.getEmail());
            pst.setString(3, senhaCriptografada());

            int linhasAfetadas = pst.executeUpdate();

            fecharBanco();
            return linhasAfetadas > 0;
        } catch (Exception e) {
            System.out.println("Erro ao inserir cliente: " + e.getMessage());
            return true;
        }
    }

    public Usuario pesquisarLogin(Usuario u) {
        Usuario usuarioPesquisado = new Usuario();
        try {
            abrirBanco();
            String query = "SELECT idUsuario, cpf, nome, email, senha FROM usuario where cpf = ?";
            pst = con.prepareStatement(query);
            pst.setString(1, u.getCpf());

            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                String senhaHashBanco = rs.getString("senha");

                if (BCrypt.checkpw(u.getSenha(), senhaHashBanco)) {
                    usuarioPesquisado = new Usuario();
                    usuarioPesquisado.setIdUsuario(rs.getInt("idUsuario"));
                    usuarioPesquisado.setCpf(rs.getString("cpf"));
                    usuarioPesquisado.setEmail(rs.getString("email"));
                    usuarioPesquisado.setSenha(rs.getString("senha"));
                }
            }
            fecharBanco();
        } catch (Exception e) {
            System.out.println("Erro ao buscar usuario: " + e.getMessage());
        }
        return usuarioPesquisado;
    }
}
