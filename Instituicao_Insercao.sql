Use instituicao;

INSERT INTO departamento VALUES
  (111, 'Mecânica', 'MCN'),
  (122, 'Computação', 'CPT'),
  (133, 'Elétrica', 'ELTC'),
  (144, 'Eletrônica', 'ELTNC'),
  (155, 'Ciências Exatas', 'CE');
  
INSERT INTO curso VALUES
  (123, 'Engenharia Mecânica', 111),
  (345, 'Engenharia da Computação', 122),
  (456, 'Engenharia Elétrica', 133),
  (145, 'Engenharia Eletrônica', 144),
  (678, 'Licenciatura em Matemática', 155);

INSERT INTO disciplina  VALUES
  (211,'Algoritmos', 345),
  (212,'Fundamentos de Matemática', 123),
  (213,'Cálculo 1', 456),
  (214,'Física 1', 678),
  (215,'Banco de Dados', 345),
  (216,'Termodinâmica', 145),
  (217,'Eletrônica II', 145),
  (218,'Comunicação Oral e Escrita', 123);
  
INSERT INTO docente VALUES
  (1,'Antonio Borges', 111),
  (2,'Pedro Pascal', 122),
  (3,'Felipe Pisca', 133),
  (4,'Julia Raluca da Silva', 144),
  (5,'Pedro Milton', 155);

INSERT INTO turma VALUES
  (65, 16, 211, 1),
  (66, 23, 212, 2),
  (67, 30, 213, 3),
  (68, 42, 214, 4),
  (69, 14, 215, 1);

INSERT INTO bloco VALUES
  (91, 'Bloco A'),
  (92, 'Bloco I'),
  (93, 'Bloco X'),
  (94, 'Bloco ESC'),
  (95, 'Bloco das Araras');
  
INSERT INTO laboratorio VALUES
  (31, 20, 18, 91),
  (32, 30, 29, 92),
  (33, 10, 10, 93),
  (34, 40, 40, 94),
  (35, 20, 19, 95);

INSERT INTO reserva VALUES #Id laboratorio, id da turma, docente da turma#
  ('2022-05-21', '2022-05-22', 31, 65, 1),
  ('2022-06-02', '2022-06-03', 32, 66, 2),
  ('2022-06-04', '2022-06-05', 33, 67, 3),
  ('2022-07-12', '2022-07-13', 34, 68, 4),
  ('2022-08-14', '2022-08-15', 33, 69, 1);

INSERT INTO computador VALUES #id_Comp, descricao, desempenho, idlab#
  (41, 'Intel Celeron', 'BOM', 31),
  (42, 'RTX300', 'REGULAR', 32),
  (43, '1TB de RAM', 'ÓTIMO', 33),
  (44, '500 GB de SSD', 'REGULAR', 34),
  (45, 'Gabinete RGB', 'BOM', 35);

INSERT INTO programa VALUES
  (51, 'Software de Desenho', 41),
  (52, 'IDE', 42),
  (53, 'Software de Construção', 43),
  (54, 'Software de Cálculo', 44),
  (55, 'Software de Pesquisa', 45);
  

  