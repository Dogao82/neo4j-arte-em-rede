// MÉTODO A: carga sem internet, sem hospedagem de CSV.
// Execute as instruções uma de cada vez no Neo4j Query/Browser.
// Dados inteiramente fictícios/didáticos; nomes de artistas e obras são referências culturais.

// Nós: Artista
UNWIND [
  {id: 'a1', nome: 'Tarsila do Amaral', pais: 'Brasil'},
  {id: 'a2', nome: 'Candido Portinari', pais: 'Brasil'},
  {id: 'a3', nome: 'Vincent van Gogh', pais: 'Países Baixos'},
  {id: 'a4', nome: 'Piet Mondrian', pais: 'Países Baixos'},
  {id: 'a5', nome: 'Frida Kahlo', pais: 'México'},
  {id: 'a6', nome: 'Claude Monet', pais: 'França'}
] AS row
MERGE (n:Artista {id: row.id})
SET n += row;

// Nós: Movimento
UNWIND [
  {id: 'm1', nome: 'Modernismo brasileiro', periodo: 'Século XX'},
  {id: 'm2', nome: 'Expressionismo', periodo: 'Séculos XIX-XX'},
  {id: 'm3', nome: 'Pós-impressionismo', periodo: 'Século XIX'},
  {id: 'm4', nome: 'Neoplasticismo', periodo: 'Século XX'},
  {id: 'm5', nome: 'Impressionismo', periodo: 'Século XIX'},
  {id: 'm6', nome: 'Surrealismo', periodo: 'Século XX'}
] AS row
MERGE (n:Movimento {id: row.id})
SET n += row;

// Nós: Obra
UNWIND [
  {id: 'o1', titulo: 'Abaporu', ano: 1928, artista_id: 'a1', movimento_id: 'm1'},
  {id: 'o2', titulo: 'Operários', ano: 1933, artista_id: 'a1', movimento_id: 'm1'},
  {id: 'o3', titulo: 'Café', ano: 1935, artista_id: 'a2', movimento_id: 'm1'},
  {id: 'o4', titulo: 'A Noite Estrelada', ano: 1889, artista_id: 'a3', movimento_id: 'm3'},
  {id: 'o5', titulo: 'Composição com Vermelho Azul e Amarelo', ano: 1930, artista_id: 'a4', movimento_id: 'm4'},
  {id: 'o6', titulo: 'As Duas Fridas', ano: 1939, artista_id: 'a5', movimento_id: 'm6'},
  {id: 'o7', titulo: 'Impressão Nascer do Sol', ano: 1872, artista_id: 'a6', movimento_id: 'm5'},
  {id: 'o8', titulo: 'Girassóis', ano: 1888, artista_id: 'a3', movimento_id: 'm3'}
] AS row
MERGE (n:Obra {id: row.id})
SET n += row;

// Nós: Estudante
UNWIND [
  {id: 'e1', nome: 'Ana', turma: '7º A'},
  {id: 'e2', nome: 'Bruno', turma: '7º A'},
  {id: 'e3', nome: 'Carla', turma: '8º B'},
  {id: 'e4', nome: 'Diego', turma: '8º B'},
  {id: 'e5', nome: 'Elisa', turma: '9º A'},
  {id: 'e6', nome: 'Felipe', turma: '9º A'},
  {id: 'e7', nome: 'Giulia', turma: '7º A'},
  {id: 'e8', nome: 'Hugo', turma: '9º A'}
] AS row
MERGE (n:Estudante {id: row.id})
SET n += row;

// Nós: Projeto
UNWIND [
  {id: 'p1', nome: 'Releituras do Modernismo', ano: 2026, obra_id: 'o1', movimento_id: 'm1'},
  {id: 'p2', nome: 'Cores e Geometria', ano: 2026, obra_id: 'o5', movimento_id: 'm4'},
  {id: 'p3', nome: 'Museu das Estrelas', ano: 2026, obra_id: 'o4', movimento_id: 'm3'},
  {id: 'p4', nome: 'Arte e Meio Ambiente', ano: 2026, obra_id: 'o7', movimento_id: 'm5'}
] AS row
MERGE (n:Projeto {id: row.id})
SET n += row;

// Relacionar as obras a seus autores e movimentos.
MATCH (o:Obra), (a:Artista {id: o.artista_id})
MERGE (o)-[:CRIADA_POR]->(a);
MATCH (o:Obra), (m:Movimento {id: o.movimento_id})
MERGE (o)-[:PERTENCE_A]->(m);
MATCH (p:Projeto), (o:Obra {id: p.obra_id})
MERGE (p)-[:INSPIRADO_EM]->(o);
MATCH (p:Projeto), (m:Movimento {id: p.movimento_id})
MERGE (p)-[:EXPLORA]->(m);
// Participações: estudantes e projetos.
UNWIND [
  {estudante_id: 'e1', projeto_id: 'p1', papel: 'pesquisa'},
  {estudante_id: 'e2', projeto_id: 'p1', papel: 'criação'},
  {estudante_id: 'e3', projeto_id: 'p1', papel: 'curadoria'},
  {estudante_id: 'e1', projeto_id: 'p2', papel: 'criação'},
  {estudante_id: 'e4', projeto_id: 'p2', papel: 'pesquisa'},
  {estudante_id: 'e5', projeto_id: 'p2', papel: 'montagem'},
  {estudante_id: 'e2', projeto_id: 'p3', papel: 'montagem'},
  {estudante_id: 'e6', projeto_id: 'p3', papel: 'pesquisa'},
  {estudante_id: 'e7', projeto_id: 'p3', papel: 'criação'},
  {estudante_id: 'e3', projeto_id: 'p4', papel: 'pesquisa'},
  {estudante_id: 'e8', projeto_id: 'p4', papel: 'criação'},
  {estudante_id: 'e5', projeto_id: 'p4', papel: 'montagem'},
  {estudante_id: 'e7', projeto_id: 'p1', papel: 'pesquisa'}
] AS row
MATCH (e:Estudante {id: row.estudante_id})
MATCH (p:Projeto {id: row.projeto_id})
MERGE (e)-[r:PARTICIPOU]->(p)
SET r.papel = row.papel;
