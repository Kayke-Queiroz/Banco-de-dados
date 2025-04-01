-- Criando o banco de dados
CREATE DATABASE IF NOT EXISTS EstacionamentoIDP;
USE EstacionamentoIDP;

-- Criando a tabela Corpo_Docente
CREATE TABLE IF NOT EXISTS Corpo_Docente (
    DocenteID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    CPF VARCHAR(14) NOT NULL UNIQUE,
    Numero VARCHAR(20) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE
);

-- Criando a tabela Veículo
CREATE TABLE IF NOT EXISTS Veiculo (
    VeiculoID INT AUTO_INCREMENT PRIMARY KEY,
    DocenteID INT NOT NULL,
    Placa VARCHAR(10) NOT NULL UNIQUE,
    Modelo VARCHAR(50) NOT NULL,
    Cor VARCHAR(20) NOT NULL,
    FOREIGN KEY (DocenteID) REFERENCES Corpo_Docente(DocenteID) ON DELETE CASCADE
);

-- Criando a tabela Vaga
CREATE TABLE IF NOT EXISTS Vaga (
    VagaID INT AUTO_INCREMENT PRIMARY KEY,
    Numero INT NOT NULL UNIQUE,
    Localizacao VARCHAR(50) NOT NULL,
    Status ENUM('Disponível', 'Ocupada') NOT NULL DEFAULT 'Disponível'
);

-- TABELA DE RESERVAS (ANTIGA) - DESATIVADA
/*
CREATE TABLE IF NOT EXISTS Estacionamento (
    ReservaID INT AUTO_INCREMENT PRIMARY KEY,
    DocenteID INT NOT NULL,
    VeiculoID INT NOT NULL,
    VagaID INT NOT NULL,
    DataReserva DATE NOT NULL,
    HorarioEntrada TIME NOT NULL,
    HorarioSaida TIME NOT NULL,
    Preco DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    Desconto DECIMAL(5,2) NOT NULL DEFAULT 0.00,
    Status ENUM('Reservado', 'Cancelado', 'Concluído') NOT NULL DEFAULT 'Reservado',
    FOREIGN KEY (DocenteID) REFERENCES Corpo_Docente(DocenteID) ON DELETE CASCADE,
    FOREIGN KEY (VeiculoID) REFERENCES Veiculo(VeiculoID) ON DELETE CASCADE,
    FOREIGN KEY (VagaID) REFERENCES Vaga(VagaID) ON DELETE CASCADE
);
*/

-- Criando a nova tabela de tags de estacionamento
CREATE TABLE IF NOT EXISTS tag_estacionamento (
    TagID INT AUTO_INCREMENT PRIMARY KEY,
    DocenteID INT NOT NULL,
    Tag VARCHAR(50) UNIQUE NOT NULL,
    Status ENUM('Ativa', 'Inativa') NOT NULL DEFAULT 'Ativa',
    FOREIGN KEY (DocenteID) REFERENCES Corpo_Docente(DocenteID) ON DELETE CASCADE
);

-- Criando a tabela de pagamentos (atualizada)
CREATE TABLE IF NOT EXISTS Pagamento (
    PagamentoID INT AUTO_INCREMENT PRIMARY KEY,
    DocenteID INT NOT NULL,
    Valor DECIMAL(10,2) NOT NULL,
    DataPagamento DATE NOT NULL,
    FormaPagamento ENUM('Visa', 'Mastercard', 'Boleto', 'Pix') NOT NULL,
    isencao_visa BOOLEAN DEFAULT FALSE, -- Indica se o professor tem gratuidade de 6 meses
    FOREIGN KEY (DocenteID) REFERENCES Corpo_Docente(DocenteID) ON DELETE CASCADE
);

-- Inserindo dados na tabela Corpo_Docente
INSERT INTO Corpo_Docente (Nome, CPF, Numero, Email) VALUES
('João Silva', '123.456.789-00', '12345', 'joao.silva@idp.edu.br'),
('Maria Oliveira', '234.567.890-11', '67890', 'maria.oliveira@idp.edu.br');

-- Inserindo dados na tabela Veiculo
INSERT INTO Veiculo (DocenteID, Placa, Modelo, Cor) VALUES
(1, 'ABC1234', 'Fusca', 'Azul'),
(2, 'XYZ5678', 'Palio', 'Preto');

-- Inserindo dados na tabela Vaga
INSERT INTO Vaga (Numero, Localizacao, Status) VALUES
(1, 'Bloco A - Térreo', 'Disponível'),
(2, 'Bloco B - Primeiro andar', 'Ocupada');

-- Inserindo dados na tabela tag_estacionamento
INSERT INTO tag_estacionamento (DocenteID, Tag, Status) VALUES
(1, 'TAG1234', 'Ativa'),
(2, 'TAG5678', 'Inativa');

-- Inserindo dados na tabela Pagamento
INSERT INTO Pagamento (DocenteID, Valor, DataPagamento, FormaPagamento, isencao_visa) VALUES
(1, 200.00, '2025-03-01', 'Visa', TRUE),
(2, 200.00, '2025-03-01', 'Mastercard', FALSE);
