-- Criação do banco de dados
CREATE DATABASE Loja;
GO

USE Loja;
GO

-- Criação das tabelas

-- Tabela de Clientes
CREATE TABLE Clientes (
    ClienteID INT IDENTITY(1,1) PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    CPF VARCHAR(14) UNIQUE NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Telefone VARCHAR(20),
    DataNascimento DATE,
    DataCadastro DATETIME DEFAULT GETDATE(),
    Endereco VARCHAR(200),
    Cidade VARCHAR(100),
    Estado CHAR(2),
    CEP VARCHAR(9)
);

-- Tabela de Categorias
CREATE TABLE Categorias (
    CategoriaID INT IDENTITY(1,1) PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL,
    Descricao VARCHAR(200)
);

-- Tabela de Produtos
CREATE TABLE Produtos (
    ProdutoID INT IDENTITY(1,1) PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Descricao VARCHAR(500),
    Preco DECIMAL(10,2) NOT NULL,
    Estoque INT DEFAULT 0,
    CategoriaID INT,
    DataCadastro DATETIME DEFAULT GETDATE(),
    Ativo BIT DEFAULT 1,
    FOREIGN KEY (CategoriaID) REFERENCES Categorias(CategoriaID)
);

-- Tabela de Pedidos
CREATE TABLE Pedidos (
    PedidoID INT IDENTITY(1,1) PRIMARY KEY,
    ClienteID INT NOT NULL,
    DataPedido DATETIME DEFAULT GETDATE(),
    Status VARCHAR(20) DEFAULT 'Pendente',
    ValorTotal DECIMAL(10,2) DEFAULT 0,
    FormaPagamento VARCHAR(50),
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID)
);

-- Tabela de Itens do Pedido
CREATE TABLE ItensPedido (
    ItemPedidoID INT IDENTITY(1,1) PRIMARY KEY,
    PedidoID INT NOT NULL,
    ProdutoID INT NOT NULL,
    Quantidade INT NOT NULL,
    PrecoUnitario DECIMAL(10,2) NOT NULL,
    Subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (PedidoID) REFERENCES Pedidos(PedidoID),
    FOREIGN KEY (ProdutoID) REFERENCES Produtos(ProdutoID)
);

-- Tabela de Fornecedores
CREATE TABLE Fornecedores (
    FornecedorID INT IDENTITY(1,1) PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    CNPJ VARCHAR(18) UNIQUE NOT NULL,
    Email VARCHAR(100),
    Telefone VARCHAR(20),
    Endereco VARCHAR(200),
    Cidade VARCHAR(100),
    Estado CHAR(2),
    CEP VARCHAR(9)
);

-- Tabela de Compras
CREATE TABLE Compras (
    CompraID INT IDENTITY(1,1) PRIMARY KEY,
    FornecedorID INT NOT NULL,
    DataCompra DATETIME DEFAULT GETDATE(),
    ValorTotal DECIMAL(10,2) DEFAULT 0,
    Status VARCHAR(20) DEFAULT 'Pendente',
    FOREIGN KEY (FornecedorID) REFERENCES Fornecedores(FornecedorID)
);

-- Tabela de Itens da Compra
CREATE TABLE ItensCompra (
    ItemCompraID INT IDENTITY(1,1) PRIMARY KEY,
    CompraID INT NOT NULL,
    ProdutoID INT NOT NULL,
    Quantidade INT NOT NULL,
    PrecoUnitario DECIMAL(10,2) NOT NULL,
    Subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (CompraID) REFERENCES Compras(CompraID),
    FOREIGN KEY (ProdutoID) REFERENCES Produtos(ProdutoID)
);

-- Inserção de dados de exemplo

-- Inserindo Categorias
INSERT INTO Categorias (Nome, Descricao) VALUES
('Eletrônicos', 'Produtos eletrônicos em geral'),
('Roupas', 'Vestuário para todas as idades'),
('Alimentos', 'Produtos alimentícios'),
('Móveis', 'Móveis para casa e escritório'),
('Esportes', 'Artigos esportivos');

-- Inserindo Fornecedores
INSERT INTO Fornecedores (Nome, CNPJ, Email, Telefone, Endereco, Cidade, Estado, CEP) VALUES
('TechFornecedor', '12.345.678/0001-90', 'contato@techfornecedor.com', '(11) 1234-5678', 'Rua das Tecnologias, 123', 'São Paulo', 'SP', '01234-567'),
('ModaFornecedor', '98.765.432/0001-10', 'contato@modafornecedor.com', '(11) 8765-4321', 'Av. da Moda, 456', 'São Paulo', 'SP', '01234-890'),
('AlimentosFornecedor', '45.678.901/0001-23', 'contato@alimentosfornecedor.com', '(11) 2345-6789', 'Rua dos Alimentos, 789', 'São Paulo', 'SP', '01234-123');

-- Inserindo Produtos
INSERT INTO Produtos (Nome, Descricao, Preco, Estoque, CategoriaID) VALUES
('Smartphone XYZ', 'Smartphone de última geração', 2999.99, 50, 1),
('Notebook ABC', 'Notebook potente para trabalho', 4999.99, 30, 1),
('Camiseta Básica', 'Camiseta 100% algodão', 49.99, 200, 2),
('Arroz 5kg', 'Arroz tipo 1', 29.99, 100, 3),
('Sofá 3 Lugares', 'Sofá confortável', 1999.99, 10, 4),
('Bola de Futebol', 'Bola oficial', 89.99, 50, 5);

