<%-- 
    Document   : VeiculosDetalhesView
    Created on : 3 de jun. de 2025, 21:53:11
    Author     : thiagosilva
--%>

Pular para o conteúdo
Você disse:
como posso prosseguir com o erro da imagem
O ChatGPT disse:

O erro apresentado na imagem é:

incompatible types: java.sql.ResultSet cannot be converted to jakarta.resource.cci.ResultSet

✅ Causa:

Você está usando java.sql.ResultSet (do JDBC), mas declarou a variável como jakarta.resource.cci.ResultSet, que pertence ao Jakarta Connector Architecture (JCA). São tipos diferentes e incompatíveis.
🛠 Como corrigir:

Você provavelmente quer usar o java.sql.ResultSet, então basta importar o tipo correto e ajustar a declaração da variável.
Passos:

    Altere o import da classe ResultSet:
    No topo do seu arquivo Java, substitua:

import jakarta.resource.cci.ResultSet;

por:

    import java.sql.ResultSet;

    Verifique também os imports de Connection, PreparedStatement e outros para garantir que todos venham de java.sql.* e não de jakarta.*.

💡 Dica:

Evite usar Alt+Enter para "cast" nesse caso — o cast não vai resolver o problema porque são tipos incompatíveis de bibliotecas diferentes.

Se você estiver utilizando um servidor Jakarta EE, certifique-se de não misturar bibliotecas do Jakarta Connector com JDBC puro, que é o mais comum em consultas SQL simples.

Se quiser, posso revisar o seu código completo dessa parte para garantir que tudo esteja usando java.sql.*. Deseja isso?
Você disse:
adicione um metodo excluir
O ChatGPT disse:

Claro! Aqui está um exemplo de método excluir que você pode adicionar na sua classe DAO para remover um veículo pelo ID, utilizando JDBC (java.sql). Presumo que esteja usando algo como PreparedStatement:

public boolean excluirVeiculo(int idVeiculo) {
    String sql = "DELETE FROM veiculo WHERE idVeiculo = ?";

    try (Connection conn = Conexao.getConexao();
         PreparedStatement pst = conn.prepareStatement(sql)) {
         
        pst.setInt(1, idVeiculo);
        int linhasAfetadas = pst.executeUpdate();

        return linhasAfetadas > 0; // retorna true se excluiu algum registro
    } catch (SQLException e) {
        System.err.println("Erro ao excluir veículo: " + e.getMessage());
        return false;
    }
}

🔧 Explicação:

    Conexao.getConexao() deve ser seu método que retorna uma conexão ativa com o banco de dados.

    O método recebe o idVeiculo como parâmetro.

    Executa um DELETE no banco.

    Retorna true se algum registro foi afetado (ou seja, excluído com sucesso), false caso contrário ou se ocorrer um erro.

Se você estiver usando uma classe chamada VeiculoDAO, por exemplo, esse método se encaixa perfeitamente lá.

Quer que eu adapte o método para trabalhar com transações ou mensagens de confirmação no JSP?
Você disse:
observe o deletar veiculo 
    public void deletarVeiculo(Veiculo veiculo) {
        try {
            abrirBanco();
            String query = "DELETE FROM veiculo WHERE id = ?";
            pst = con.prepareStatement(query);
            pst.setInt(1, veiculo.getIdVeiculo());
            pst.execute();
            fecharBanco();

        } catch (Exception e) {
            System.out.println("Erro " + e.getMessage());
        }
    }

o deletar veiculo servet :  int idVeiculo = Integer.parseInt(String.valueOf(request.getParameter("idVeiculo")));

            Veiculo veiculo = new Veiculo();
            veiculo.setIdVeiculo(idVeiculo);

            ManterVeiculo veiculosDAO = new ManterVeiculo();
            veiculosDAO.deletarVeiculo(veiculo);

            request.getRequestDispatcher("ListaVeiculo").forward(request, response);

