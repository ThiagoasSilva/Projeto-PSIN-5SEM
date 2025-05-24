<%-- 
    Document   : UsuarioCadastroView
    Created on : 21 de mai. de 2025, 21:15:04
    Author     : thiagosilva
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cadastre-se</title>
        <link rel="stylesheet" href="style/UsuarioCadastroView.css">
    </head>

    <body>
        <div class="main-login">
            <div class="left-login">
                <h1>Faça seu cadastro</h1>
                <img src="img/login-img.svg" class="left-login-img">
                <!-- src https://storyset.com/illustration/grammar-correction/rafiki -->
            </div>
            <div class="right-login">
                <div class="card-login">
                    <h1>Cadastre-se</h1>
                    <form method="post" action="LoginUsuario">

                        <div class="textfield">
                            <label for="cpf">CPF</label>
                            <input type="text" id="cpf" name="cpf" placeholder="Insira seu CPF">
                        </div>
                                       
                        <!--
                        <div class="textfield">
                            <label for="nome">Nome</label>
                        <input type="text" name="nome" placeholder="Insira seu Nome">
                    </div>
                        -->
                        <div class="textfield">
                            <label for="email">Email</label>
                            <input type="email" id="email" name="email" placeholder="Insira seu Email">
                        </div>

                        <div class="textfield">
                            <label for="senha">Senha</label>
                            <input type="password" id="senha" name="senha" placeholder="Insira sua Senha">
                        </div>

                        <!-- <button class="btn-login">Cadastrar</button>-->
                        <button type="submit" class="btn-login" value="Cadastrar">Cadastrar</button>
                        <button type="reset" value="Limpar">Limpar</button>

                    </form>
                </div>
            </div>

    </body>
</html>