-- Inserindo Clientes
INSERT INTO Clientes (Nome, CPF, Email, Telefone, DataNascimento, Endereco, Cidade, Estado, CEP) VALUES
('João Silva', '123.456.789-00', 'joao@email.com', '(11) 99999-9999', '1990-01-01', 'Rua A, 123', 'São Paulo', 'SP', '01234-567'),
('Maria Santos', '987.654.321-00', 'maria@email.com', '(11) 88888-8888', '1985-05-15', 'Av. B, 456', 'São Paulo', 'SP', '01234-890'),
('Pedro Oliveira', '456.789.123-00', 'pedro@email.com', '(11) 77777-7777', '1995-10-20', 'Rua C, 789', 'São Paulo', 'SP', '01234-123');

-- Inserindo Pedidos
INSERT INTO Pedidos (ClienteID, Status, ValorTotal, FormaPagamento) VALUES
(1, 'Concluído', 3049.98, 'Cartão de Crédito'),
(2, 'Pendente', 1999.99, 'Boleto'),
(3, 'Em Processamento', 89.99, 'PIX');

-- Inserindo Itens do Pedido
INSERT INTO ItensPedido (PedidoID, ProdutoID, Quantidade, PrecoUnitario, Subtotal) VALUES
(1, 1, 1, 2999.99, 2999.99),
(1, 3, 1, 49.99, 49.99),
(2, 5, 1, 1999.99, 1999.99),
(3, 6, 1, 89.99, 89.99);

-- Inserindo Compras
INSERT INTO Compras (FornecedorID, ValorTotal, Status) VALUES
(1, 10000.00, 'Concluído'),
(2, 5000.00, 'Pendente'),
(3, 3000.00, 'Em Processamento');

-- Inserindo Itens da Compra
INSERT INTO ItensCompra (CompraID, ProdutoID, Quantidade, PrecoUnitario, Subtotal) VALUES
(1, 1, 20, 2500.00, 50000.00),
(1, 2, 10, 4000.00, 40000.00),
(2, 3, 100, 30.00, 3000.00),
(3, 4, 100, 20.00, 2000.00);

-- Criando Índices para melhorar a performance
CREATE INDEX idx_clientes_cpf ON Clientes(CPF);
CREATE INDEX idx_produtos_categoria ON Produtos(CategoriaID);
CREATE INDEX idx_pedidos_cliente ON Pedidos(ClienteID);
CREATE INDEX idx_itenspedido_pedido ON ItensPedido(PedidoID);
CREATE INDEX idx_itenspedido_produto ON ItensPedido(ProdutoID);

-- Criando Views para consultas comuns

-- View para visualizar pedidos com detalhes do cliente
CREATE VIEW vw_pedidos_detalhados AS
SELECT 
    p.PedidoID,
    c.Nome AS Cliente,
    p.DataPedido,
    p.Status,
    p.ValorTotal,
    p.FormaPagamento
FROM 
    Pedidos p
    INNER JOIN Clientes c ON p.ClienteID = c.ClienteID;

-- View para visualizar produtos com estoque baixo
CREATE VIEW vw_produtos_estoque_baixo AS
SELECT 
    p.ProdutoID,
    p.Nome,
    p.Estoque,
    c.Nome AS Categoria
FROM 
    Produtos p
    INNER JOIN Categorias c ON p.CategoriaID = c.CategoriaID
WHERE 
    p.Estoque < 20;

-- Criando Stored Procedures

-- Procedure para registrar um novo pedido
CREATE PROCEDURE sp_registrar_pedido
    @ClienteID INT,
    @ProdutoID INT,
    @Quantidade INT
AS
BEGIN
    DECLARE @PrecoUnitario DECIMAL(10,2)
    DECLARE @Subtotal DECIMAL(10,2)
    
    -- Iniciar transação
    BEGIN TRANSACTION
    
    BEGIN TRY
        -- Obter preço do produto
        SELECT @PrecoUnitario = Preco
        FROM Produtos
        WHERE ProdutoID = @ProdutoID
        
        -- Calcular subtotal
        SET @Subtotal = @PrecoUnitario * @Quantidade
        
        -- Inserir pedido
        INSERT INTO Pedidos (ClienteID, Status, ValorTotal)
        VALUES (@ClienteID, 'Pendente', @Subtotal)
        
        DECLARE @PedidoID INT = SCOPE_IDENTITY()
        
        -- Inserir item do pedido
        INSERT INTO ItensPedido (PedidoID, ProdutoID, Quantidade, PrecoUnitario, Subtotal)
        VALUES (@PedidoID, @ProdutoID, @Quantidade, @PrecoUnitario, @Subtotal)
        
        -- Atualizar estoque
        UPDATE Produtos
        SET Estoque = Estoque - @Quantidade
        WHERE ProdutoID = @ProdutoID
        
        -- Confirmar transação
        COMMIT
        
        SELECT 'Pedido registrado com sucesso!' AS Mensagem
    END TRY
    BEGIN CATCH
        -- Desfazer transação em caso de erro
        ROLLBACK
        SELECT 'Erro ao registrar pedido: ' + ERROR_MESSAGE() AS Mensagem
    END CATCH
END;

-- Criando Triggers

-- Trigger para atualizar o valor total do pedido
CREATE TRIGGER tr_atualizar_valor_pedido
ON ItensPedido
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @PedidoID INT
    
    -- Obter PedidoID do registro afetado
    SELECT @PedidoID = PedidoID
    FROM inserted
    
    -- Atualizar valor total do pedido
    UPDATE Pedidos
    SET ValorTotal = (
        SELECT SUM(Subtotal)
        FROM ItensPedido
        WHERE PedidoID = @PedidoID
    )
    WHERE PedidoID = @PedidoID
END; 