e o front onde se encontra o botão de deletar o veiculo <%-- 
    Document   : VeiculoListaView
    Created on : 25 de mai. de 2025, 19:49:13
    Author     : thiagosilva
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="Controller.Veiculo" %>
<%@ page import="java.util.List" %>
<%@ page import="Enuns.CategoriaVeiculo" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Catálogo de Veículos - Agiliza Veículos</title>
        <link rel="icon" type="image/x-icon" href="assets/img/antonios-logo.png">
        <!-- <link rel="stylesheet" href="assets/style/index.css"/> -->
        <link rel="stylesheet" href="assets/style/VeiculoListaView.css"/>
    </head>
    <body>


        <header>
            <nav class="navbar">
                <div class="logo">
                    <a href="index.jsp">Agiliza Veículos</a>
                </div>
                <ul class="nav-links">
                    <li><a href="index.jsp">Início</a></li>
                    <li><a href="VeiculoListaView.jsp">Catálogo</a></li> 
                    <li><a href="sobre.jsp">Sobre Nós</a></li>
                    <li><a href="contato.jsp">Contato</a></li>
                    <li><a href="UsuarioAlterarView.jsp">Alterar dados</a></li>
                </ul>
                <div class="nav-auth-buttons">
                    <%
                        boolean logado = session.getAttribute("nome") != null;
                        Enuns.Acesso acessoUsuario = (Enuns.Acesso) session.getAttribute("acesso");
                        boolean isAdmin = logado && acessoUsuario == Enuns.Acesso.Administrador;
                    %>

                    <% if (logado) {%>
                    <a href="DeslogarUsuario" class="btn btn-logout">Sair</a>
                    <%} else {%>
                    <a href="UsuarioLoginView.jsp" class="btn btn-login-nav">Login</a>
                    <a href="UsuarioCadastroView.jsp" class="btn btn-secondary btn-register-nav">Cadastre-se</a>
                    <%}%>
                </div>
            </nav>
        </header>

        <main class="content-wrapper">
            <div class="page-header">
                <h2>Nosso Catálogo de Veículos</h2>
            </div>

            <% String mensagemErro = (String) request.getAttribute("mensagemErro");
                String mensagemSucesso = (String) request.getAttribute("mensagemSucesso");
            %>
            <% if (mensagemErro != null) {%>
            <div class="info-message error-message">
                <%= mensagemErro%>
            </div>
            <% } else if (mensagemSucesso != null) {%>
            <div class="info-message success-message">
                <%= mensagemSucesso%>
            </div>
            <% }%>

            <div class="vehicle-grid">
                <c:choose>
                    <c:when test="${not empty veiculos}"> 
                        <c:forEach var="v" items="${veiculos}">
                            <div class="vehicle-card">
                                <div class="card-image">
                                    <%-- <img src="assets/img/${v.categoriaVeiculo.name().toLowerCase()}.png" alt="${v.modelo}"> --%>
                                    <img src="assets/img/default-car.png" alt="${v.modelo}"> <%-- Imagem padrão --%>
                                </div>
                                <div class="card-details">
                                    <h3>${v.marca} ${v.modelo}</h3>
                                    <p><strong>Categoria:</strong> ${v.categoriaVeiculo}</p>
                                    <p><strong>Cor:</strong> ${v.cor}</p>
                                    <p><strong>Motorização:</strong> ${String.format("%.1f", v.motorizacao)} L</p> <%-- Formata float para 1 casa decimal --%>
                                    <p><strong>Peso:</strong> ${String.format("%.0f", v.pesoKg)} kg</p>
                                    <p><strong>Assentos:</strong> ${v.assentos}</p>
                                    <p><strong>Tanque:</strong> ${String.format("%.1f", v.capacidadeTanque)} L</p>
                                    <p><strong>Ano:</strong> ${v.anoFabricacao}/${v.anoModelo}</p>
                                    <p><strong>Placa:</strong> ${v.placa}</p>
                                    <p><strong>Chassi:</strong> ${v.chassi}</p>
                                    <a href="#" class="btn btn-details">Ver Detalhes</a>
                                </div>
                                <% if (isAdmin) { %>
                                <div class="admin-buttons">
                                    <a href="AltVeiculo?idVeiculo=${v.idVeiculo}" class="btn car-btn-edit">Alterar</a>
                                    <a href="DelVeiculo?idVeiculo=${v.idVeiculo}" class="btn car-btn-delete"
                                       onclick="return confirm('Tem certeza que deseja excluir este veículo?');">Excluir</a>
                                </div>
                                <% }%>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <p class="no-vehicles-message">Nenhum veículo cadastrado ainda. <a href="VeiculoCadastroView.jsp">Cadastre um novo veículo aqui.</a></p>
                    </c:otherwise>
                </c:choose>
            </div>

            <div style="text-align:center; margin-top: 30px; margin-bottom: 30px;">
                <a href="VeiculoCadastroView.jsp" class="btn btn-primary">Cadastrar novo veículo</a>
            </div>
        </main>

        <footer>
            <p>&copy; 2025 Agiliza Veículos. Todos os direitos reservados.</p>
        </footer>
    </body>
</html>

por alguma razão o deletar não funciona 
O ChatGPT disse:

Obrigado por compartilhar o código completo. Tudo parece estruturado corretamente, mas o problema pode estar ocorrendo em algum dos seguintes pontos:
✅ Checklist para identificar por que o deletar não está funcionando:
1. Nome do Servlet

No botão da JSP, você usa:

<a href="DelVeiculo?idVeiculo=${v.idVeiculo}" class="btn car-btn-delete" ...>Excluir</a>

Verifique se existe um Servlet mapeado como DelVeiculo com algo como:

@WebServlet("/DelVeiculo")
public class DelVeiculo extends HttpServlet {

👉 Se esse servlet não existir ou estiver com outro nome/URL, a requisição nunca chega ao backend.
2. Confirme se o idVeiculo está sendo passado

Verifique se está chegando corretamente no Servlet:

int idVeiculo = Integer.parseInt(request.getParameter("idVeiculo"));
System.out.println("ID do veículo a ser excluído: " + idVeiculo); // debug

3. Confirme se o id no banco é realmente id e não idVeiculo

No seu DELETE:

String query = "DELETE FROM veiculo WHERE id = ?";

⚠️ Certifique-se de que o nome da coluna na tabela é id. Se for idVeiculo, troque por:

String query = "DELETE FROM veiculo WHERE idVeiculo = ?";

4. Conexão com o banco está funcionando?

Adicione um log para garantir que está abrindo e fechando corretamente:

System.out.println("Conectando ao banco para deletar o veículo...");

5. Você está redirecionando corretamente após deletar?

No seu servlet:

request.getRequestDispatcher("ListaVeiculo").forward(request, response);

⚠️ Certifique-se de que ListaVeiculo é o caminho correto para atualizar a lista.

Se ListaVeiculo for um Servlet, ele precisa estar mapeado corretamente também:

@WebServlet("/ListaVeiculo")
public class ListaVeiculo extends HttpServlet {

6. Mostrar mensagens de sucesso ou erro

Na sua JSP você tem:

<% String mensagemErro = (String) request.getAttribute("mensagemErro"); %>

Mas no servlet DelVeiculo você não está setando nenhuma mensagem. Adicione isso para facilitar o feedback:

if (veiculosDAO.deletarVeiculo(veiculo)) {
    request.setAttribute("mensagemSucesso", "Veículo excluído com sucesso.");
} else {
    request.setAttribute("mensagemErro", "Erro ao excluir veículo.");
}
request.getRequestDispatcher("ListaVeiculo").forward(request, response);

✅ Exemplo completo do Servlet DelVeiculo corrigido:

@WebServlet("/DelVeiculo")
public class DelVeiculo extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int idVeiculo = Integer.parseInt(request.getParameter("idVeiculo"));

