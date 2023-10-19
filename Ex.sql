---1) Crie um procedimento chamado prc_insere_produto para todas as colunas da tabela de produtos,valide: Se o nome do produto tem mais de 3 caracteres e não contêm números (0 a 9). --
create or replace procedure prc_insere_produto(
p_nome_prod varchar2,
p_quantidade_prod varchar2,
p_disponibilidade varchar2)
as 
begin
if length(p_nome_prod) <= 3 or regexp_like (p_nome_prod, '[0-9]') then
raise_application_error (-20000, 'O nome do produto não pode conter números e nem mais que 3 caracteres');
end if;
insert into produto(nome_produto, quantidade_produto, disponibilidade) values
(p_nome_prod, p_quantidade_prod, p_disponibilidade);
commit;
end;

--2) Crie um procedimento chamado prc_insere_cliente para inserir novos clientes, valide: Se o nome do cliente tem mais de 3 caracteres e não contêm números (0 a 9)--
create or replace procedure prc_insere_cliente(
p_nome_cliente varchar2,
p_email_cliente varchar2,
p_senha_cliente varchar2)
as 
begin
if length(p_nome_cliente) <=3 or regexp_like (p_nome_cliente, '[0-9]') then
raise_application_error(-20001, 'O nome contém menos de 3 caracteres e não pode conter números');
end if;
insert into cliente (nome_cliente, email_cliente, senha_cliente) values 
(p_nome_cliente, p_email_cliente, p_senha_cliente);
commit;
end;

--3) Crie uma função chamada FUN_VALIDA_NOME que valide se o nome tem mais do que 3 caracteres e não tenha números.--
create or replace function fun_valida_nome(p_nome in varchar2) return 
varchar2 is 
begin 
if length(p_nome) > 3 or not regexp_like (p_nome, '[0-9]') then
return 'nome válido';
else
return 'nome inválido';
end if;
end;

--4) Altere os procedimentos dos exercícios 1 e 2 para chamar a função do exercício 3--
create or replace procedure prc_insere_cliente(
p_nome_cliente varchar2,
p_email_cliente varchar2,
p_senha_cliente varchar2)
is 
begin 
if fun_valida_nome2(p_nome_cliente) = false then
raise_application_error(-20001, 'O nome do cliente é inválido');
end if;
insert into cliente(nome_cliente, email_cliente, senha_cliente) values
(p_nome_cliente, p_email_cliente, p_senha_cliente);
commit;
end;

--5) Altere o procedimento do exercício 1 para que tenha um último parâmetro chamado P_RETORNO do tipo varchar2 que deverá retornar à informação ‘produto cadastrado com sucesso’ --

create or replace procedure prc_insere_cliente(
p_nome_cliente varchar2,
p_email_cliente varchar2,
p_senha_cliente varchar2,
p_mensagem_retorno out varchar2)
is 
begin
if length(p_nome_cliente) <= 3 or regexp_like(p_nome_cliente, '[0-9]') then
p_mensagem_retorno := 'Nome do cliente inválido';
else
insert into cliente (nome_cliente, email_cliente, senha_cliente) values 
(p_nome_cliente, p_email_cliente, p_senha_cliente);
end if;
commit;
end;

--6) crie um bloco anônimo e chame o procedimento do exercicio 1.

declare 
p_mensagem_retorno varchar2(100);
begin
prc_insere_produto(5566, 'Iphone 15 pro', 'disponível', p_mensagem_retorno);
dbms_output.put_line(p_mensagem_retorno);
end;






