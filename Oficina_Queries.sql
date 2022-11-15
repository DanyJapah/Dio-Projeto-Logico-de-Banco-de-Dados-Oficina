-- inserção de dados e Queries
use ecommerce;

show tables;
-- -----------------------------------------------------
-- idCliente, Nome,CPF, Endereço
-- -----------------------------------------------------
insert into Cliente (Nome,CPF, Endereco) 
	values('Roberta',98745631,'avenidade koller 19, Centro - Cidade das flores'),
			('Maria',12346789, 'rua silva de prata 29, Carangola - Cidade das flores'),
		    ('Matheus',987654321,'rua alemeda 289, Centro - Cidade das flores'),
			('Ricardo',45678913,'avenida alemeda vinha 1009, Centro - Cidade das flores'),
			('Julia',789123456,'rua lareijras 861, Centro - Cidade das flores'),
			('Isabela',654789123,'rua alemeda das flores 28, Centro - Cidade das flores');

-- -----------------------------------------------------
-- idVeiculo, Ano de Fabricação, Modelo, Placa
-- -----------------------------------------------------
insert into Veiculo (Ano_Fabricacao, Modelo, Placa)
	values(2010, 'onix', 'ABS-3412'),
			(2022, 'Gol', 'PBA2014'),
			(1986, ' Fox/CrossFox', 'ZXW-9087'),
			(2004, 'Celta', 'BNM-0034'),
			(2013, ' HB20', 'YU3G90'),
			(2000, 'Spin', 'WLS-1020');

select * from cliente;
select * from Veiculo;

-- -----------------------------------------------------
-- idServiço, Tipo de Serviço, Valor do Serviço
-- -----------------------------------------------------
insert into Servico (Tipo_Servico, Valor_Servico)
	values ('Revisão Periodica', 300.00),
			('Conserto', 200.00);

-- -----------------------------------------------------
-- idPeça, Descrição, Valor, Quantidade, Estado
-- -----------------------------------------------------
insert into Peca(Descricao, Valor, Quantidade, Estado)
	values('Kit lâmpada do farol', 137.16, 30, 'Nova'),
			('Alarme para automóveis', 284.50, 20, 'Novo'),
			('Capa de carro', 100.00, 5, 'Semi Nova'),
			('Suporte da placa', 50.00, 2, 'Usada'),
			('Lâmpada do farol principal', 15.00, 50, 'Nova'),
			('Macaco' , 40.00, 3, 'Usado'),
			('Buzina automotiva', 65.00, 30, 'Nova'),
			('Óleo do motor', 33.90, 100, 'Novo');
			

  -- -----------------------------------------------------
  -- idMecanico, Nome, Endereco, Telefone, Especialidade, CPF
  -- -----------------------------------------------------
  insert into Mecanico_Funcionario(Nome, Endereco, Telefone, Especialidade, CPF)
	values ('Antônio Jose', 'Rio de Janeiro - Centro', 219946287,'Estética Automotiva', 14202301236),
			('Alysson Santos', 'São Gonçalo - 590', 21988564512, 'Freios; Amortecedores e Suspensões'),
			('Jose Leandro', 'São Paulo', 1198657484 ' Especialidade em Carros Antigos', 00123678900),
			('Claudio Antônio', 'Duque de Caxias - 90', 219567895, 'Elétrica e Eletrônica de Automóveis', 01234563278);
			
			
  -- -----------------------------------------------------
  -- N_Orcamento, D_Orcamento, Tipo_Servico, Valor, Autorizada, Status, D_Validade, idVeiculo, idClient, idServico, idPeca
  -- -----------------------------------------------------			
insert into OS_Orcamento (N_Orcamento, D_Orcamento, Tipo_Servico, Valor, Autorizada, Status, D_Validade, idVeiculo, idCliente, idServico, idPeca)	
			values(001, 20221001, 1, 300.00, 1, 'Entregue' ,20221001,1, 1, 1, 8)	
				(002, 20201101, 2, 500.00, 0, 'Aguardando Autorização', 20221115, 2, 2, 2, 1)
				(003, 20221003, 1, 300.00, 1, 'Entregue' ,20221003,5, 5, 1, 8);
			
  `
	-- -----------------------------------------------------
  -- idOS, Valor, D_Inicio, Status, D_Conclusão, OS_NOrcamento, OS_idVeiculo,OS_idVeiculo,OS_idCliente, OS_idServico,OS_idPeca,idMecanico	
  -- -----------------------------------------------------		
	insert into Ordem_Servico(Valor, D_Inicio, Status, D_Conclusão, OS_NOrcamento,OS_idVeiculo,OS_idCliente, OS_idServico,OS_idPeca,idMecanico)
		values(300.00, 20221001, 1, 'Concluido' ,20221001,001, 1, 1, 1, 8 , 1),
				(500.00, 20221001, 1, 'Concluido' ,20221001,002, 2, 2, 2, 2 , 2),
				(300.00, 20221001, 1, 'Concluido' ,20221001,003, 3, 3, 3, 3 , 3);
			
			


select count(*) from cliente;
select * from cliente c, Ordem_Servico o where c.idCliente = OS_idCliente;

select Nome, OS_idCliente, Status from cliente c, Ordem_Servico o where c.idCliente = OS_idCliente;


insert into OS_Orcamento (N_Orcamento, D_Orcamento, Tipo_Servico, Valor, Autorizada, Status, D_Validade, idVeiculo, idClient, idServico, idPeca) values 
							 (004, 20201001, 4, 500.00, 0, 'Aguardando Autorização', 20221015, 4, 4, 2, 1);
                             
select count(*) from cliente c, Ordem_Servico o 
			where c.idCliente = OS_idCliente;

select * from OS_idCliente;

-- recuperação de Orçamento com Peças associado
select * from cliente c 
				inner join OS_Orcamento o ON c.idCliente = o.idCliente
                inner join peca p on p.idPeca = o.idPeca
		group by idCliente; 
        
-- Recuperar quantos OS foram realizados pelos clientes?
select c.idCliente, Npme, count(*) as Number_of_Ordem_Servico from cliente c 
				inner join Ordem_Servico o ON c.idCliente = o.OS_idCliente
		group by idCliente; 