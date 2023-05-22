

/*O jogo so deve ter 90 minutos*/

DROP TABLE Pessoas cascade constraints;
DROP TABLE Treinadores cascade constraints;
DROP TABLE Jogador cascade constraints;
DROP TABLE Posicao cascade constraints;
DROP TABLE Joga_Posicao cascade constraints;
DROP TABLE Morada cascade constraints;
DROP TABLE TipoT cascade constraints;
DROP TABLE Jogo cascade constraints;
DROP TABLE TransferenciaID cascade constraints; /* isto é alguma coisa?*/
DROP TABLE Transferencia_equipa cascade constraints;
/*O que faltava adicionar*/
DROP TABLE Estadio cascade constraints;
DROP TABLE Equipas cascade constraints;
DROP TABLE Acoes cascade constraints;
DROP TABLE TipoAcao cascade constraints;


CREATE SEQUENCE seq_id
  START WITH 1
  INCREMENT BY 1;
  
CREATE SEQUENCE seq_idEstadio
  START WITH 1
  INCREMENT BY 1; 
  
CREATE SEQUENCE seq_idEquipa
  START WITH 1
  INCREMENT BY 1;  
  
CREATE SEQUENCE seq_idPos
  START WITH 1
  INCREMENT BY 1;  
  
CREATE SEQUENCE seq_idAcao
  START WITH 1
  INCREMENT BY 1;    
  
CREATE TABLE Morada (
	Localidade varchar(250),
	Pais varchar(250),
    
    CONSTRAINT morada_pk PRIMARY KEY (Localidade)
);

CREATE TABLE Pessoas (
	NIF NUMBER,
	Nome varchar(250),
	Salario NUMBER,
	DataInicioC DATE NOT NULL,
	DataFimC DATE NOT NULL,
	DataNascimento DATE NOT NULL,
	Nacionalidade varchar(250),
	Localidade varchar(250),

	CONSTRAINT pessoas_pk PRIMARY KEY (NIF),
    CONSTRAINT morada_pessoas_fk FOREIGN KEY (lOCALIDADE) REFERENCES MORADA (LOCALIDADE)
);

CREATE TABLE Treinadores (
	NIF NUMBER,
	Cargo varchar(250),
	CONSTRAINT fk_Treinadores_Pessoa FOREIGN KEY (NIF) REFERENCES Pessoas (NIF),	
	CONSTRAINT treinadores_pk PRIMARY KEY (NIF)

);

CREATE TABLE Jogador (
	NIF NUMBER,
	CONSTRAINT fk_jogadores_Pessoa FOREIGN KEY (NIF) REFERENCES Pessoas (NIF),	
	CONSTRAINT jogador_pk PRIMARY KEY (NIF)
);



CREATE TABLE Posicao (
	PosicaoID NUMBER DEFAULT seq_idPos.NEXTVAL,
	Descricao varchar(250),

	CONSTRAINT posicao_pk PRIMARY KEY (PosicaoID)
);

CREATE TABLE Joga_Posicao (
	PosicaoID NUMBER,
	NIF NUMBER,

	CONSTRAINT fk_jogadores_joga FOREIGN KEY (NIF) REFERENCES Jogador (NIF),		
	CONSTRAINT fk_posicao_joga FOREIGN KEY (PosicaoID) REFERENCES Posicao (PosicaoID),	
	CONSTRAINT joga_posicao_pk PRIMARY KEY (NIF,PosicaoID)
);



CREATE TABLE Estadio (
	EstadioID NUMBER DEFAULT seq_idEstadio.NEXTVAL,
	NomeEstadio varchar(250),
    Localidade varchar(250),

   /* CONSTRAINT fk_estadio_localidade FOREIGN KEY (lOCALIDADE) REFERENCES MORADA (LOCALIDADE), */
	CONSTRAINT estadio_pk PRIMARY KEY (EstadioID)

);

