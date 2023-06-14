CREATE database Instituicao;
USE instituicao;

CREATE TABLE departamento(
 idDep INT,
 nomeDep VARCHAR(45),
 siglaDep VARCHAR(10),
 PRIMARY KEY (idDep)
);

CREATE TABLE curso(
 idCurso INT,
 nomeCurso VARCHAR(30),
 departamento_idDep INT,
 PRIMARY KEY (idCurso),
 FOREIGN KEY (departamento_idDep) REFERENCES departamento(idDep)
);

CREATE TABLE disciplina(
 idDisciplina INT,
 nomeDisciplina VARCHAR (30),
 curso_idCurso INT,
 PRIMARY KEY (idDisciplina),
 FOREIGN KEY(Curso_idCurso) REFERENCES curso(idCurso)
);

CREATE TABLE docente(
 idDocente INT,
 nomeDocente VARCHAR(45),
 departamento_idDep INT,
 PRIMARY KEY (idDocente),
 FOREIGN KEY (Departamento_idDep) REFERENCES departamento(idDep)
);

CREATE TABLE TURMA(
 idTurma INT,
 qntdDiscente INT,
 disciplina_idDisciplina INT,
 docente_idDocente INT,
 PRIMARY KEY (idTurma),
 FOREIGN KEY (Disciplina_idDisciplina) REFERENCES disciplina(idDisciplina),
 FOREIGN KEY (Docente_idDocente) REFERENCES docente(idDocente)
);

CREATE TABLE Bloco (
 idBloco INT,
 nomeBloco VARCHAR(30),
 PRIMARY KEY (idBloco)
);

CREATE TABLE Laboratorio (
 idLaboratorio INT,
 qntdLugares INT,
 qntdComputadores INT,
 bloco_idBloco INT,
 PRIMARY KEY (idLaboratorio),
 FOREIGN KEY (Bloco_idBloco) REFERENCES Bloco(idBloco)
);

CREATE TABLE Reserva (
 dataReservaInicio DATETIME,
 dataReservaFinal DATETIME,
 laboratorio_idLaboratorio INT,
 turma_idTurma INT,
 turma_docente_idDocente INT,
 FOREIGN KEY (Laboratorio_idLaboratorio) REFERENCES Laboratorio(idLaboratorio),
 FOREIGN KEY (Turma_idTurma) REFERENCES Turma(idTurma),
 FOREIGN KEY (Turma_Docente_idDocente) REFERENCES Turma(Docente_idDocente)
);

CREATE TABLE Computador(
 idComputador INT,
 descricaoComputador VARCHAR (40),
 desempenho VARCHAR (10),
 laboratorio_idLaboratorio INT,
 PRIMARY KEY (idComputador),
 FOREIGN KEY (Laboratorio_idLaboratorio) REFERENCES Laboratorio(idLaboratorio)
);

CREATE TABLE Programa(
 idPrograma INT,
 descricaoPrograma VARCHAR(45),
 computador_idComputador INT,
 PRIMARY KEY (idPrograma),
 FOREIGN KEY (Computador_idComputador) REFERENCES Computador(idComputador)
);

/* 1 - Encontre a quantidade de laboratórios por bloco utilizando uma junção natural.
No resultado, mostre o nome do bloco e a quantidade de laboratórios encontrados.
Ordene o resultado de forma ascendente pelo nome do bloco. (0,5) */ 

SELECT b.nomeBloco AS Blocos, COUNT(l.idLaboratorio) AS Quantidade_Laboratorios
FROM bloco AS b NATURAL JOIN laboratorio AS l
WHERE b.idBloco = l.bloco_idBloco
GROUP BY b.nomeBloco
ORDER BY nomeBloco;

/*2 - Encontre (as)os docentes aos quais nenhuma turma foi atribuída. No resultado, mostre o nome da(o) docente e a sigla do departamento ao qual
a(o) docente está vinculado. Na construção da consulta deve ser empregado o conceito de junção externa ou outer join. */
SELECT d.nomeDocente, dep.siglaDep
FROM docente d
LEFT JOIN turma t ON d.idDocente = t.docente_idDocente
JOIN departamento dep ON d.departamento_idDep = dep.idDep
WHERE t.idTurma IS NULL; 

/* 3 - Encontre a quantidade de disciplinas, por curso, que não geraram a abertura de uma turma. No resultado, mostre o nome do curso e a
quantidade de disciplinas*/
SELECT temp.qtde, nomeCurso FROM
(SELECT COUNT(*) qtde,curso_idCurso FROM disciplina LEFT JOIN TURMA
ON disciplina.idDisciplina = turma.disciplina_idDisciplina
WHERE idTurma IS NULL
group by curso_idCurso) temp
JOIN
curso
WHERE temp.curso_idCurso = curso.idCurso;

/* 4 - Encontre as (os) docentes que estão vinculados à turmas alocadas em
laboratórios que possuem equipamentos de desempenho regular. No resultado,
mostre o nome da (o) docente, o id da turma, o id do laboratório,
o nome do bloco do laboratório reservado e o desempenho dos equipamentos.*/
SELECT d.nomeDocente, t.idTurma, l.idLaboratorio, b.nomeBloco, c.desempenho
FROM docente d
JOIN turma t ON d.idDocente = t.docente_idDocente
JOIN reserva r ON t.idTurma = r.turma_idTurma
JOIN laboratorio l ON r.laboratorio_idLaboratorio = l.idLaboratorio
JOIN computador c ON l.idLaboratorio = c.laboratorio_idLaboratorio
JOIN bloco b ON l.bloco_idBloco = b.idBloco
WHERE c.desempenho = 'regular';

/*5 - Encontre o laboratório cujos equipamentos possuem a maior quantidade de programa(s) instalado(s). No resultado, mostre id do laboratório, o desempenho
do computador vinculado ao laboratório e a descrição de cada programa instalado*/
SELECT l.idLaboratorio, c.desempenho, p.descricaoPrograma
FROM Laboratorio l
JOIN Computador c ON l.idLaboratorio = c.laboratorio_idLaboratorio
JOIN Programa p ON c.idComputador = p.computador_idComputador
WHERE (SELECT COUNT(*) FROM Programa WHERE computador_idComputador = c.idComputador) = 
      (SELECT MAX(programas_instalados) FROM 
          (SELECT COUNT(*) AS programas_instalados 
           FROM Programa 
           GROUP BY computador_idComputador) AS subconsulta
);

/*6 - Escreva uma consutla para deletar todas as informações de todas as tabelas, porém mantenha as estruturas das tabelas armazenadas no BD.
DELETE FROM Reserva;
DELETE FROM Programa;
DELETE FROM Computador;
DELETE FROM Laboratorio;
DELETE FROM Turma;
DELETE FROM Docente;
DELETE FROM Disciplina;
DELETE FROM Curso;
DELETE FROM Departamento; */

/* 7 - Escreva uma consutla para deletar todas as tabelas do BD reservalab (somente as tabelas) (0,4) 
 DROP TABLE bloco;
 DROP TABLE computador;
 DROP TABLE curso;
 DROP TABLE departamento;
 DROP TABLE disciplina;
 DROP TABLE docente;
 DROP TABLE laboratorio;
 DROP TABLE programa;
 DROP TABLE reserva;
 DROP TABLE turma; */
 
 /*8 -  Escreva uma consutla para deletar todo o BD reservalab. 
DROP DATABASE instituicao; */
