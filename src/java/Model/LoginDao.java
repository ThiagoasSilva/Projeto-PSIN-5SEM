package Model;

import Controller.Usuario;
import java.sql.Date;
import java.sql.ResultSet;
import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author thiagosilva
 */
public class LoginDao extends DAO {

    public boolean inserirLogin(Usuario u) {
        try {
            abrirBanco();
            String senhaCriptografada = BCrypt.hashpw(u.getSenha(), BCrypt.gensalt());
            String query = "INSERT INTO usuario (idUsuario, cpf, email, senha, rg, nome, idade, nascimento, acesso) values (null, ?, ?, ?, ?, ?, ?, ?, ?)";
            pst = con.prepareStatement(query);
            pst.setString(1, u.getCpf());
            pst.setString(2, u.getEmail());
            pst.setString(3, senhaCriptografada);
            pst.setString(4, u.getRg());
            pst.setString(5, u.getNome());
            pst.setInt(6, u.getIdade());
            pst.setDate(7, (Date) u.getNascimento()); // **Alterado para setDate**
            pst.setString(8, u.getAcesso());

            int linhasAfetadas = pst.executeUpdate();

            return linhasAfetadas > 0;
        } catch (Exception e) {
            System.out.println("Erro SQL ao inserir usuário: " + e.getMessage());
            e.printStackTrace();
            return false;
            
        } finally {
            try {
                fecharBanco();
            } catch (Exception e) {
                System.out.println("Erro ao fechar recursos (inserirLogin): " + e.getMessage());
            }
        }
    }

    public Usuario validarLogin(String email, String senhaDigitada) {
        Usuario usuarioAutenticado = new Usuario();
        
        try {
            abrirBanco();
            String query = "SELECT idUsuario, cpf, email, senha, rg, nome, idade, nascimento, acesso FROM usuario WHERE email = ?";
            pst = con.prepareStatement(query);
            pst.setString(1, email);
            
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                String senhaHashBanco = rs.getString("senha");

                if (BCrypt.checkpw(senhaDigitada, senhaHashBanco)) {
                    usuarioAutenticado = new Usuario();
                    usuarioAutenticado.setIdUsuario(rs.getInt("idUsuario"));
                    usuarioAutenticado.setCpf(rs.getString("cpf"));
                    usuarioAutenticado.setEmail(rs.getString("email"));
                    usuarioAutenticado.setRg(rs.getString("rg"));
                    usuarioAutenticado.setNome(rs.getString("nome"));
                    usuarioAutenticado.setIdade(rs.getInt("idade"));
                    usuarioAutenticado.setNascimento(rs.getDate("nascimento")); // **Alterado para getDate**
                    usuarioAutenticado.setAcesso(rs.getString("acesso"));
                }
            }

        } catch (Exception e) {
            System.out.println("Erro ao validar login: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                fecharBanco();
            } catch (Exception e) {
                System.out.println("Erro ao fechar recursos (validarLogin): " + e.getMessage());
            }
        }
        return usuarioAutenticado;
    }
}