CREATE TABLE Equipas (
	EquipaID NUMBER DEFAULT seq_idEquipa.NEXTVAL,
	NomeEquipa varchar(250),
	PosicaoTabela NUMBER,
	EstadioID NUMBER,

	CONSTRAINT equipas_pk PRIMARY KEY (EquipaID),
	CONSTRAINT fk_EstadioID FOREIGN KEY (EstadioID) REFERENCES Estadio (EstadioID)	

);

CREATE TABLE Jogo (
	/*In Oracle SQL don't exist a data type for hours*/
	Hora NUMBER, 
	DataJogo DATE NOT NULL,	
	Resultado varchar(10),
	Casa NUMBER(1),
	EquipaID NUMBER,
	/*verify if Casa value is either 1 or 0*/
	CONSTRAINT ck_jogo_casa CHECK (Casa IN (1,0)),
	
	CONSTRAINT fk_equipa_jogo FOREIGN KEY (EquipaID) REFERENCES Equipas (EquipaID),	

	/*Is really necessary have the hour as a key? Is not like the same two teams have two games in a same day.*/
	CONSTRAINT jogo_pk PRIMARY KEY (Hora,DataJogo,EquipaID)
);

CREATE TABLE Convocatoria (
	Hora NUMBER,
	DataJogo DATE NOT NULL,
	EquipaID NUMBER,
	NIF NUMBER,
	MinutosJogados NUMBER, /*deve ser entre 0 e 90*/
    /*verify if MinutosJogados value is between 0  and 90*/
	CONSTRAINT ck_convocatoria_Minutos CHECK (MinutosJogados BETWEEN 0 AND 90),

	CONSTRAINT fk_convocatoria_jogo FOREIGN KEY (Hora,DataJogo,EquipaID) REFERENCES Jogo (Hora,DataJogo,EquipaID),	

	CONSTRAINT fk_convocatoria_jogador FOREIGN KEY (NIF) REFERENCES Jogador (NIF),	

	CONSTRAINT convocatoria_pk PRIMARY KEY (NIF,Hora,DataJogo,EquipaID)
);

CREATE TABLE TipoAcao (
	TipoAcaoID NUMBER DEFAULT seq_idAcao.NEXTVAL,
	Descricao varchar(250),

	CONSTRAINT tipoAcao_pk PRIMARY KEY (TipoAcaoID)
 );


 CREATE TABLE Acoes (
	Hora NUMBER,
	DataJogo DATE NOT NULL,
	EquipaID NUMBER,
	NIF NUMBER,
	Minuto NUMBER, /*deve ser entre 0 e 90*/
	TipoAcaoID NUMBER,
     /*verify if MinutosJogados value is between 0  and 90*/
	CONSTRAINT ck_acoes_Minuto CHECK (Minuto BETWEEN 0 AND 90),

	CONSTRAINT fk_Acoes_convocatoria FOREIGN KEY (NIF,Hora,DataJogo,EquipaID) REFERENCES Convocatoria (NIF,Hora,DataJogo,EquipaID),	

	CONSTRAINT fk_acoes_tipo FOREIGN KEY (TipoAcaoID) REFERENCES TipoAcao (TipoAcaoID),	

	CONSTRAINT Acoes_pk PRIMARY KEY (NIF,Hora,DataJogo,EquipaID,Minuto)
 );

CREATE TABLE TipoT (
	TipoTID NUMBER DEFAULT seq_id.NEXTVAL,
	DescricaoT varchar(250),

	CONSTRAINT tipot_pk PRIMARY KEY (TipoTID)
 );
 
CREATE TABLE Transferencias (
	TransferenciaID NUMBER DEFAULT seq_id.NEXTVAL,
	Valor NUMBER,
	DataT DATE NOT NULL,
	NIF NUMBER,
	TipoTID NUMBER,
	
	CONSTRAINT fk_transferencias_tipo FOREIGN KEY (TipoTID) REFERENCES TipoT (TipoTID),	
    CONSTRAINT fk_transferencia_nif FOREIGN KEY (NIF) REFERENCES Jogador (NIF),
    
	CONSTRAINT transferencias_pk PRIMARY KEY (TransferenciaID)
 );

