# Guia de Comandos SQL

## Comandos Básicos de DDL (Data Definition Language)

### CREATE
- `CREATE DATABASE`: Cria um novo banco de dados
- `CREATE TABLE`: Cria uma nova tabela
- `CREATE INDEX`: Cria um índice para melhorar a performance das consultas
- `CREATE VIEW`: Cria uma visão virtual baseada em uma consulta

### ALTER
- `ALTER TABLE`: Modifica a estrutura de uma tabela existente
- `ALTER COLUMN`: Modifica uma coluna existente
- `ADD CONSTRAINT`: Adiciona uma restrição à tabela

### DROP
- `DROP DATABASE`: Remove um banco de dados
- `DROP TABLE`: Remove uma tabela
- `DROP INDEX`: Remove um índice
- `DROP VIEW`: Remove uma visão

## Comandos de DML (Data Manipulation Language)

### SELECT
- `SELECT`: Recupera dados de uma ou mais tabelas
- `WHERE`: Filtra registros baseado em condições
- `GROUP BY`: Agrupa registros baseado em valores de colunas
- `HAVING`: Filtra grupos baseado em condições
- `ORDER BY`: Ordena os resultados
- `JOIN`: Combina registros de duas ou mais tabelas
  - `INNER JOIN`: Retorna registros que têm correspondência em ambas as tabelas
  - `LEFT JOIN`: Retorna todos os registros da tabela esquerda e correspondências da direita
  - `RIGHT JOIN`: Retorna todos os registros da tabela direita e correspondências da esquerda
  - `FULL JOIN`: Retorna todos os registros quando há correspondência em qualquer tabela

### INSERT
- `INSERT INTO`: Insere novos registros em uma tabela

### UPDATE
- `UPDATE`: Modifica registros existentes em uma tabela

### DELETE
- `DELETE FROM`: Remove registros de uma tabela

## Funções SQL

### Funções de Agregação
- `COUNT()`: Conta o número de registros
  ```sql
  -- Conta o total de clientes
  SELECT COUNT(*) FROM Clientes;
  
  -- Conta produtos por categoria
  SELECT CategoriaID, COUNT(*) as TotalProdutos 
  FROM Produtos 
  GROUP BY CategoriaID;
  ```

- `SUM()`: Soma os valores de uma coluna
  ```sql
  -- Soma o valor total de todos os pedidos
  SELECT SUM(ValorTotal) as TotalVendas FROM Pedidos;
  
  -- Soma o valor por forma de pagamento
  SELECT FormaPagamento, SUM(ValorTotal) as Total 
  FROM Pedidos 
  GROUP BY FormaPagamento;
  ```

- `AVG()`: Calcula a média dos valores
  ```sql
  -- Calcula a média de preço dos produtos
  SELECT AVG(Preco) as MediaPreco FROM Produtos;
  
  -- Média de valor por categoria
  SELECT c.Nome, AVG(p.Preco) as MediaPreco
  FROM Produtos p
  JOIN Categorias c ON p.CategoriaID = c.CategoriaID
  GROUP BY c.Nome;
  ```

- `MAX()`: Retorna o valor máximo
  ```sql
  -- Produto mais caro
  SELECT MAX(Preco) as PrecoMaximo FROM Produtos;
  
  -- Maior pedido por cliente
  SELECT c.Nome, MAX(p.ValorTotal) as MaiorPedido
  FROM Pedidos p
  JOIN Clientes c ON p.ClienteID = c.ClienteID
  GROUP BY c.Nome;
  ```

- `MIN()`: Retorna o valor mínimo
  ```sql
  -- Produto mais barato
  SELECT MIN(Preco) as PrecoMinimo FROM Produtos;
  
  -- Menor pedido por cliente
  SELECT c.Nome, MIN(p.ValorTotal) as MenorPedido
  FROM Pedidos p
  JOIN Clientes c ON p.ClienteID = c.ClienteID
  GROUP BY c.Nome;
  ```

### Funções de String
- `CONCAT()`: Concatena strings
  ```sql
  -- Concatena nome e sobrenome do cliente
  SELECT CONCAT(Nome, ' ', Sobrenome) as NomeCompleto FROM Clientes;
  
  -- Concatena endereço completo
  SELECT CONCAT(Endereco, ', ', Cidade, ' - ', Estado) as EnderecoCompleto 
  FROM Clientes;
  ```

- `SUBSTRING()`: Extrai parte de uma string
  ```sql
  -- Extrai os 3 primeiros caracteres do nome
  SELECT SUBSTRING(Nome, 1, 3) as Iniciais FROM Clientes;
  
  -- Extrai o DDD do telefone
  SELECT SUBSTRING(Telefone, 2, 2) as DDD FROM Clientes;
  ```

- `UPPER()`: Converte para maiúsculas
  ```sql
  -- Converte nome para maiúsculas
  SELECT UPPER(Nome) as NomeMaiusculo FROM Clientes;
  
  -- Converte cidade para maiúsculas
  SELECT UPPER(Cidade) as CidadeMaiuscula FROM Clientes;
  ```