            Veiculo veiculo = new Veiculo();
            veiculo.setIdVeiculo(idVeiculo);

            ManterVeiculo veiculosDAO = new ManterVeiculo();
            if (veiculosDAO.deletarVeiculo(veiculo)) {
                request.setAttribute("mensagemSucesso", "Veículo excluído com sucesso.");
            } else {
                request.setAttribute("mensagemErro", "Erro ao excluir veículo.");
            }

        } catch (Exception e) {
            request.setAttribute("mensagemErro", "Erro: " + e.getMessage());
        }

        request.getRequestDispatcher("ListaVeiculo").forward(request, response);
    }
}

✅ E na sua DAO:

Verifique o nome correto da coluna na tabela (possivelmente idVeiculo):

String query = "DELETE FROM veiculo WHERE idVeiculo = ?";

Se você quiser, posso verificar a estrutura da tabela ou a classe Veiculo se você enviar. Isso vai garantir que a exclusão está de fato batendo com o banco. Deseja isso?
Você disse:
o erro estava no id do string query, obrigado! brabo dmss
O ChatGPT disse:

Boa!! 😎 Fico feliz que resolveu — esse detalhe do nome da coluna (id vs idVeiculo) é traiçoeiro mesmo. Sempre que tiver dúvidas com SQL ou Servlets, pode contar comigo.

Se for evoluir esse sistema depois (como adicionar filtros, ordenação, upload de imagem do veículo, etc.), só chamar! 🚗✨

Bons códigos!
Você disse:
no mesmo projeto tenho o alterar veiculo public boolean alterarVeiculo(Veiculo v) {
        try {
            abrirBanco();
            String query = "UPDATE veiculo SET categoriaVeiculo = ?, marca = ?, modelo = ?, cor = ?, rodas = ?, "
                    + "motorizacao = ?, pesoKg = ?, capacidadeTanque = ?, assentos = ?, "
                    + "anoFabricacao = ?, anoModelo = ?, placa = ?, chassi = ? "
                    + "WHERE idVeiculo = ?";

            pst = con.prepareStatement(query);
            pst.setString(1, v.getCategoriaVeiculo().name()); // Enum convertido para String
            pst.setString(2, v.getMarca());
            pst.setString(3, v.getModelo());
            pst.setString(4, v.getCor());
            pst.setInt(5, v.getRodas());
            pst.setFloat(6, v.getMotorizacao());
            pst.setFloat(7, v.getPesoKg());
            pst.setFloat(8, v.getCapacidadeTanque());
            pst.setInt(9, v.getAssentos());
            pst.setInt(10, v.getAnoFabricacao());
            pst.setInt(11, v.getAnoModelo());
            pst.setString(12, v.getPlaca());
            pst.setString(13, v.getChassi());
            pst.setInt(14, v.getIdVeiculo());

            int linhasAfetadas = pst.executeUpdate();

            fecharBanco();
            return linhasAfetadas > 0;

        } catch (Exception e) {
            System.out.println("Erro ao fechar recursos (alterarVeiculo): " + e.getMessage());
            return false;
        }
    }

