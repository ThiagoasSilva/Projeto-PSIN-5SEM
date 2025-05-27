-- drop schema agilizaVeiculos;
create schema agilizaVeiculos;
use agilizaVeiculos;

show tables;

create table usuario(
	idUsuario int auto_increment,
	acesso enum("Administrador","Cliente"),
	email varchar(255),
    senha varchar(255),
	cpf varchar(16),
	rg varchar(16), -- por alguma razão o RG está saindo como 'rq' no select, mesmo verificadas a ortografia no banco e classe.
	nome varchar(255),
	idade int,
	nascimento date,
		primary key(idUsuario)
);

select * from usuario;


create table usuarioTelefone(
	idTelefone int auto_increment,
	idUsuario int,
	telefone varchar(11),
		primary key(idTelefone),
		foreign key(idUsuario) references usuario(idUsuario)
);

create table usuarioEndereco(
	idEndereco int auto_increment,
	idUsuario int,
	numero int,
	bairro varchar(50) not null,
	cidade varchar(50) not null,
	estado varchar(50) not null,
	complemento varchar(255) not null,
	cep varchar(11) not null,
		primary key(idendereco),
		foreign key(idUsuario) references usuario(idUsuario)
);

-- VEÍCULO --
alter table veiculo rename column categoria to categoriaVeiculo;
desc veiculo;
create table veiculo(
	idVeiculo int auto_increment,
	categoriaVeiculo varchar(20),
	marca varchar(30) not null,
	modelo varchar(30) not null,
	cor varchar(30)not null,
	rodas int not null,
	motorizacao float not null,
	peso_Kg float not null,
	capacidadeTanque_L float not null,
	assentos int not null,
	anoFabricacao year not null,
	anoModelo year not null,
	placa varchar(8) unique not null,
	chassi varchar(17) unique not null,
		primary key(idVeiculo)
);

select * from veiculo;

-- LOCAÇÃO --
create table locacao(
	idLocacao int auto_increment,
	idVeiculo int not null,
    idUsuario int,
    situacao enum("Disponível","Indisponível","Locado","Reservado","Em manutenção","Outros") not null,
    dataLocacao datetime default CURRENT_TIMESTAMP,
    dataDevolvido datetime not null,
    dataDevolucao datetime not null,
    devolvido bool not null,
		primary key(idLocacao),
        foreign key(idVeiculo) references veiculo(idVeiculo),
        foreign key(idUsuario) references usuario(idUsuario)
);

create table locacaoPagamento(
	idLocacaoPagamento int auto_increment,
    idLocacao int not null,
    idUsuario int not null,
    formaPagamento enum("Débito", "Crédito", "Pix", "Dinheiro", "Transferência", "Boleto"),
    dataPagamento datetime default current_timestamp,
    parcelas int not null,
    valorLocacao decimal(15,2) not null,
		primary key(idLocacaoPagamento),
        foreign key(idLocacao) references locacao(idLocacao),
        foreign key(idUsuario) references usuario(idUsuario)
);