CREATE TABLE Transferencia_equipa(
	EquipaID NUMBER,
	TransferenciaID NUMBER,
    NIF NUMBER,

	CONSTRAINT fk_transferencia_te FOREIGN KEY (TransferenciaID) REFERENCES Transferencias (TransferenciaID),	

	CONSTRAINT fk_equipa_te FOREIGN KEY (EquipaID) REFERENCES Equipas (EquipaID),	

	CONSTRAINT transferencia_equipa_pk PRIMARY KEY (EquipaID, TransferenciaID)
);


/*INSERT NEW DATA*/


/*MORADA*/

INSERT INTO Morada (Localidade, Pais)
VALUES ('Almada', 'Portugal');
commit;

INSERT INTO Morada (Localidade, Pais)
VALUES ('Fern�o Ferro', 'Portugal');
commit;

INSERT INTO Morada (Localidade, Pais)
VALUES ('Braga', 'Portugal');
commit;

INSERT INTO Morada (Localidade, Pais)
VALUES ('Seixal', 'Portugal');
commit;

INSERT INTO Morada (Localidade, Pais)
VALUES ('Amora', 'Portugal');
commit;

INSERT INTO Morada (Localidade, Pais)
VALUES ('Lisboa', 'Portugal');
commit;

INSERT INTO Morada (Localidade, Pais)
VALUES ('Porto', 'Portugal');
commit;

INSERT INTO Morada (Localidade, Pais)
VALUES ('Mirandela', 'Portugal');
commit;

INSERT INTO Morada (Localidade, Pais)
VALUES ('Algarve', 'Portugal');
commit;

INSERT INTO Morada (Localidade, Pais)
VALUES ('Saint Petersburg', 'Russia');
commit;

INSERT INTO Morada (Localidade, Pais)
VALUES ('Faro', 'Portugal');
commit;

INSERT INTO Morada (Localidade, Pais)
VALUES ('Manchester', 'Inglaterra');
commit;


/*Pessoas*/

INSERT INTO Pessoas (NIF,Nome, Salario, DataInicioC, DataFimC, DataNascimento, Nacionalidade, Localidade)
VALUES (234567890,'Jorge Jesus', 300000000, '2023-01-01', '2023-12-31', '1954-07-24', 'Portuguesa', 'Almada');
commit;

INSERT INTO Pessoas (NIF,Nome, Salario, DataInicioC, DataFimC, DataNascimento, Nacionalidade, Localidade)
VALUES (234567890,'Pep Guardiola', 300000000, '2023-01-01', '2023-12-31', '1971-01-18', 'Espanhola', 'Manchester');
commit;

/*DEVE DAR ERRO*/
INSERT INTO Pessoas (NIF,Nome, Salario, DataInicioC, DataFimC, DataNascimento, Nacionalidade, Localidade)
VALUES (234567891,'Cristiano Ronaldo', 3000000000, '2023-01-01', '2023-12-31', '1985-02-05', 'Portuguesa', 'Funchal');
commit;

INSERT INTO Pessoas (NIF,Nome, Salario, DataInicioC, DataFimC, DataNascimento, Nacionalidade, Localidade)
VALUES (234567890,'Jorge Jesus', 300000000, '2023-01-01', '2023-12-31', '1954-07-24', 'Portuguesa', 'Almada');
commit;

/*NOVA MORADA*/
INSERT INTO Morada (Localidade, Pais)
VALUES ('Funchal', 'Portugal');
commit;
/*AGORA JA FUNCIONA*/
INSERT INTO Pessoas (NIF,Nome, Salario, DataInicioC, DataFimC, DataNascimento, Nacionalidade, Localidade)
VALUES (234567891,'Cristiano Ronaldo', 3000000000, '2023-01-01', '2023-12-31', '1985-02-05', 'Portuguesa', 'Funchal');
commit;

