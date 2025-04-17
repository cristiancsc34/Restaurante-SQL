
CREATE DATABASE IF NOT EXISTS Restaurante;
USE Restaurante;


CREATE TABLE IF NOT EXISTS Cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,  
    nome VARCHAR(150) NOT NULL,                
    telefone VARCHAR(15) NOT NULL               
);

CREATE TABLE IF NOT EXISTS Prato (
    id_prato INT AUTO_INCREMENT PRIMARY KEY,  
    nome VARCHAR(150) NOT NULL,                 
    preco DECIMAL(10, 2) NOT NULL              
);


CREATE TABLE IF NOT EXISTS Pedido (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,  
    id_cliente INT NOT NULL,                    
    data_pedido DATETIME NOT NULL,             
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente) ON DELETE CASCADE 
);


CREATE TABLE IF NOT EXISTS Item (
    id_item INT AUTO_INCREMENT PRIMARY KEY,   
    id_pedido INT NOT NULL,                     
    id_prato INT NOT NULL,                      
    quantidade INT NOT NULL,                    
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido) ON DELETE CASCADE, 
    FOREIGN KEY (id_prato) REFERENCES Prato(id_prato) ON DELETE CASCADE      
);


INSERT INTO Cliente (nome, telefone)
VALUES
    ('João Silva', '123456789'),
    ('Maria Oliveira', '234567890'),
    ('Carlos Souza', '345678901'),
    ('Ana Costa', '456789012'),
    ('Tatiane Rocha', '567890123');


INSERT INTO Prato (nome, preco)
VALUES
    ('Pizza Margherita', 25.00),
    ('Lasanha', 30.00),
    ('Hambúrguer', 20.00),
    ('Sushi', 40.00),
    ('Salada', 15.00);


INSERT INTO Pedido (id_cliente, data_pedido)
VALUES
    (1, '2024-11-25 19:00:00'),
    (2, '2024-11-26 20:30:00'),
    (3, '2024-11-27 18:00:00');

INSERT INTO Item (id_pedido, id_prato, quantidade)
VALUES
    (1, 1, 2),  
    (1, 3, 1),  
    (2, 2, 3),  
    (2, 5, 1),  
    (3, 4, 2);  


SELECT 
    c.nome AS cliente,
    p.nome AS prato,
    i.quantidade,
    p.preco,
    (i.quantidade * p.preco) AS total_item
FROM 
    Pedido pd
JOIN 
    Cliente c ON pd.id_cliente = c.id_cliente
JOIN 
    Item i ON pd.id_pedido = i.id_pedido
JOIN 
    Prato p ON i.id_prato = p.id_prato
ORDER BY 
    pd.data_pedido;


SELECT 
    c.nome AS cliente,
    SUM(i.quantidade * p.preco) AS total_gasto
FROM 
    Cliente c
JOIN 
    Pedido pd ON c.id_cliente = pd.id_cliente
JOIN 
    Item i ON pd.id_pedido = i.id_pedido
JOIN 
    Prato p ON i.id_prato = p.id_prato
GROUP BY 
    c.id_cliente
ORDER BY 
    total_gasto DESC;


SELECT 
    p.nome AS prato,
    SUM(i.quantidade) AS total_vendido
FROM 
    Item i
JOIN 
    Prato p ON i.id_prato = p.id_prato
GROUP BY 
    p.id_prato
ORDER BY 
    total_vendido DESC;
