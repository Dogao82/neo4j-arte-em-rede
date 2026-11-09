// MÉTODO B (alternativo ao 02): publique antes os CSVs no GitHub.
// URLs preparadas para Dogao82/neo4j-arte-em-rede-dio na branch main; ajuste se o nome ou a branch mudar.
// Execute cada instrução individualmente depois de 01_restricoes.cypher.
// Não rode os dois métodos para importar mais dados: MERGE evita duplicação, mas é redundante.

// Carrega nós Artista
LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/Dogao82/neo4j-arte-em-rede-dio/main/dados/artistas.csv' AS row
MERGE (n:Artista {id: row.id})
SET n.nome = row.nome, n.pais = row.pais;

// Carrega nós Movimento
LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/Dogao82/neo4j-arte-em-rede-dio/main/dados/movimentos.csv' AS row
MERGE (n:Movimento {id: row.id})
SET n.nome = row.nome, n.periodo = row.periodo;

// Carrega nós Obra
LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/Dogao82/neo4j-arte-em-rede-dio/main/dados/obras.csv' AS row
MERGE (n:Obra {id: row.id})
SET n.titulo = row.titulo, n.ano = toInteger(row.ano), n.artista_id = row.artista_id, n.movimento_id = row.movimento_id;

// Carrega nós Estudante
LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/Dogao82/neo4j-arte-em-rede-dio/main/dados/estudantes.csv' AS row
MERGE (n:Estudante {id: row.id})
SET n.nome = row.nome, n.turma = row.turma;

// Carrega nós Projeto
LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/Dogao82/neo4j-arte-em-rede-dio/main/dados/projetos.csv' AS row
MERGE (n:Projeto {id: row.id})
SET n.nome = row.nome, n.ano = toInteger(row.ano), n.obra_id = row.obra_id, n.movimento_id = row.movimento_id;

MATCH (o:Obra), (a:Artista {id: o.artista_id}) MERGE (o)-[:CRIADA_POR]->(a);

MATCH (o:Obra), (m:Movimento {id: o.movimento_id}) MERGE (o)-[:PERTENCE_A]->(m);

MATCH (p:Projeto), (o:Obra {id: p.obra_id}) MERGE (p)-[:INSPIRADO_EM]->(o);

MATCH (p:Projeto), (m:Movimento {id: p.movimento_id}) MERGE (p)-[:EXPLORA]->(m);

LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/Dogao82/neo4j-arte-em-rede-dio/main/dados/participacoes.csv' AS row
MATCH (e:Estudante {id: row.estudante_id})
MATCH (p:Projeto {id: row.projeto_id})
MERGE (e)-[r:PARTICIPOU]->(p)
SET r.papel = row.papel;