o servlet de alterar try (PrintWriter out = response.getWriter()) {
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

e o front <%-- 
    Document   : VeiculoAlterarView
    Created on : 1 de jun. de 2025, 20:26:03
    Author     : thiagosilva
--%>

<%@page import="Controller.Veiculo"%>
<%@page import="Enuns.CategoriaVeiculo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Alterar Dados do Veículo - Agiliza Veículos</title>
        <link rel="icon" type="image/x-icon" href="assets/img/antonios-logo.png">
        <link rel="stylesheet" href="assets/style/index.css"/>
        <link rel="stylesheet" href="assets/style/VeiculoCadastroView.css"/>
    </head>
    <body>
        <header>
            <nav class="navbar">
                <div class="logo">
                    <img src="assets/img/antonios-logo.png" alt="logotipo" width="50px" height="50px" />
                    <a href="index.jsp">Agiliza Veículos</a>
                </div>
                <ul class="nav-links">
                    <li><a href="index.jsp">Início</a></li>
                    <li><a href="ListaVeiculo">Catálogo</a></li>
                    <li><a href="sobre.jsp">Sobre Nós</a></li>
                    <li><a href="contato.jsp">Contato</a></li>
                    <li><a href="AltVeiculo">Alterar dados</a></li> 
                </ul>
                <div class="nav-auth-buttons">
                    <%
                        boolean logado = session.getAttribute("nome") != null;
                    %>
                    <% if (logado) { %>
                    <a href="DeslogarUsuario" class="btn btn-logout">Sair</a>
                    <% } else { %>
                    <a href="UsuarioLoginView.jsp" class="btn btn-login-nav">Login</a>
                    <a href="UsuarioCadastroView.jsp" class="btn btn-secondary btn-register-nav">Cadastre-se</a>
                    <% } %>
                </div>
            </nav>
        </header>

        <main class="content-wrapper">
            <div class="form-container">
                <div class="form-header">
                    <h2>Alterar Dados do Veículo</h2>
                </div>

                <%
                    String mensagemErro = (String) request.getAttribute("mensagemErro");
                    String mensagemSucesso = (String) request.getAttribute("mensagemSucesso");
                %>
                <% if (mensagemErro != null) {%>
                <div class="info-message error-message"><%= mensagemErro%></div>
                <% } else if (mensagemSucesso != null) {%>
                <div class="info-message success-message"><%= mensagemSucesso%></div>
                <% } %>

                <%
                    Veiculo veiculo = (Veiculo) request.getAttribute("veiculo");

                    int idVeiculo = veiculo != null ? veiculo.getIdVeiculo() : 0;
                    String categoria = veiculo != null && veiculo.getCategoriaVeiculo() != null ? veiculo.getCategoriaVeiculo().name() : "";
                    String marca = veiculo != null ? veiculo.getMarca() : "";
                    String modelo = veiculo != null ? veiculo.getModelo() : "";
                    String cor = veiculo != null ? veiculo.getCor() : "";
                    String rodas = veiculo != null ? String.valueOf(veiculo.getRodas()) : "";
                    String motorizacao = veiculo != null ? String.valueOf(veiculo.getMotorizacao()) : "";
                    String pesoKg = veiculo != null ? String.valueOf(veiculo.getPesoKg()) : "";
                    String capacidadeTanque = veiculo != null ? String.valueOf(veiculo.getCapacidadeTanque()) : "";
                    String assentos = veiculo != null ? String.valueOf(veiculo.getAssentos()) : "";
                    String anoFabricacao = veiculo != null ? String.valueOf(veiculo.getAnoFabricacao()) : "";
                    String anoModelo = veiculo != null ? String.valueOf(veiculo.getAnoModelo()) : "";
                    String placa = veiculo != null ? veiculo.getPlaca() : "";
                    String chassi = veiculo != null ? veiculo.getChassi() : "";
                %>

                <form action="AltVeiculo" method="post" class="cadastro-form">
                    <input type="hidden" name="idVeiculo" value="<%= idVeiculo%>">

                    <div class="textfield">
                        <label for="categoriaVeiculo">Categoria do Veículo:</label>
                        <select id="categoriaVeiculo" name="categoriaVeiculo" required>
                            <option value="">Selecione a Categoria</option>
                            <option value="CARRO" <%= "CARRO".equals(categoria) ? "selected" : ""%>>Carro</option>
                            <option value="MOTO" <%= "MOTO".equals(categoria) ? "selected" : ""%>>Moto</option>
                        </select>
                    </div>

                    <div class="textfield">
                        <label for="marca">Marca:</label>
                        <input type="text" id="marca" name="marca" value="<%= marca%>" required>
                    </div>

                    <div class="textfield">
                        <label for="modelo">Modelo:</label>
                        <input type="text" id="modelo" name="modelo" value="<%= modelo%>" required>
                    </div>

                    <div class="textfield">
                        <label for="cor">Cor:</label>
                        <input type="text" id="cor" name="cor" value="<%= cor%>" required>
                    </div>

                    <div class="textfield">
                        <label for="rodas">Número de Rodas:</label>
                        <input type="number" id="rodas" name="rodas" value="<%= rodas%>" min="1" required>
                    </div>

                    <div class="textfield">
                        <label for="motorizacao">Motorização (Litros):</label>
                        <input type="number" id="motorizacao" name="motorizacao" step="0.1" value="<%= motorizacao%>" required>
                    </div>

                    <div class="textfield">
                        <label for="pesoKg">Peso (Kg):</label>
                        <input type="number" id="pesoKg" name="pesoKg" value="<%= pesoKg%>" required>
                    </div>

                    <div class="textfield">
                        <label for="capacidadeTanque">Capacidade do Tanque (Litros):</label>
                        <input type="number" id="capacidadeTanque" name="capacidadeTanque" step="0.1" value="<%= capacidadeTanque%>" required>
                    </div>

                    <div class="textfield">
                        <label for="assentos">Número de Assentos:</label>
                        <input type="number" id="assentos" name="assentos" value="<%= assentos%>" required>
                    </div>

                    <div class="textfield">
                        <label for="anoFabricacao">Ano de Fabricação:</label>
                        <input type="number" id="anoFabricacao" name="anoFabricacao" value="<%= anoFabricacao%>" min="1900" max="<%= java.time.Year.now().getValue()%>" required>
                    </div>

                    <div class="textfield">
                        <label for="anoModelo">Ano do Modelo:</label>
                        <input type="number" id="anoModelo" name="anoModelo" value="<%= anoModelo%>" min="1900" max="<%= java.time.Year.now().getValue() + 1%>" required>
                    </div>

                    <div class="textfield">
                        <label for="placa">Placa:</label>
                        <input type="text" id="placa" name="placa" value="<%= placa%>" maxlength="7" pattern="[A-Z]{3}[0-9][0-9A-Z][0-9]{2}" required>
                    </div>

                    <div class="textfield">
                        <label for="chassi">Número do Chassi:</label>
                        <input type="text" id="chassi" name="chassi" value="<%= chassi%>" maxlength="17" required>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary">Salvar Alterações</button>
                        <button type="button" class="btn btn-secondary" onclick="window.location.href = 'ListaVeiculo'">Cancelar</button>
                    </div>
                </form>
            </div>
        </main>

        <footer>
            <p>&copy; 2025 Agiliza Veículos. Todos os direitos reservados.</p>
        </footer>
    </body>
</html>

o que ha de errado
O ChatGPT disse:

Sua estrutura geral está muito bem feita — a lógica do Servlet, DAO e JSP está clara e bem organizada. Dado que você perguntou “o que há de errado?”, vamos analisar os pontos críticos que podem causar falhas na alteração do veículo, mesmo sem erro aparente no código:
✅ 1. Verifique se idVeiculo realmente está sendo enviado

No seu JSP, você usa:

<input type="hidden" name="idVeiculo" value="<%= idVeiculo%>">

✅ Isso está certo, mas só funciona se veiculo foi realmente setado no request.setAttribute("veiculo", veiculo) antes de redirecionar para VeiculoAlterarView.jsp.

Possível erro: se o JSP for acessado direto via link (sem passar pelo servlet), o objeto veiculo será null e o idVeiculo não será preenchido.

🔧 Solução: certifique-se de que o servlet que leva à página de alteração faça algo assim:

int id = Integer.parseInt(request.getParameter("idVeiculo"));
Veiculo veiculo = manterVeiculo.buscarPorId(id);
request.setAttribute("veiculo", veiculo);
request.getRequestDispatcher("VeiculoAlterarView.jsp").forward(request, response);

✅ 2. Ação do <form> deve corresponder ao mapeamento do Servlet

Você usa:

<form action="AltVeiculo" method="post">

Isso está correto se o seu servlet de alteração estiver corretamente mapeado como:

@WebServlet(name = "AltVeiculo", urlPatterns = {"/AltVeiculo"})

❗ Se estiver com nome diferente, o form pode nunca chegar ao servlet certo.
✅ 3. Você está tratando exceções com catch muito genérico no DAO

No método alterarVeiculo, você tem:

} catch (Exception e) {
    System.out.println("Erro ao fechar recursos (alterarVeiculo): " + e.getMessage());
    return false;
}

