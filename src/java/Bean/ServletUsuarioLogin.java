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

/**
 *
 * @author thiagosilva
 */
public class ServletUsuarioLogin extends HttpServlet {

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
          
          /*out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ServletUsuarioLogin</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ServletUsuarioLogin at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
            */
          String cpf = request.getParameter("cpf");
          String email = request.getParameter("email");
          String senha = request.getParameter("senha");
          
          Usuario usuario = new Usuario();
          usuario.setCpf(cpf);
          usuario.setEmail(email);
          usuario.setSenha(senha);
          
          LoginDao loginDao = new LoginDao();
          boolean sucesso = loginDao.inserirLogin(usuario);
          
          if(sucesso) {
              response.sendRedirect("UsuarioLoginView.html?mensagem=Cadastro%20realizado%20com%20sucesso!");              
          } else {
              response.sendRedirect("UsuarioCadastroView.jsp?mensagem=Cadastro%20inválido!");              
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