- `LOWER()`: Converte para minúsculas
  ```sql
  -- Converte email para minúsculas
  SELECT LOWER(Email) as EmailMinusculo FROM Clientes;
  
  -- Converte descrição para minúsculas
  SELECT LOWER(Descricao) as DescricaoMinuscula FROM Produtos;
  ```

- `LENGTH()`: Retorna o comprimento da string
  ```sql
  -- Tamanho do nome de cada cliente
  SELECT Nome, LENGTH(Nome) as TamanhoNome FROM Clientes;
  
  -- Produtos com descrição longa
  SELECT Nome, LENGTH(Descricao) as TamanhoDescricao 
  FROM Produtos 
  WHERE LENGTH(Descricao) > 100;
  ```

### Funções de Data
- `GETDATE()`: Retorna a data e hora atual
  ```sql
  -- Data e hora atual
  SELECT GETDATE() as DataHoraAtual;
  
  -- Pedidos de hoje
  SELECT * FROM Pedidos 
  WHERE CONVERT(DATE, DataPedido) = CONVERT(DATE, GETDATE());
  ```

- `DATEADD()`: Adiciona um intervalo a uma data
  ```sql
  -- Data de vencimento (30 dias após a data do pedido)
  SELECT PedidoID, DATEADD(DAY, 30, DataPedido) as DataVencimento 
  FROM Pedidos;
  
  -- Próximo mês
  SELECT DATEADD(MONTH, 1, GETDATE()) as ProximoMes;
  ```

- `DATEDIFF()`: Calcula a diferença entre duas datas
  ```sql
  -- Dias desde o último pedido
  SELECT c.Nome, DATEDIFF(DAY, MAX(p.DataPedido), GETDATE()) as DiasSemComprar
  FROM Clientes c
  LEFT JOIN Pedidos p ON c.ClienteID = p.ClienteID
  GROUP BY c.Nome;
  
  -- Idade dos clientes
  SELECT Nome, DATEDIFF(YEAR, DataNascimento, GETDATE()) as Idade 
  FROM Clientes;
  ```

- `YEAR()`: Extrai o ano de uma data
  ```sql
  -- Pedidos por ano
  SELECT YEAR(DataPedido) as Ano, COUNT(*) as TotalPedidos
  FROM Pedidos
  GROUP BY YEAR(DataPedido);
  
  -- Clientes por ano de nascimento
  SELECT YEAR(DataNascimento) as AnoNascimento, COUNT(*) as Total
  FROM Clientes
  GROUP BY YEAR(DataNascimento);
  ```

- `MONTH()`: Extrai o mês de uma data
  ```sql
  -- Pedidos por mês
  SELECT MONTH(DataPedido) as Mes, COUNT(*) as TotalPedidos
  FROM Pedidos
  GROUP BY MONTH(DataPedido);
  
  -- Aniversariantes do mês
  SELECT Nome, DataNascimento
  FROM Clientes
  WHERE MONTH(DataNascimento) = MONTH(GETDATE());
  ```

- `DAY()`: Extrai o dia de uma data
  ```sql
  -- Pedidos por dia
  SELECT DAY(DataPedido) as Dia, COUNT(*) as TotalPedidos
  FROM Pedidos
  GROUP BY DAY(DataPedido);
  
  -- Aniversariantes do dia
  SELECT Nome, DataNascimento
  FROM Clientes
  WHERE DAY(DataNascimento) = DAY(GETDATE());
  ```

## Restrições (Constraints)
- `PRIMARY KEY`: Identifica unicamente cada registro em uma tabela
- `FOREIGN KEY`: Mantém a integridade referencial entre tabelas
- `NOT NULL`: Garante que uma coluna não aceite valores nulos
- `UNIQUE`: Garante que todos os valores em uma coluna sejam diferentes
- `CHECK`: Garante que os valores em uma coluna satisfaçam uma condição específica
- `DEFAULT`: Define um valor padrão para uma coluna

## Transações
- `BEGIN TRANSACTION`: Inicia uma transação
- `COMMIT`: Salva as alterações de uma transação
- `ROLLBACK`: Desfaz as alterações de uma transação

## Índices
- `CREATE INDEX`: Cria um índice para melhorar a performance
- `DROP INDEX`: Remove um índice
- `CLUSTERED INDEX`: Índice que determina a ordem física dos dados
- `NONCLUSTERED INDEX`: Índice que não afeta a ordem física dos dados

## Stored Procedures
- `CREATE PROCEDURE`: Cria uma stored procedure
- `EXECUTE`: Executa uma stored procedure
- `ALTER PROCEDURE`: Modifica uma stored procedure
- `DROP PROCEDURE`: Remove uma stored procedure

## Triggers
- `CREATE TRIGGER`: Cria um trigger
- `ALTER TRIGGER`: Modifica um trigger
- `DROP TRIGGER`: Remove um trigger

## Views
- `CREATE VIEW`: Cria uma view
- `ALTER VIEW`: Modifica uma view
- `DROP VIEW`: Remove uma view 