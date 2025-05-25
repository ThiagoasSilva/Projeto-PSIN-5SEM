/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Bean;

import Controller.Usuario;
import Model.LoginDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeParseException;
import java.util.Date;

/**
 *
 * @author thiagosilva
 */
public class ServletUsuarioCadastro extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */

            String cpf = request.getParameter("cpf");
            String email = request.getParameter("email");
            String senha = request.getParameter("senha");
            String rg = request.getParameter("rg");
            String nome = request.getParameter("nome");
            String idadeStr = request.getParameter("idade");
            String nascimentoStr = request.getParameter("nascimento");

            Usuario usuario = new Usuario();

            usuario.setCpf(cpf);
            usuario.setEmail(email);
            usuario.setSenha(senha);
            usuario.setRg(rg);
            usuario.setNome(nome);
            usuario.setAcesso("cliente");

            int idade = 0;
            if (idadeStr != null && !idadeStr.isEmpty()) {
                idade = Integer.parseInt(idadeStr);
            }
            usuario.setIdade(idade);

            Date nascimentoSqlDate = null;
            if (nascimentoStr != null && !nascimentoStr.isEmpty()) {
                try {
                    LocalDate localDateNascimento = LocalDate.parse(nascimentoStr);

                    // --- ALTERNATIVA DE CONVERSÃO PARA JAVA 7 OU COMO UMA OPÇÃO MAIS EXPLÍCITA ---
                    // 1. Converte LocalDate para java.util.Date (com um instante no tempo)
                    java.util.Date utilDate = java.util.Date.from(localDateNascimento.atStartOfDay(ZoneId.systemDefault()).toInstant());

                    // 2. Converte java.util.Date para java.sql.Date
                    nascimentoSqlDate = new Date(utilDate.getTime());
                    // OU, uma forma mais direta de LocalDate para java.sql.Date (se seu Java for 8+)
                    // nascimentoSqlDate = java.sql.Date.valueOf(localDateNascimento); // A linha que você está tentando fazer funcionar

                } catch (Exception e) { // Pegar uma exceção mais genérica por enquanto, para debug
                    System.out.println("Erro ao converter data de nascimento: " + e.getMessage());
                    // Dependendo do seu requisito, você pode setar nascimentoSqlDate como null,
                    // ou retornar um erro para o usuário.
                }
            }
            usuario.setNascimento(nascimentoSqlDate);
            LoginDao loginDao = new LoginDao();
            boolean sucesso = loginDao.inserirLogin(usuario);

            if (sucesso) {
                // Redireciona com mensagem de sucesso na URL
                response.sendRedirect("login.jsp?mensagem=Cadastro%20realizado%20com%20sucesso!");
            } else {
                // Redireciona com mensagem de erro na URL
                response.sendRedirect("cadastro.jsp?mensagem=Erro%20ao%20realizar%20o%20cadastro");
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
