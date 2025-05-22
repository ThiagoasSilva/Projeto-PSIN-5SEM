/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import Controller.UsuarioLogin;
import java.sql.PreparedStatement;

/**
 *
 * @author thiagosilva
 */
public class LoginDao extends DAO{
    public void inserir(UsuarioLogin usuarioLogin)    {
        try{
            abrirBanco();
            String query = "INSERT INTO UsuarioLogin(email, senha) VALUES (?, ?)";
            pst = (PreparedStatement) con.prepareStatement(query);
            pst.setString(1, usuarioLogin.getEmail());
            pst.setString(1, usuarioLogin.getEmail());
            pst.execute();
            fecharBanco();
        } catch(Exception e){
            System.out.println("Erro" + e.getMessage());
        }
    }
}