INSERT INTO Pessoas (NIF,Nome, Salario, DataInicioC, DataFimC, DataNascimento, Nacionalidade, Localidade)
VALUES (200800123,'Francisco Almeida', 60000000, TO_DATE('2023-06-23','YYYY-MM-DD'), TO_DATE('2025-06-23', 'YYYY-MM-DD'),
TO_DATE('1997-04-16', 'YYYY-MM-DD'), 'Portuguesa', 'Seixal');
commit;

select * from pessoas;

INSERT INTO Pessoas (NIF,Nome, Salario, DataInicioC, DataFimC, DataNascimento, Nacionalidade, Localidade)
VALUES (220803192,'Tiago Monteiro', 75000000, TO_DATE('2021-09-16', 'YYYY-MM-DD'), TO_DATE('2025-09-16', 'YYYY-MM-DD'),
TO_DATE('1996-03-20', 'YYYY-MM-DD'), 'Portuguesa', 'Amora');
commit;

INSERT INTO Pessoas (NIF,Nome, Salario, DataInicioC, DataFimC, DataNascimento, Nacionalidade, Localidade)
VALUES (220805128,'Nuno Fernandes', 45000000, TO_DATE('2022-07-06', 'YYYY-MM-DD'), TO_DATE('2026-07-06', 'YYYY-MM-DD'),
TO_DATE('2000-01-02', 'YYYY-MM-DD'), 'Portuguesa', 'Braga');
commit;

INSERT INTO Pessoas (NIF,Nome, Salario, DataInicioC, DataFimC, DataNascimento, Nacionalidade, Localidade)
VALUES (209815158,'S�rgio Fernandes', 65000000, TO_DATE('2021-09-04', 'YYYY-MM-DD'), TO_DATE('2025-09-04', 'YYYY-MM-DD'),
TO_DATE('1996-04-08', 'YYYY-MM-DD'), 'Portuguesa', 'Lisboa');
commit;

INSERT INTO Pessoas (NIF,Nome, Salario, DataInicioC, DataFimC, DataNascimento, Nacionalidade, Localidade)
VALUES (225805900,'Augusto Moreira', 15000000, TO_DATE('2023-09-20', 'YYYY-MM-DD'), TO_DATE('2027-09-20', 'YYYY-MM-DD'), 
TO_DATE('1993-06-25', 'YYYY-MM-DD'), 'Portuguesa', 'Fern�o Ferro');
commit;

INSERT INTO Pessoas (NIF,Nome, Salario, DataInicioC, DataFimC, DataNascimento, Nacionalidade, Localidade)
VALUES (200845144,'Ant�nio Baltazar', 85000000, TO_DATE('2022-07-15', 'YYYY-MM-DD'), TO_DATE('2025-07-15', 'YYYY-MM-DD'),
TO_DATE('1997-10-11', 'YYYY-MM-DD'), 'Portuguesa', 'Mirandela');
commit;

INSERT INTO Pessoas (NIF,Nome, Salario, DataInicioC, DataFimC, DataNascimento, Nacionalidade, Localidade)
VALUES (224825103,'Benedito Pereira', 95000000, TO_DATE('2022-12-31', 'YYYY-MM-DD'), TO_DATE('2024-12-31', 'YYYY-MM-DD'),
TO_DATE('1994-08-12', 'YYYY-MM-DD'), 'Portuguesa', 'Lisboa');
commit;

INSERT INTO Pessoas (NIF,Nome, Salario, DataInicioC, DataFimC, DataNascimento, Nacionalidade, Localidade)
VALUES (204805103,'Joaquim Gon�alves', 99000000, TO_DATE('2020-12-20', 'YYYY-MM-DD'), TO_DATE('2024-12-20', 'YYYY-MM-DD'), 
TO_DATE('2001-01-29', 'YYYY-MM-DD'), 'Portuguesa', 'Almada');
commit;