Problema: Esse catch pode esconder erros relevantes como:

    Chave estrangeira inválida

    Conexão não aberta corretamente

    Coluna errada no SQL

🔧 Sugestão de melhoria:

} catch (SQLException e) {
    System.out.println("Erro ao alterar veículo: " + e.getMessage());
    e.printStackTrace();
    return false;
}

✅ 4. Debug: veja se linhasAfetadas > 0

Você pode ter escrito o SQL corretamente, mas o WHERE idVeiculo = ? pode não encontrar nenhum registro se idVeiculo não estiver correto.

🧪 Teste de debug:

System.out.println("ID recebido para alteração: " + v.getIdVeiculo());
System.out.println("Linhas afetadas: " + linhasAfetadas);

✅ 5. Verifique se CategoriaVeiculo.valueOf(categoriaStr) não lança exceção

Esse trecho:

veiculo.setCategoriaVeiculo(CategoriaVeiculo.valueOf(categoriaStr));

Pode lançar IllegalArgumentException se:

    A categoriaStr vier como "Carro" (letra maiúscula na primeira letra) — e o enum espera "CARRO".

🧠 Melhor forma:

veiculo.setCategoriaVeiculo(CategoriaVeiculo.valueOf(categoriaStr.toUpperCase()));

✅ 6. Certifique-se de que os dados vieram corretos do formulário

Use logs ou prints no servlet para verificar:

System.out.println("Categoria: " + categoriaStr);
System.out.println("Marca: " + marca);
System.out.println("ID Veículo: " + idVeiculo);

✅ 7. Valide a existência do veículo no banco antes de alterar

Se estiver usando um DAO como:

Veiculo veiculo = manterVeiculo.buscarPorId(idVeiculo);

Verifique se ele não está retornando null antes de tentar popular o formulário ou alterar.
✅ RESUMO DO CHECKLIST
Item	Verificação	Solução
idVeiculo não enviado	Verifique se veiculo está no request	Setar via servlet antes
form action errado	Verifique mapeamento do servlet	Corrigir para /AltVeiculo
Exceções no DAO	catch genérico	Trocar por SQLException
Nenhuma linha alterada	Verificar valor de idVeiculo	Printar/logar ID
Enum inválido	valueOf() quebra	Usar toUpperCase()
Campos nulos no formulário	Input errado ou null	Preencher corretamente via JSP

Se quiser, posso revisar o servlet de redirecionamento para a página VeiculoAlterarView.jsp também — talvez o veiculo não esteja sendo carregado corretamente.

Me diga o que aparece no console ou navegador ao tentar alterar o veículo, e posso te ajudar mais diretamente!
Você disse:
observe a servlet:     try {
                ManterVeiculo veiculoDao = new ManterVeiculo();
                List<Veiculo> lista = veiculoDao.listarVeiculos();

                request.setAttribute("veiculos", lista);
            } catch (Exception e) {
                request.setAttribute("mensagemErro", "Erro ao listar veículos: " + e.getMessage());
            }
            request.getRequestDispatcher("VeiculoListaView.jsp").forward(request, response);
        }
    }

