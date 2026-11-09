// Execute primeiro. Restrições evitam IDs duplicados.
CREATE CONSTRAINT artista_id IF NOT EXISTS FOR (n:Artista) REQUIRE n.id IS UNIQUE;
CREATE CONSTRAINT movimento_id IF NOT EXISTS FOR (n:Movimento) REQUIRE n.id IS UNIQUE;
CREATE CONSTRAINT obra_id IF NOT EXISTS FOR (n:Obra) REQUIRE n.id IS UNIQUE;
CREATE CONSTRAINT estudante_id IF NOT EXISTS FOR (n:Estudante) REQUIRE n.id IS UNIQUE;
CREATE CONSTRAINT projeto_id IF NOT EXISTS FOR (n:Projeto) REQUIRE n.id IS UNIQUE;