INSERT INTO Pessoas (NIF,Nome, Salario, DataInicioC, DataFimC, DataNascimento, Nacionalidade, Localidade)
VALUES (206865113,'Gon�alo Ramos', 999000000, TO_DATE('2021-12-16', 'YYYY-MM-DD'), TO_DATE('2025-12-16', 'YYYY-MM-DD'),
TO_DATE('1997-12-17', 'YYYY-MM-DD'), 'Portuguesa', 'Lisboa');
commit;

select * from pessoas;
 
/*JOGADOR*/

INSERT INTO Jogador (NIF)
VALUES (200800123);
commit;

INSERT INTO Jogador (NIF)
VALUES (220803192);
commit;

INSERT INTO Jogador (NIF)
VALUES (220805128);
commit;

INSERT INTO Jogador (NIF)
VALUES (209815158);
commit;

INSERT INTO Jogador (NIF)
VALUES (225805900);
commit;

INSERT INTO Jogador (NIF)
VALUES (200845144);
commit;

INSERT INTO Jogador (NIF)
VALUES (224825103);
commit;

INSERT INTO Jogador (NIF)
VALUES (204805103);
commit;

INSERT INTO Jogador (NIF)
VALUES (206865113);
commit;

INSERT INTO Jogador (NIF)
VALUES (234567891);
commit;

/*TREINADOR*/

INSERT INTO TREINADORES (NIF,CARGO)
VALUES (234567890,'Principal');

INSERT INTO TREINADORES (NIF,CARGO)
VALUES (234567888,'Adjunto');
commit;

DELETE FROM Jogador;
commit;
SELECT * FROM JOGADOR;
SELECT * FROM TREINADORES;


select * from jogador 
natural join pessoas;

/*ESTADIOS*/

INSERT INTO Estadio(EstadioID, NomeEstadio, Localidade)
VALUES (seq_idEstadio.NEXTVAL, 'Estadio da Luz', 'Lisboa');
commit;

INSERT INTO Estadio(EstadioID, NomeEstadio, Localidade)
VALUES (seq_idEstadio.NEXTVAL, 'Estádio José Alvalade', 'Lisboa');
commit;

INSERT INTO Estadio(EstadioID, NomeEstadio, Localidade)
VALUES (seq_idEstadio.NEXTVAL, 'Estádio do Dragão', 'Porto');
commit;


/* Para reiniciar uma sequencia
/*DELETE FROM Estadio where NomeEstadio = 'Estadio da Luz';
ALTER SEQUENCE seq_idEstadio RESTART;*/



/*EQUIPA*/

INSERT INTO Equipas (EquipaID , NomeEquipa, PosicaoTabela, EstadioID)
VALUES (seq_idEquipa.NEXTVAL,'Benfica', '1', '1');
commit;

INSERT INTO Equipas (EquipaID , NomeEquipa, PosicaoTabela, EstadioID)
VALUES (seq_idEquipa.NEXTVAL,'Sporting', '2', '2');
commit;

INSERT INTO Equipas (EquipaID , NomeEquipa, PosicaoTabela, EstadioID)
VALUES (seq_idEquipa.NEXTVAL,'Porto', '3', '3');
commit;

/*Posicoes*/

INSERT INTO Posicao(PosicaoID, Descricao)
VALUES (seq_idPos.NEXTVAL, 'Guarda Redes');
commit;

INSERT INTO Posicao(PosicaoID, Descricao)
VALUES (seq_idPos.NEXTVAL, 'Defesa Lateral Esquerdo');
commit;

INSERT INTO Posicao(PosicaoID, Descricao)
VALUES (seq_idPos.NEXTVAL, 'Defesa Lateral Direito');
commit;

INSERT INTO Posicao(PosicaoID, Descricao)
VALUES (seq_idPos.NEXTVAL, 'Defesa Central');
commit;

INSERT INTO Posicao(PosicaoID, Descricao)
VALUES (seq_idPos.NEXTVAL, 'Médio Defensivo');
commit;