o frontend <%-- 
    Document   : VeiculoListaView
    Created on : 25 de mai. de 2025, 19:49:13
    Author     : thiagosilva
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="Controller.Veiculo" %>
<%@ page import="java.util.List" %>
<%@ page import="Enuns.CategoriaVeiculo" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Catálogo de Veículos - Agiliza Veículos</title>
        <link rel="icon" type="image/x-icon" href="assets/img/antonios-logo.png">
        <!-- <link rel="stylesheet" href="assets/style/index.css"/> -->
        <link rel="stylesheet" href="assets/style/VeiculoListaView.css"/>
    </head>
    <body>


        <header>
            <nav class="navbar">
                <div class="logo">
                    <a href="index.jsp">Agiliza Veículos</a>
                </div>
                <ul class="nav-links">
                    <li><a href="index.jsp">Início</a></li>
                    <li><a href="VeiculoListaView.jsp">Catálogo</a></li> 
                    <li><a href="sobre.jsp">Sobre Nós</a></li>
                    <li><a href="contato.jsp">Contato</a></li>
                    <li><a href="UsuarioAlterarView.jsp">Alterar dados</a></li>
                </ul>
                <div class="nav-auth-buttons">
                    <%
                        boolean logado = session.getAttribute("nome") != null;
                        Enuns.Acesso acessoUsuario = (Enuns.Acesso) session.getAttribute("acesso");
                        boolean isAdmin = logado && acessoUsuario == Enuns.Acesso.Administrador;
                    %>

                    <% if (logado) {%>
                    <a href="DeslogarUsuario" class="btn btn-logout">Sair</a>
                    <%} else {%>
                    <a href="UsuarioLoginView.jsp" class="btn btn-login-nav">Login</a>
                    <a href="UsuarioCadastroView.jsp" class="btn btn-secondary btn-register-nav">Cadastre-se</a>
                    <%}%>
                </div>
            </nav>
        </header>

        <main class="content-wrapper">
            <div class="page-header">
                <h2>Nosso Catálogo de Veículos</h2>
            </div>

            <% String mensagemErro = (String) request.getAttribute("mensagemErro");
                String mensagemSucesso = (String) request.getAttribute("mensagemSucesso");
            %>
            <% if (mensagemErro != null) {%>
            <div class="info-message error-message">
                <%= mensagemErro%>
            </div>
            <% } else if (mensagemSucesso != null) {%>
            <div class="info-message success-message">
                <%= mensagemSucesso%>
            </div>
            <% }%>

            <div class="vehicle-grid">
                <c:choose>
                    <c:when test="${not empty veiculos}"> 
                        <c:forEach var="v" items="${veiculos}">
                            <div class="vehicle-card">
                                <div class="card-image">
                                    <%-- <img src="assets/img/${v.categoriaVeiculo.name().toLowerCase()}.png" alt="${v.modelo}"> --%>
                                    <img src="assets/img/default-car.png" alt="${v.modelo}"> <%-- Imagem padrão --%>
                                </div>
                                <div class="card-details">
                                    <h3>${v.marca} ${v.modelo}</h3>
                                    <p><strong>Categoria:</strong> ${v.categoriaVeiculo}</p>
                                    <p><strong>Cor:</strong> ${v.cor}</p>
                                    <p><strong>Motorização:</strong> ${String.format("%.1f", v.motorizacao)} L</p> <%-- Formata float para 1 casa decimal --%>
                                    <p><strong>Peso:</strong> ${String.format("%.0f", v.pesoKg)} kg</p>
                                    <p><strong>Assentos:</strong> ${v.assentos}</p>
                                    <p><strong>Tanque:</strong> ${String.format("%.1f", v.capacidadeTanque)} L</p>
                                    <p><strong>Ano:</strong> ${v.anoFabricacao}/${v.anoModelo}</p>
                                    <p><strong>Placa:</strong> ${v.placa}</p>
                                    <p><strong>Chassi:</strong> ${v.chassi}</p>
                                    <a href="#" class="btn btn-details">Ver Detalhes</a>
                                </div>
                                <% if (isAdmin) { %>
                                <div class="admin-buttons">
                                    <a href="AltVeiculo?idVeiculo=${v.idVeiculo}" class="btn car-btn-edit">Alterar</a>
                                    <a href="DelVeiculo?idVeiculo=${v.idVeiculo}" class="btn car-btn-delete"
                                       onclick="return confirm('Tem certeza que deseja excluir este veículo?');">Excluir</a>
                                </div>
                                <% }%>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <p class="no-vehicles-message">Nenhum veículo cadastrado ainda. <a href="VeiculoCadastroView.jsp">Cadastre um novo veículo aqui.</a></p>
                    </c:otherwise>
                </c:choose>
            </div>

            <div style="text-align:center; margin-top: 30px; margin-bottom: 30px;">
                <a href="VeiculoCadastroView.jsp" class="btn btn-primary">Cadastrar novo veículo</a>
            </div>
        </main>

        <footer>
            <p>&copy; 2025 Agiliza Veículos. Todos os direitos reservados.</p>
        </footer>
    </body>
</html>

e os metodos: /*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import Controller.Veiculo;
import Enuns.CategoriaVeiculo;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author thiagosilva
 */
public class ManterVeiculo extends DAO {

    public boolean inserirVeiculo(Veiculo veiculo) throws Exception {
        try {
            abrirBanco();
            String sql = "INSERT INTO veiculo (categoriaVeiculo, marca, modelo, cor, rodas, motorizacao, pesoKg, capacidadeTanque, assentos, anoFabricacao, anoModelo, placa, chassi) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            pst = con.prepareStatement(sql);
            pst.setString(1, veiculo.getCategoriaVeiculo().name());
            pst.setString(2, veiculo.getMarca());
            pst.setString(3, veiculo.getModelo());
            pst.setString(4, veiculo.getCor());
            pst.setInt(5, veiculo.getRodas());
            pst.setFloat(6, veiculo.getMotorizacao());
            pst.setFloat(7, veiculo.getPesoKg());
            pst.setFloat(8, veiculo.getCapacidadeTanque());
            pst.setInt(9, veiculo.getAssentos());
            pst.setInt(10, veiculo.getAnoFabricacao());
            pst.setInt(11, veiculo.getAnoModelo());
            pst.setString(12, veiculo.getPlaca());
            pst.setString(13, veiculo.getChassi());

            int linhasAfetadas = pst.executeUpdate();

            return linhasAfetadas > 0;
        } catch (Exception e) {
            System.out.println("Erro SQL ao inserir veiculo: " + e.getMessage());
            e.printStackTrace();
            return false;

        } finally {
            try {
                fecharBanco();
            } catch (Exception e) {
                System.out.println("Erro ao fechar recursos (inserirVeiculo): " + e.getMessage());
            }
        }
    }

