package Model;

import Controller.Usuario; // Mantém no pacote Controller, conforme sua solicitação
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author thiagosilva
 */
public class LoginDao extends DAO {

    // Método de inserção (mantido original, mas não usaremos para o login agora)
    public void inserir(Usuario usuario) throws Exception {
        try {
            abrirBanco();
            String query = "INSERT INTO Usuario(idUsuario, email, senha) VALUES (null, ?, ?)";
            pst = con.prepareStatement(query);
            pst.setString(1, usuario.getEmail());
            pst.setString(2, usuario.getSenha());
            pst.execute();
            System.out.println("Usuário " + usuario.getEmail() + " inserido com sucesso!");
        } catch (SQLException e) { // Captura SQLException
            System.out.println("Erro ao inserir usuário: " + e.getMessage());
            // Para debug, você pode adicionar e.printStackTrace();
        } finally {
            try {
                fecharBanco(); // Garante que a conexão seja fechada
            } catch (SQLException e) {
                System.err.println("Erro ao fechar conexão após inserção: " + e.getMessage());
            }
        }
    }

    // NOVO MÉTODO PARA LOGIN
    public Usuario buscarUsuario(String email, String senha) {
        Usuario usuario = null;
        try {
            abrirBanco();
            String query = "SELECT * FROM Usuario WHERE email = ?";
            pst = con.prepareStatement(query);
            pst.setString(1, email);
            pst.setString(2, senha);
            rs = pst.executeQuery(); // Executa a query de consulta

            if (rs.next()) { // Se encontrou um registro
                usuario = new Usuario();
                usuario.setIdUsuario(rs.getInt("idUsuario"));
                usuario.setEmail(rs.getString("email"));
                usuario.setSenha(rs.getString("senha")); // A senha aqui é o texto puro do BD
                // Se tivesse mais atributos, você os preencheria aqui
            }
        } catch (SQLException e) {
            System.out.println("Erro ao buscar usuário para login: " + e.getMessage());
            // Para debug, você pode adicionar e.printStackTrace();
        } finally {
            try {
                fecharBanco(); // Garante que a conexão e o ResultSet sejam fechados
            } catch (SQLException e) {
                System.err.println("Erro ao fechar conexão após busca: " + e.getMessage());
            }
        }
        return usuario; // Retorna o usuário encontrado ou null
    }
}