INSERT INTO Posicao(PosicaoID, Descricao)
VALUES (seq_idPos.NEXTVAL, 'Médio Centro');
commit;

INSERT INTO Posicao(PosicaoID, Descricao)
VALUES (seq_idPos.NEXTVAL, 'Meia-atacante');
commit;

INSERT INTO Posicao(PosicaoID, Descricao)
VALUES (seq_idPos.NEXTVAL, 'Meio-campista Esquerdo');
commit;

INSERT INTO Posicao(PosicaoID, Descricao)
VALUES (seq_idPos.NEXTVAL, 'Meio-campista Direito');
commit;

INSERT INTO Posicao(PosicaoID, Descricao)
VALUES (seq_idPos.NEXTVAL, 'Falso 9');
commit;

INSERT INTO Posicao(PosicaoID, Descricao)
VALUES (seq_idPos.NEXTVAL, 'Extremo Esquerdo');
commit;

INSERT INTO Posicao(PosicaoID, Descricao)
VALUES (seq_idPos.NEXTVAL, 'Extremo Direito');
commit;

INSERT INTO Posicao(PosicaoID, Descricao)
VALUES (seq_idPos.NEXTVAL, 'Ponta de Lança');
commit;

/*Posicao do jogador*/
/*so para testar se ta bom, ex do Ronaldo*/
INSERT INTO Joga_Posicao(PosicaoID, NIF)
VALUES('13', 234567891);
commit;

/*TipoAcoes*/

INSERT INTO TipoAcao(TipoAcaoID, Descricao)
VALUES(seq_idAcao.NEXTVAL, 'Golos');
commit;

INSERT INTO TipoAcao(TipoAcaoID, Descricao)
VALUES(seq_idAcao.NEXTVAL, 'Assistencias');
commit;

INSERT INTO TipoAcao(TipoAcaoID, Descricao)
VALUES(seq_idAcao.NEXTVAL, 'Remate');
commit;

INSERT INTO TipoAcao(TipoAcaoID, Descricao)
VALUES(seq_idAcao.NEXTVAL, 'Remate à baliza');
commit;


INSERT INTO TipoAcao(TipoAcaoID, Descricao)
VALUES(seq_idAcao.NEXTVAL, 'Passes');
commit;

INSERT INTO TipoAcao(TipoAcaoID, Descricao)
VALUES(seq_idAcao.NEXTVAL, 'Faltas');
commit;

INSERT INTO TipoAcao(TipoAcaoID, Descricao)
VALUES(seq_idAcao.NEXTVAL, 'Cartão Amarelo');
commit;

INSERT INTO TipoAcao(TipoAcaoID, Descricao)
VALUES(seq_idAcao.NEXTVAL, 'Cartão Vermelho');
commit;

INSERT INTO TipoAcao(TipoAcaoID, Descricao)
VALUES(seq_idAcao.NEXTVAL, 'Foras de jogo');
commit;

INSERT INTO TipoAcao(TipoAcaoID, Descricao)
VALUES(seq_idAcao.NEXTVAL, 'Cantos');
commit;

INSERT INTO TipoAcao(TipoAcaoID, Descricao)
VALUES(seq_idAcao.NEXTVAL, 'Posse de Bola');
commit;

/*Convocatoria*/
/*Exemplo para ver se funciona, Ronaldo jogou 60 minutos */
INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(2000, '2023-05-20', 1, 234567891, 60);
commit;

/*Acoes*/
/*Exemplo para ver se funciona, Ronaldo marcou golo pelo benfica no minuto 32*/

INSERT INTO Acoes(Hora, DataJogo, EquipaID, NIF, Minuto, TipoAcaoID)
VALUES(2000, '2023-05-20', 1, 234567891, 32, 1);
commit;


ALTER TABLE estadio
ADD CONSTRAINT fk_estadio_localidade FOREIGN KEY (lOCALIDADE) REFERENCES MORADA (LOCALIDADE);

commit;