    public List<Veiculo> listarVeiculos() throws Exception {
        List<Veiculo> lista = new ArrayList<>();
        try {
            abrirBanco();
            String sql = "SELECT * FROM veiculo order by idVeiculo desc"; //trazendo os veiculos recem inseridos primeiro na lista
            pst = con.prepareStatement(sql);
            rs = pst.executeQuery();

            while (rs.next()) {
                Veiculo v = new Veiculo();
                v.setIdVeiculo(rs.getInt("idVeiculo"));
                v.setCategoriaVeiculo(CategoriaVeiculo.valueOf(rs.getString("categoriaVeiculo")));
                v.setMarca(rs.getString("marca"));
                v.setModelo(rs.getString("modelo"));
                v.setCor(rs.getString("cor"));
                v.setRodas(rs.getInt("rodas"));
                v.setMotorizacao(rs.getFloat("motorizacao"));
                v.setPesoKg(rs.getFloat("pesoKg"));
                v.setCapacidadeTanque(rs.getFloat("capacidadeTanque"));
                v.setAssentos(rs.getInt("assentos"));
                v.setAnoFabricacao(rs.getInt("anoFabricacao"));
                v.setAnoModelo(rs.getInt("anoModelo"));
                v.setPlaca(rs.getString("placa"));
                v.setChassi(rs.getString("chassi"));
                lista.add(v);
            }
            fecharBanco();
        } catch (Exception e) {
            System.out.println("Erro " + e.getMessage());
        }
        return lista;
    }

    public Veiculo buscarIdVeiculo(int idVeiculo) {

        try {
            Veiculo veiculo = new Veiculo();
            abrirBanco();
            String query = "SELECT idVeiculo, categoriaVeiculo, marca, modelo, cor, rodas, motorizacao, pesoKg, capacidadeTanque, assentos, anoFabricacao, anoModelo, placa, chassi FROM veiculo WHERE idVeiculo = ?";
            pst = con.prepareStatement(query);
            pst.setInt(1, idVeiculo);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                veiculo.setIdVeiculo(rs.getInt("idVeiculo"));

                try {
                    veiculo.setCategoriaVeiculo(CategoriaVeiculo.valueOf(rs.getString("categoriaVeiculo")));
                } catch (IllegalArgumentException e) {
                    System.err.println("Categoria inválida para o veículo ID " + idVeiculo + ": '" + rs.getString("categoriaVeiculo") + "'.");
                    veiculo.setCategoriaVeiculo(CategoriaVeiculo.CARRO); // Valor padrão
                }

                veiculo.setMarca(rs.getString("marca"));
                veiculo.setModelo(rs.getString("modelo"));
                veiculo.setCor(rs.getString("cor"));
                veiculo.setRodas(rs.getInt("rodas"));
                veiculo.setMotorizacao(rs.getFloat("motorizacao"));
                veiculo.setPesoKg(rs.getFloat("pesoKg"));
                veiculo.setCapacidadeTanque(rs.getFloat("capacidadeTanque"));
                veiculo.setAssentos(rs.getInt("assentos"));
                veiculo.setAnoFabricacao(rs.getInt("anoFabricacao"));
                veiculo.setAnoModelo(rs.getInt("anoModelo"));
                veiculo.setPlaca(rs.getString("placa"));
                veiculo.setChassi(rs.getString("chassi"));

                return veiculo;
            }

            fecharBanco();
        } catch (Exception e) {
            System.err.println("Erro SQL ao buscar veículo por ID: " + e.getMessage());
            e.printStackTrace();
        } finally {
            System.out.println("Execução da Query de busca por ID (veículo) finalizada");
        }

        return null;
    }

    public boolean alterarVeiculo(Veiculo v) {
        try {
            abrirBanco();
            String query = "UPDATE veiculo SET categoriaVeiculo = ?, marca = ?, modelo = ?, cor = ?, rodas = ?, "
                    + "motorizacao = ?, pesoKg = ?, capacidadeTanque = ?, assentos = ?, "
                    + "anoFabricacao = ?, anoModelo = ?, placa = ?, chassi = ? "
                    + "WHERE idVeiculo = ?";

            pst = con.prepareStatement(query);
            pst.setString(1, v.getCategoriaVeiculo().name()); // Enum convertido para String
            pst.setString(2, v.getMarca());
            pst.setString(3, v.getModelo());
            pst.setString(4, v.getCor());
            pst.setInt(5, v.getRodas());
            pst.setFloat(6, v.getMotorizacao());
            pst.setFloat(7, v.getPesoKg());
            pst.setFloat(8, v.getCapacidadeTanque());
            pst.setInt(9, v.getAssentos());
            pst.setInt(10, v.getAnoFabricacao());
            pst.setInt(11, v.getAnoModelo());
            pst.setString(12, v.getPlaca());
            pst.setString(13, v.getChassi());
            pst.setInt(14, v.getIdVeiculo());

            int linhasAfetadas = pst.executeUpdate();

            fecharBanco();
            return linhasAfetadas > 0;

        } catch (Exception e) {
            System.out.println("Erro ao alterar veículo: " + e.getMessage());
            e.printStackTrace();
            return false;
        }

    }

    public void deletarVeiculo(Veiculo veiculo) {
        try {
            abrirBanco();
            String query = "DELETE FROM veiculo WHERE idVeiculo = ?";
            pst = con.prepareStatement(query);
            pst.setInt(1, veiculo.getIdVeiculo());
            pst.execute();
            fecharBanco();

        } catch (Exception e) {
            System.out.println("Erro " + e.getMessage());
        }
    }
}

preciso que ao clicar em ver detalhes, o usuario seja direcionado para uma pagina sobre o veiculo clicado que retorne um select das informações do dveiculo para uma possivel compra final 
O ChatGPT disse:

Para implementar o comportamento de "Ver Detalhes" e exibir uma página com as informações completas do veículo, siga este passo a passo:
✅ 1. Crie a Servlet VerVeiculo

Essa servlet buscará os dados do veículo com base no idVeiculo enviado pela URL:

