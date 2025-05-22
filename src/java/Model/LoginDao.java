/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import Controller.Usuario;
import java.sql.PreparedStatement;

/**
 *
 * @author thiagosilva
 */
public class LoginDao extends DAO{
        public void inserir(Usuario usuario)    {
        try{
            abrirBanco();
            String query = "INSERT INTO Usuario(idUsuario, email, senha) VALUES (null, ?, ?)";
            pst = (PreparedStatement) con.prepareStatement(query);
            pst.setString(1, usuario.getEmail());
            pst.setString(2, usuario.getEmail());
            pst.execute();
            fecharBanco();
        } catch(Exception e){
            System.out.println("Erro" + e.getMessage());
        }
    }
}
