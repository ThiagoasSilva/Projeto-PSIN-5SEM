<%-- 
    Document   : UsuarioAlterarView
    Created on : 25 de mai. de 2025, 05:15:33
    Author     : thiagosilva
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Controller.Usuario"%>
<%@page import="Enuns.Acesso"%>
<%@page import="java.sql.Date"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Alterar Dados do Usuário - Agiliza Veículos</title>
        <link rel="stylesheet" href="style/index.css"/>
        <link rel="stylesheet" href="style/VeiculoCadastroView.css"/>
    </head>
    <body>
        <header>
            <nav class="navbar">
                <div class="logo">
                    <a href="index.jsp">Agiliza Veículos</a>
                </div>
                <ul class="nav-links">
                    <li><a href="index.jsp">Início</a></li>
                    <li><a href="catalogo.jsp">Catálogo</a></li>
                    <li><a href="sobre.jsp">Sobre Nós</a></li>
                    <li><a href="contato.jsp">Contato</a></li>
                    <li><a href="UsuarioAlterarView.jsp">Alterar dados</a></li>
                </ul>
                <div class="nav-auth-buttons">
                    <%
                        boolean logado = session.getAttribute("nome") != null;
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
            <div class="form-container">
                <div class="form-header">
                    <h2>Alterar Meus Dados</h2>
                </div>

                <%-- Exibir mensagem de erro ou sucesso --%>
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
                <% } %>

                <%
                    // Recupera o objeto Usuario do request (vindo de um Servlet)
                    Usuario usuario = (Usuario) request.getAttribute("usuario");
                    String email = "";
                    String cpf = "";
                    String rg = "";
                    String nome = "";
                    int idade = 0;
                    String nascimentoStr = "";
                    String acesso = ""; // Para o radio button, pegaremos o nome da enum

                    if (usuario != null) {
                        email = usuario.getEmail() != null ? usuario.getEmail() : "";
                        cpf = usuario.getCpf() != null ? usuario.getCpf() : "";
                        rg = usuario.getRg() != null ? usuario.getRg() : "";
                        nome = usuario.getNome() != null ? usuario.getNome() : "";
                        idade = usuario.getIdade();
                        if (usuario.getNascimento() != null) {
                            // Formata a data para o input type="date" (yyyy-MM-dd)
                            nascimentoStr = usuario.getNascimento().toLocalDate().format(DateTimeFormatter.ISO_LOCAL_DATE);
                        }
                        // Pega o nome da enum Acesso para preencher o radio button
                        acesso = usuario.getAcesso() != null ? usuario.getAcesso().name() : "";
                    } else {
                        // Se o objeto usuario for null, pode ser que o usuário não esteja logado
                        // ou o Servlet de carregamento não foi acessado.
                        // Redirecionar para login ou exibir mensagem de erro.
                        // Para este exemplo, deixamos os campos vazios.
                    }
                %>

                <form action="AltUsuario" method="post" class="cadastro-form">
                    <%-- idUsuario não é um campo de entrada, mas pode ser passado como hidden --%>
                    <% if (usuario != null) {%>
                    <input type="hidden" name="idUsuario" value="<%= usuario.getIdUsuario()%>">
                    <% }%>

                    <div class="textfield">
                        <label for="nome">Nome Completo:</label>
                        <input type="text" id="nome" name="nome" value="<%= nome%>" placeholder="Seu nome completo" required>
                    </div>

                    <div class="textfield">
                        <label for="email">Email:</label>
                        <input type="email" id="email" name="email" value="<%= email%>" placeholder="seuemail@exemplo.com" required>
                    </div>

                    <div class="textfield">
                        <label for="senha">Nova Senha (deixe em branco para não alterar):</label>
                        <input type="password" id="senha" name="senha" placeholder="********">
                    </div>

                    <div class="textfield">
                        <label for="cpf">CPF:</label>
                        <input type="text" id="cpf" name="cpf" value="<%= cpf%>" placeholder="000.000.000-00" pattern="\d{3}\.\d{3}\.\d{3}-\d{2}" title="Formato: 000.000.000-00" required>
                    </div>

                    <div class="textfield">
                        <label for="rg">RG:</label>
                        <input type="text" id="rg" name="rg" value="<%= rg%>" placeholder="00.000.000-0" pattern="\d{2}\.\d{3}\.\d{3}-\d{1}" title="Formato: 00.000.000-0" required>
                    </div>

                    <div class="textfield">
                        <label for="idade">Idade:</label>
                        <input type="number" id="idade" name="idade" value="<%= idade > 0 ? idade : ""%>" placeholder="Sua idade" min="0" required>
                    </div>

                    <div class="textfield">
                        <label for="nascimento">Data de Nascimento:</label>
                        <input type="date" id="nascimento" name="nascimento" value="<%= nascimentoStr%>" required>
                    </div>

                    <div class="textfield">
                        <label>Tipo de Acesso:</label>
                        <div class="radio-options">
                            <input type="radio" id="acesso_cliente" name="acesso" value="Cliente" <%= "Cliente".equals(acesso) ? "checked" : ""%>>
                            <label for="acesso_cliente">Cliente</label>

                            <input type="radio" id="acesso_administrador" name="acesso" value="Administrador" <%= "Administrador".equals(acesso) ? "checked" : ""%>>
                            <label for="acesso_administrador">Administrador</label>
                        </div>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary">Salvar Alterações</button>
                        <button type="button" class="btn btn-secondary" onclick="window.location.href = 'index.jsp'">Cancelar</button>
                    </div>
                </form>
            </div>
        </main>

        <footer>
            <p>&copy; 2025 Agiliza Veículos. Todos os direitos reservados.</p>
        </footer>
    </body>
</html>