@WebServlet("/VerVeiculo")
public class VerVeiculo extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int idVeiculo = Integer.parseInt(request.getParameter("idVeiculo"));

            ManterVeiculo dao = new ManterVeiculo();
            Veiculo veiculo = dao.buscarIdVeiculo(idVeiculo);

            if (veiculo != null) {
                request.setAttribute("veiculo", veiculo);
                request.getRequestDispatcher("VeiculoDetalhesView.jsp").forward(request, response);
            } else {
                request.setAttribute("mensagemErro", "Veículo não encontrado.");
                request.getRequestDispatcher("VeiculoListaView.jsp").forward(request, response);
            }

        } catch (Exception e) {
            request.setAttribute("mensagemErro", "Erro ao buscar veículo: " + e.getMessage());
            request.getRequestDispatcher("VeiculoListaView.jsp").forward(request, response);
        }
    }
}

✅ 2. Altere o botão "Ver Detalhes" no VeiculoListaView.jsp

Troque:

<a href="#" class="btn btn-details">Ver Detalhes</a>

Por:

<a href="VerVeiculo?idVeiculo=${v.idVeiculo}" class="btn btn-details">Ver Detalhes</a>

✅ 3. Crie a JSP VeiculoDetalhesView.jsp

Crie uma nova página JSP que mostre os detalhes completos do veículo:

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="Controller.Veiculo" %>

<%
    Veiculo v = (Veiculo) request.getAttribute("veiculo");
    if (v == null) {
        response.sendRedirect("VeiculoListaView.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Detalhes do Veículo</title>
    <link rel="stylesheet" href="assets/style/VeiculoDetalhesView.css">
</head>
<body>

    <header>
        <h1>Detalhes do Veículo</h1>
    </header>

    <main>
        <div class="vehicle-details-card">
            <img src="assets/img/default-car.png" alt="Imagem do Veículo">
            <h2><%= v.getMarca() %> <%= v.getModelo() %></h2>
            <ul>
                <li><strong>Categoria:</strong> <%= v.getCategoriaVeiculo() %></li>
                <li><strong>Cor:</strong> <%= v.getCor() %></li>
                <li><strong>Motorização:</strong> <%= v.getMotorizacao() %> L</li>
                <li><strong>Peso:</strong> <%= v.getPesoKg() %> kg</li>
                <li><strong>Assentos:</strong> <%= v.getAssentos() %></li>
                <li><strong>Tanque:</strong> <%= v.getCapacidadeTanque() %> L</li>
                <li><strong>Ano:</strong> <%= v.getAnoFabricacao() %>/<%= v.getAnoModelo() %></li>
                <li><strong>Placa:</strong> <%= v.getPlaca() %></li>
                <li><strong>Chassi:</strong> <%= v.getChassi() %></li>
            </ul>

            <div class="actions">
                <a href="VeiculoListaView.jsp" class="btn">Voltar ao Catálogo</a>
                <a href="IniciarCompra?idVeiculo=<%= v.getIdVeiculo() %>" class="btn btn-primary">Comprar</a>
            </div>
        </div>
    </main>

    <footer>
        <p>&copy; 2025 Agiliza Veículos</p>
    </footer>
</body>
</html>

✅ 4. (Opcional) Criar Servlet IniciarCompra

Você pode criar uma nova Servlet ou redirecionar para uma página de compra com os dados do veículo já carregados.
Resultado

Agora, quando o usuário clicar em "Ver Detalhes", ele será redirecionado para a página VeiculoDetalhesView.jsp, com todas as informações daquele veículo.

Se quiser, posso te ajudar a criar a IniciarCompra ou até uma simulação de "Finalizar Compra". Deseja isso?
Você disse:
desejo sim
O ChatGPT disse:

O documento VeiculoDetalhesView.jsp foi criado com sucesso. Se quiser adicionar novos campos, mudar o layout ou integrar novos dados à exibição do veículo, é só me dizer!
Você disse:
preciso do css tambem
O ChatGPT disse:


O ChatGPT pode cometer erros. Considere verificar informações importantes.
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
39
40
41
42
43
44
45
46
47
48
49
50
51
52
53
54
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="Controller.Veiculo" %>
<%@ page import="Enuns.CategoriaVeiculo" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Detalhes do Veículo</title>
    <link rel="stylesheet" href="assets/style/VeiculoDetalhesView.css"/>
</head>
<body>
    <header>
        <h1>Detalhes do Veículo</h1>
        <a href="VeiculoListaView.jsp">Voltar ao Catálogo</a>
    </header>

    <main>
        <c:choose>
            <c:when test="${not empty veiculo}">
                <div class="vehicle-detail-card">
                    <h2>${veiculo.marca} ${veiculo.modelo}</h2>
                    <p><strong>Categoria:</strong> ${veiculo.categoriaVeiculo}</p>
                    <p><strong>Cor:</strong> ${veiculo.cor}</p>
                    <p><strong>Rodas:</strong> ${veiculo.rodas}</p>
                    <p><strong>Motorização:</strong> ${veiculo.motorizacao} L</p>
                    <p><strong>Peso:</strong> ${veiculo.pesoKg} kg</p>
                    <p><strong>Capacidade do Tanque:</strong> ${veiculo.capacidadeTanque} L</p>
                    <p><strong>Assentos:</strong> ${veiculo.assentos}</p>
                    <p><strong>Ano de Fabricação/Modelo:</strong> ${veiculo.anoFabricacao}/${veiculo.anoModelo}</p>
                    <p><strong>Placa:</strong> ${veiculo.placa}</p>
                    <p><strong>Chassi:</strong> ${veiculo.chassi}</p>

                    <div style="margin-top: 20px;">
                        <form action="IniciarCompra" method="post">
                            <input type="hidden" name="idVeiculo" value="${veiculo.idVeiculo}" />
                            <input type="submit" value="Iniciar Compra" class="btn btn-primary"/>
                        </form>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <p>Veículo não encontrado. <a href="VeiculoListaView.jsp">Voltar ao catálogo</a></p>
            </c:otherwise>
        </c:choose>
    </main>

    <footer>
        <p>&copy; 2025 Agiliza Veículos</p>
    </footer>
</body>
</html>