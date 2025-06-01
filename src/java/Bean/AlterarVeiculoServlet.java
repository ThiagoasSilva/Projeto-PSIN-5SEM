/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Bean;

import Controller.Veiculo;
import Enuns.CategoriaVeiculo;
import Model.ManterVeiculo;
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
public class AlterarVeiculoServlet extends HttpServlet {

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
            HttpSession session = request.getSession();
            Enuns.Acesso acesso = (Enuns.Acesso) session.getAttribute("acesso");

            if (acesso == null || acesso != Enuns.Acesso.Administrador) {
                response.sendRedirect("UsuarioLoginView.jsp?mensagem=Somente%20administradores%20podem%20alterar%20veículos");
                return;
            }

            String idStr = request.getParameter("idVeiculo");
            int idVeiculo = 0;
            try {
                idVeiculo = Integer.parseInt(idStr);
            } catch (NumberFormatException e) {
                request.setAttribute("mensagemErro", "ID do veículo inválido.");
                request.getRequestDispatcher("VeiculoAlterarView.jsp").forward(request, response);
                return;
            }

            // Recebendo os parâmetros do formulário
            String categoriaStr = request.getParameter("categoriaVeiculo");
            String marca = request.getParameter("marca");
            String modelo = request.getParameter("modelo");
            String cor = request.getParameter("cor");
            String rodasStr = request.getParameter("rodas");
            String motorizacaoStr = request.getParameter("motorizacao");
            String pesoStr = request.getParameter("pesoKg");
            String tanqueStr = request.getParameter("capacidadeTanque");
            String assentosStr = request.getParameter("assentos");
            String anoFabStr = request.getParameter("anoFabricacao");
            String anoModStr = request.getParameter("anoModelo");
            String placa = request.getParameter("placa");
            String chassi = request.getParameter("chassi");

            // Instanciando e validando veículo
            Veiculo veiculo = new Veiculo();
            veiculo.setIdVeiculo(idVeiculo);
            veiculo.setMarca(marca);
            veiculo.setModelo(modelo);
            veiculo.setCor(cor);
            veiculo.setPlaca(placa);
            veiculo.setChassi(chassi);

            try {
                veiculo.setCategoriaVeiculo(CategoriaVeiculo.valueOf(categoriaStr));
                veiculo.setRodas(Integer.parseInt(rodasStr));
                veiculo.setMotorizacao(Float.parseFloat(motorizacaoStr));
                veiculo.setPesoKg(Float.parseFloat(pesoStr));
                veiculo.setCapacidadeTanque(Float.parseFloat(tanqueStr));
                veiculo.setAssentos(Integer.parseInt(assentosStr));
                veiculo.setAnoFabricacao(Integer.parseInt(anoFabStr));
                veiculo.setAnoModelo(Integer.parseInt(anoModStr));
            } catch (Exception e) {
                request.setAttribute("mensagemErro", "Erro nos dados fornecidos: " + e.getMessage());
                request.setAttribute("veiculo", veiculo);
                request.getRequestDispatcher("VeiculoAlterarView.jsp").forward(request, response);
                return;
            }

            // Realizando a alteração
            ManterVeiculo manterVeiculo = new ManterVeiculo();
            boolean sucesso = manterVeiculo.alterarVeiculo(veiculo);

            if (sucesso) {
                response.sendRedirect("ListaVeiculo?mensagem=Veículo%20alterado%20com%20sucesso!");
            } else {
                request.setAttribute("mensagemErro", "Erro ao alterar veículo.");
                request.setAttribute("veiculo", veiculo);
                request.getRequestDispatcher("VeiculoAlterarView.jsp").forward(request, response);

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

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("idVeiculo") == null) {
            response.sendRedirect("ListaVeiculo?mensagem=Selecione%20um%20veículo%20para%20alterar");
            return;
        }

        int idVeiculo = (Integer) session.getAttribute("idVeiculo");

        ManterVeiculo manterVeiculo = new ManterVeiculo();
        Veiculo veiculo = manterVeiculo.buscarIdVeiculo(idVeiculo);

        if (veiculo != null) {
            request.setAttribute("veiculo", veiculo);
            request.getRequestDispatcher("VeiculoAlterarView.jsp").forward(request, response);
        } else {
            response.sendRedirect("ListaVeiculo?erro=veiculo_nao_encontrado");
        }

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
