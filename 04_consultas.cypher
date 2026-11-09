// Q1 | Quantos participantes distintos há em cada projeto?
MATCH (e:Estudante)-[:PARTICIPOU]->(p:Projeto)
RETURN p.nome AS projeto, count(DISTINCT e) AS estudantes
ORDER BY estudantes DESC, projeto;

// Q2 | Estudantes envolvidos em mais de um projeto.
MATCH (e:Estudante)-[:PARTICIPOU]->(p:Projeto)
WITH e, count(DISTINCT p) AS quantidade, collect(DISTINCT p.nome) AS projetos
WHERE quantidade > 1
RETURN e.nome AS estudante, quantidade, projetos
ORDER BY quantidade DESC, estudante;

// Q3 | Artistas e obras utilizados pelos projetos.
MATCH (p:Projeto)-[:INSPIRADO_EM]->(o:Obra)-[:CRIADA_POR]->(a:Artista)
RETURN p.nome AS projeto, o.titulo AS obra, a.nome AS artista
ORDER BY projeto;

// Q4 | Quais movimentos são mais explorados nos projetos?
MATCH (p:Projeto)-[:EXPLORA]->(m:Movimento)
RETURN m.nome AS movimento, count(DISTINCT p) AS projetos
ORDER BY projetos DESC, movimento;

// Q5 | Sugerir projetos a partir dos colegas com quem o estudante já trabalhou.
// Exclui projetos em que a pessoa já participa.
MATCH (e:Estudante)-[:PARTICIPOU]->(:Projeto)<-[:PARTICIPOU]-(colega:Estudante)
MATCH (colega)-[:PARTICIPOU]->(sugestao:Projeto)
WHERE e <> colega AND NOT (e)-[:PARTICIPOU]->(sugestao)
RETURN e.nome AS estudante, sugestao.nome AS projeto_recomendado,
       count(DISTINCT colega) AS colegas_em_comum
ORDER BY estudante, colegas_em_comum DESC, projeto_recomendado;

// Q6 | Visão do grafo para exportar como PNG real no Neo4j Browser.
MATCH (e:Estudante)-[r:PARTICIPOU]->(p:Projeto)-[s:INSPIRADO_EM]->(o:Obra)-[t:CRIADA_POR]->(a:Artista)
RETURN e, r, p, s, o, t, a
LIMIT 35;

// Q7 | Verificar o volume de dados importados.
MATCH (n) RETURN labels(n) AS tipo, count(*) AS total ORDER BY tipo;

// Q8 | Relações por tipo.
MATCH ()-[r]->() RETURN type(r) AS relacao, count(*) AS total ORDER BY relacao;
