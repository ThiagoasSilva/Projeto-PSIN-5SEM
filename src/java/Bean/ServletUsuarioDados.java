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
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author thiagosilva
 */
public class ServletUsuarioDados extends HttpServlet {

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
            HttpSession session = request.getSession();
            Integer idUsuario = (Integer) session.getAttribute("idUsuario"); // Recupera o ID do usuário da sessão

            if (idUsuario == null) {
                response.sendRedirect(request.getContextPath() + "/UsuarioLoginView.jsp?mensagemErro=Por favor, faça login para alterar seus dados.");
                return;
            }

            LoginDao loginDao = new LoginDao();
            Usuario usuario = null;
            try {
               
                usuario = loginDao.buscarIdUsuario(idUsuario); 

                if (usuario != null) {
                    request.setAttribute("usuario", usuario);
                    request.getRequestDispatcher("UsuarioAlterarView.jsp").forward(request, response);
                } else {
                    request.setAttribute("mensagemErro", "Não foi possível carregar os dados do usuário. Usuário não encontrado.");
                    request.getRequestDispatcher("UsuarioAlterarView.jsp").forward(request, response);
                }

            } catch (Exception e) {
                System.err.println("Erro ao carregar dados do usuário: " + e.getMessage());
                e.printStackTrace();
                request.setAttribute("mensagemErro", "Erro interno ao carregar dados do usuário. Tente novamente mais tarde.");
                request.getRequestDispatcher("UsuarioAlterarView.jsp").forward(request, response);
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
