CREATE DATABASE desafio_sql_pnblabs;

--

CREATE TABLE categorias (
	id BIGSERIAL PRIMARY KEY,
	nome VARCHAR(100) UNIQUE NOT NULL
);

--

CREATE TABLE produtos (
	id BIGSERIAL PRIMARY KEY,
	nome VARCHAR(255) NOT NULL,
	preco BIGINT NOT NULL,
	categoria_id BIGINT,
	CONSTRAINT fk_produto_categoria FOREIGN KEY (categoria_id) REFERENCES categorias(id)
);

--

CREATE TABLE vendas (
	id BIGSERIAL PRIMARY KEY,
	produto_id BIGINT NOT NULL,
	quantidade INT NOT NULL DEFAULT 1,
	data_venda DATE NOT NULL DEFAULT NOW(),
	CONSTRAINT fk_venda_produto FOREIGN KEY (produto_id) REFERENCES produtos(id)
);

--

INSERT INTO categorias (nome) 
VALUES 
	('Eletrônicos'),
	('Informática'),
	('Escritório'),
	('Móveis'),
	('Acessórios'),
	('Software'),
	('Hardware'),
	('Redes'),
	('Segurança da Informação'),
	('Suporte Técnico'),
	('Desenvolvimento'),
	('Recursos Humanos'),
	('Financeiro'),
	('Logística'),
	('Marketing');

--

INSERT INTO produtos (nome, preco, categoria_id) 
VALUES 
	-- Categoria 1: Eletrônicos
	('Smartphone X1', 250000, 1),
	('Fone de Ouvido Bluetooth', 15000, 1),
	('Smartwatch Pro', 89900, 1),
	('Carregador Rápido 20W', 12000, 1),
	('Caixa de Som Portátil', 22000, 1),
	-- Categoria 2: Informática
	('Notebook Ultra Slim', 450000, 2),
	('Mouse Sem Fio', 8500, 2),
	('Teclado Mecânico RGB', 35000, 2),
	('Monitor 27 Polegadas 4K', 180000, 2),
	('Webcam Full HD', 25000, 2),
	-- Categoria 3: Escritório
	('Cadeira de Escritório', 95000, 3),
	('Mesa em L', 120000, 3),
	('Organizador de Documentos', 4500, 3),
	('Luminária de Mesa LED', 7800, 3),
	('Apoio de Pés Ergonômico', 13000, 3),
	-- Categoria 4: Móveis
	('Estante de Livros', 45000, 4),
	('Armário de Aço', 80000, 4),
	('Gaveteiro com Chave', 32000, 4),
	('Poltrona de Descanso', 150000, 4),
	('Mesa de Reunião', 280000, 4),
	-- Categoria 5: Acessórios
	('Cabo HDMI 2.0', 3500, 5),
	('Adaptador USB-C', 6500, 5),
	('Mochila para Notebook', 18000, 5),
	('Suporte para Celular', 2500, 5),
	('Hub USB 4 Portas', 9000, 5),
	-- Categoria 6: Software
	('Licença Windows 11 Pro', 120000, 6),
	('Assinatura Office 365', 35000, 6),
	('Antivírus Premium 1 Ano', 15000, 6),
	('Editor de Vídeo Pro', 85000, 6),
	('ERP Gestão Empresarial', 500000, 6),
	-- Categoria 7: Hardware
	('Processador i7 13th Gen', 210000, 7),
	('Placa de Vídeo RTX 3060', 280000, 7),
	('Memória RAM 16GB DDR4', 45000, 7),
	('SSD NVMe 1TB', 55000, 7),
	('Fonte Real 600W', 38000, 7),
	-- Categoria 8: Redes
	('Roteador Wi-Fi 6', 65000, 8),
	('Switch 8 Portas Gigabit', 22000, 8),
	('Cabo de Rede CAT6 10m', 4500, 8),
	('Repetidor de Sinal', 18000, 8),
	('Modem Fibra Óptica', 35000, 8),
	-- Categoria 9: Segurança da Informação
	('Firewall Hardware', 150000, 9),
	('Token de Segurança USB', 12000, 9),
	('Câmera de Segurança IP', 28000, 9),
	('Gravador NVR 4 Canais', 85000, 9),
	('HD Externo Criptografado', 75000, 9),
	-- Categoria 10: Suporte Técnico
	('Kit de Ferramentas PC', 15000, 10),
	('Limpa Telas Spray', 2500, 10),
	('Pasta Térmica de Prata', 4500, 10),
	('Ar Comprimido Latinha', 3500, 10),
	('Multímetro Digital', 12000, 10);

--

-- Vendas de Outubro e Novembro de 2025 (400 registros)
INSERT INTO vendas (produto_id, quantidade, data_venda) 
SELECT (random() * 49 + 1)::int, (random() * 5 + 1)::int, '2025-10-01'::date + (random() * 60)::int * '1 day'::interval FROM generate_series(1, 400);

-- Vendas de Dezembro de 2025 (400 registros)
INSERT INTO vendas (produto_id, quantidade, data_venda)
SELECT (random() * 49 + 1)::int, (random() * 5 + 1)::int, '2025-12-01'::date + (random() * 30)::int * '1 day'::interval FROM generate_series(1, 400);

-- Vendas de JANEIRO de 2026 (600 registros - Foco no desafio do edital)
INSERT INTO vendas (produto_id, quantidade, data_venda)
SELECT (random() * 49 + 1)::int, (random() * 5 + 1)::int, '2026-01-01'::date + (random() * 30)::int * '1 day'::interval FROM generate_series(1, 600);

-- Vendas de Fevereiro de 2026 (600 registros)
INSERT INTO vendas (produto_id, quantidade, data_venda)
SELECT (random() * 49 + 1)::int, (random() * 5 + 1)::int, '2026-02-01'::date + (random() * 27)::int * '1 day'::interval FROM generate_series(1, 600);

--

SELECT
	produtos.nome,
	categorias.nome,
	CAST(produtos.preco AS DECIMAL) / 100 AS preco_formatado
FROM produtos 
LEFT JOIN categorias ON categorias.id = produtos.categoria_id 
WHERE produtos.preco > 10000;

--

SELECT
    c.nome AS categoria,
    SUM(v.quantidade) AS total_vendido
FROM vendas v
INNER JOIN produtos p ON p.id = v.produto_id
INNER JOIN categorias c ON c.id = p.categoria_id
GROUP BY c.id, c.nome
ORDER BY total_vendido DESC;
	
--

SELECT
	TO_CHAR(v.data_venda, 'YYYY-MM'),
	p.nome,
	COUNT(v.quantidade)
FROM produtos p
INNER JOIN vendas v ON v.produto_id = p.id
WHERE v.data_venda BETWEEN '2026-01-01' AND '2026-01-31'
GROUP BY
	TO_CHAR(v.data_venda, 'YYYY-MM'),
	p.nome
ORDER BY 
	p.nome ASC;

--

UPDATE produtos
SET preco = preco * 1.1
WHERE categoria_id IN (
	SELECT id FROM categorias WHERE nome = 'Eletrônicos'
)

--