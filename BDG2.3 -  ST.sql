
/*2.3 SEM TRIGGERS*/

DROP TABLE Pessoas cascade constraints;
DROP TABLE Treinadores cascade constraints;
DROP TABLE Jogador cascade constraints;
DROP TABLE Posicao cascade constraints;
DROP TABLE Joga_Posicao cascade constraints;
DROP TABLE Morada cascade constraints;
DROP TABLE TipoT cascade constraints;
DROP TABLE Jogo cascade constraints;
DROP TABLE Transferencias cascade constraints; 
DROP TABLE Transferencia_equipa cascade constraints;
DROP TABLE CONVOCATORIA CASCADE CONSTRAINTS;
DROP TABLE Estadio cascade constraints;
DROP TABLE Equipas cascade constraints;
DROP TABLE Acoes cascade constraints;
DROP TABLE TipoAcao cascade constraints;
DROP SEQUENCE seq_id; 
DROP SEQUENCE seq_idEstadio; 
DROP SEQUENCE seq_idEquipa; 
DROP SEQUENCE seq_idPos; 
DROP SEQUENCE seq_idAcao; 
DROP SEQUENCE seq_idTrans; 
DROP SEQUENCE seq_idTipoT;
DROP TRIGGER check_nif_before_insert_new_manager;
DROP TRIGGER check_nif_before_insert_new_player;
commit;
/* CRIACAO DE SEQUENCIAS */

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
  
CREATE SEQUENCE seq_idTrans
  START WITH 1
  INCREMENT BY 1;
  
CREATE SEQUENCE seq_idTipoT
  START WITH 1
  INCREMENT BY 1;  

commit;

/* CRIACAO DE TABELAS */

CREATE TABLE Morada (
	Localidade varchar(250),
	Pais varchar(250),
    
    CONSTRAINT morada_pk PRIMARY KEY (Localidade)
);

commit;

CREATE TABLE Pessoas (
	NIF NUMBER NOT NULL,
	Nome varchar(250) NOT NULL,
	Salario NUMBER NOT NULL,
	DataInicioC DATE NOT NULL,
	DataFimC DATE NOT NULL,
	DataNascimento DATE NOT NULL,
	Nacionalidade varchar(250) NOT NULL,
	Localidade varchar(250) NOT NULL,

	CONSTRAINT pessoas_pk PRIMARY KEY (NIF),
    CONSTRAINT morada_pessoas_fk FOREIGN KEY (lOCALIDADE) REFERENCES MORADA (LOCALIDADE)
);

CREATE TABLE Treinadores (
	NIF NUMBER NOT NULL,
	Cargo varchar(250) NOT NULL,
	CONSTRAINT fk_Treinadores_Pessoa FOREIGN KEY (NIF) REFERENCES Pessoas (NIF),	
	CONSTRAINT treinadores_pk PRIMARY KEY (NIF)
);

CREATE TABLE Jogador (
	NIF NUMBER NOT NULL,
	CONSTRAINT fk_jogadores_Pessoa FOREIGN KEY (NIF) REFERENCES Pessoas (NIF),	
	CONSTRAINT jogador_pk PRIMARY KEY (NIF)
);

CREATE TABLE Posicao (
	PosicaoID NUMBER NOT NULL/*DEFAULT seq_idPos.NEXTVAL*/,
	Descricao varchar(250) NOT NULL,

	CONSTRAINT posicao_pk PRIMARY KEY (PosicaoID)
);

CREATE TABLE Joga_Posicao (
	PosicaoID NUMBER NOT NULL,
	NIF NUMBER NOT NULL,

	CONSTRAINT fk_jogadores_joga FOREIGN KEY (NIF) REFERENCES Jogador (NIF),		
	CONSTRAINT fk_posicao_joga FOREIGN KEY (PosicaoID) REFERENCES Posicao (PosicaoID),	
	CONSTRAINT joga_posicao_pk PRIMARY KEY (NIF,PosicaoID)
);

CREATE TABLE Estadio (
	EstadioID NUMBER NOT NULL,
	NomeEstadio varchar(250) NOT NULL,
    Localidade varchar(250) NOT NULL,

	CONSTRAINT estadio_pk PRIMARY KEY (EstadioID),
    CONSTRAINT fk_estadio_localidade FOREIGN KEY (lOCALIDADE) REFERENCES MORADA (LOCALIDADE)
);

CREATE TABLE Equipas (
	EquipaID NUMBER NOT NULL,
	NomeEquipa varchar(250) NOT NULL,
	PosicaoTabela NUMBER NOT NULL,
	EstadioID NUMBER NOT NULL,

	CONSTRAINT equipas_pk PRIMARY KEY (EquipaID),
	CONSTRAINT fk_EstadioID FOREIGN KEY (EstadioID) REFERENCES Estadio (EstadioID)	
);

CREATE TABLE Jogo (
	/*In Oracle SQL don't exist a data type for hours*/
	Hora NUMBER NOT NULL, 
	DataJogo DATE NOT NULL,	
	Resultado varchar(10),
	Casa NUMBER(1) NOT NULL,
	EquipaID NUMBER NOT NULL,
	/*verify if Casa value is either 1 or 0*/
	CONSTRAINT ck_jogo_casa CHECK (Casa IN (1,0)),
	
	CONSTRAINT fk_equipa_jogo FOREIGN KEY (EquipaID) REFERENCES Equipas (EquipaID),	

	/*Is really necessary have the hour as a key? Is not like the same two teams have two games in a same day.*/
	CONSTRAINT jogo_pk PRIMARY KEY (Hora,DataJogo,EquipaID)
);

CREATE TABLE Convocatoria (
	Hora NUMBER NOT NULL,
	DataJogo DATE NOT NULL,
	EquipaID NUMBER NOT NULL,
	NIF NUMBER NOT NULL,
	MinutosJogados NUMBER NOT NULL, /*deve ser entre 0 e 90*/
    /*verify if MinutosJogados value is between 0  and 90*/
	CONSTRAINT ck_convocatoria_Minutos CHECK (MinutosJogados BETWEEN 0 AND 90),

	CONSTRAINT fk_convocatoria_jogo FOREIGN KEY (Hora,DataJogo,EquipaID) REFERENCES Jogo (Hora,DataJogo,EquipaID),	

	CONSTRAINT fk_convocatoria_jogador FOREIGN KEY (NIF) REFERENCES Jogador (NIF),	

	CONSTRAINT convocatoria_pk PRIMARY KEY (NIF,Hora,DataJogo,EquipaID)
);

CREATE TABLE TipoAcao (
	TipoAcaoID NUMBER,
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
	TipoTID NUMBER,
	DescricaoT varchar(250),

	CONSTRAINT tipot_pk PRIMARY KEY (TipoTID)
 );
 
CREATE TABLE Transferencias (
	TransferenciaID NUMBER ,
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

/*Create Triggers*/


CREATE OR REPLACE TRIGGER check_nif_before_insert_new_player
BEFORE INSERT ON Jogador
FOR EACH ROW
DECLARE
    nif_exists NUMBER;
BEGIN
    SELECT COUNT(*) INTO nif_exists
    FROM Treinadores
    WHERE NIF = :NEW.NIF;

    IF nif_exists > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'NIF already exists in Treinadores table.');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER check_nif_before_insert_new_manager
BEFORE INSERT ON Treinadores
FOR EACH ROW
DECLARE
    nif_exists NUMBER;
BEGIN
    SELECT COUNT(*) INTO nif_exists
    FROM Jogador
    WHERE NIF = :NEW.NIF;

    IF nif_exists > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'NIF already exists in Jogador table.');
    END IF;
END;
/


commit;


/*INSERT NEW DATA*/

/*MORADA*/

INSERT INTO Morada (Localidade, Pais)
VALUES ('Almada', 'Portugal');
commit;

INSERT INTO Morada (Localidade, Pais)
VALUES ('Fernao Ferro', 'Portugal');
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

INSERT INTO Morada (Localidade, Pais)
VALUES ('Funchal', 'Portugal');
commit;

INSERT INTO morada(localidade, pais)
VALUES ('Rosario', 'Argentina');
commit;

/*SELECT * FROM MORADA;*/

/* PESSOAS */

INSERT INTO Pessoas (NIF,Nome, Salario, DataInicioC, DataFimC, DataNascimento, Nacionalidade, Localidade)
VALUES (234567890,'Jorge Jesus', 300000000, '2023-01-01', '2023-12-31', '1954-07-24', 'Portuguesa', 'Almada');
commit;

INSERT INTO Pessoas (NIF,Nome, Salario, DataInicioC, DataFimC, DataNascimento, Nacionalidade, Localidade)
VALUES (234567891,'Pep Guardiola', 300000000, '2023-01-01', '2023-12-31', '1971-01-18', 'Espanhola', 'Manchester');
commit;

INSERT INTO Pessoas (NIF,Nome, Salario, DataInicioC, DataFimC, DataNascimento, Nacionalidade, Localidade)
VALUES (234567893,'Cristiano Ronaldo', 3000000000, '2023-01-01', '2023-12-31', '1985-02-05', 'Portuguesa', 'Funchal');
commit;

INSERT INTO Pessoas (NIF,Nome, Salario, DataInicioC, DataFimC, DataNascimento, Nacionalidade, Localidade)
VALUES (200800123,'Francisco Almeida', 60000000, TO_DATE('2023-06-23','YYYY-MM-DD'), TO_DATE('2025-06-23', 'YYYY-MM-DD'),
TO_DATE('1997-04-16', 'YYYY-MM-DD'), 'Portuguesa', 'Seixal');
commit;

INSERT INTO Pessoas (NIF,Nome, Salario, DataInicioC, DataFimC, DataNascimento, Nacionalidade, Localidade)
VALUES (220803192,'Tiago Monteiro', 75000000, TO_DATE('2021-09-16', 'YYYY-MM-DD'), TO_DATE('2025-09-16', 'YYYY-MM-DD'),
TO_DATE('1996-03-20', 'YYYY-MM-DD'), 'Portuguesa', 'Amora');
commit;

INSERT INTO Pessoas (NIF,Nome, Salario, DataInicioC, DataFimC, DataNascimento, Nacionalidade, Localidade)
VALUES (220805128,'Nuno Fernandes', 45000000, TO_DATE('2022-07-06', 'YYYY-MM-DD'), TO_DATE('2026-07-06', 'YYYY-MM-DD'),
TO_DATE('2000-01-02', 'YYYY-MM-DD'), 'Portuguesa', 'Braga');
commit;

INSERT INTO Pessoas (NIF,Nome, Salario, DataInicioC, DataFimC, DataNascimento, Nacionalidade, Localidade)
VALUES (209815158,'S rgio Fernandes', 65000000, TO_DATE('2021-09-04', 'YYYY-MM-DD'), TO_DATE('2025-09-04', 'YYYY-MM-DD'),
TO_DATE('1996-04-08', 'YYYY-MM-DD'), 'Portuguesa', 'Lisboa');
commit;

INSERT INTO Pessoas (NIF,Nome, Salario, DataInicioC, DataFimC, DataNascimento, Nacionalidade, Localidade)
VALUES (225805900,'Augusto Moreira', 15000000, TO_DATE('2023-09-20', 'YYYY-MM-DD'), TO_DATE('2027-09-20', 'YYYY-MM-DD'), 
TO_DATE('1993-06-25', 'YYYY-MM-DD'), 'Portuguesa', 'Fernao Ferro');
commit;

INSERT INTO Pessoas (NIF,Nome, Salario, DataInicioC, DataFimC, DataNascimento, Nacionalidade, Localidade)
VALUES (200845144,'Ant nio Baltazar', 85000000, TO_DATE('2022-07-15', 'YYYY-MM-DD'), TO_DATE('2025-07-15', 'YYYY-MM-DD'),
TO_DATE('1997-10-11', 'YYYY-MM-DD'), 'Portuguesa', 'Mirandela');
commit;

INSERT INTO Pessoas (NIF,Nome, Salario, DataInicioC, DataFimC, DataNascimento, Nacionalidade, Localidade)
VALUES (224825103,'Benedito Pereira', 95000000, TO_DATE('2022-12-31', 'YYYY-MM-DD'), TO_DATE('2024-12-31', 'YYYY-MM-DD'),
TO_DATE('1994-08-12', 'YYYY-MM-DD'), 'Portuguesa', 'Lisboa');
commit;

INSERT INTO Pessoas (NIF,Nome, Salario, DataInicioC, DataFimC, DataNascimento, Nacionalidade, Localidade)
VALUES (204805103,'Joaquim Gon alves', 99000000, TO_DATE('2020-12-20', 'YYYY-MM-DD'), TO_DATE('2024-12-20', 'YYYY-MM-DD'), 
TO_DATE('2001-01-29', 'YYYY-MM-DD'), 'Portuguesa', 'Almada');
commit;

INSERT INTO Pessoas (NIF,Nome, Salario, DataInicioC, DataFimC, DataNascimento, Nacionalidade, Localidade)
VALUES (206865113,'Gon alo Ramos', 999000000, TO_DATE('2021-12-16', 'YYYY-MM-DD'), TO_DATE('2025-12-16', 'YYYY-MM-DD'),
TO_DATE('1997-12-17', 'YYYY-MM-DD'), 'Portuguesa', 'Lisboa');
commit;

INSERT INTO Pessoas (NIF,Nome, Salario, DataInicioC, DataFimC, DataNascimento, Nacionalidade, Localidade)
VALUES (201801101,'Lionel Messi', 1000000000, TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2027-01-01', 'YYYY-MM-DD'),
TO_DATE('1987-06-24', 'YYYY-MM-DD'), 'Argentina', 'Rosario');
commit;

/*select * from pessoas;*/
 
/* JOGADOR */

INSERT INTO Jogador (NIF)
VALUES (200800123);
commit;
select * from jogador;

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

insert into jogador(NIF)
values (201801101);
commit;

/*select * from jogador; */

/*TREINADOR*/

INSERT INTO TREINADORES (NIF,CARGO)
VALUES (234567890,'Principal');
commit;

INSERT INTO TREINADORES (NIF,CARGO)
VALUES (234567891,'Adjunto');
commit;

/*ESTADIOS*/

INSERT INTO Estadio(ESTADIOID,NomeEstadio, Localidade)
VALUES (seq_idEstadio.NEXTVAL,'Estadio da Luz', 'Lisboa');
commit;

INSERT INTO Estadio(ESTADIOID,NomeEstadio, Localidade)
VALUES (seq_idEstadio.NEXTVAL,'Estadio Jose Alvalade', 'Lisboa');
commit;

INSERT INTO Estadio(ESTADIOID,NomeEstadio, Localidade)
VALUES (seq_idEstadio.NEXTVAL,'Estadio do Dragao', 'Porto');
commit;

INSERT INTO Estadio(ESTADIOID,NomeEstadio, Localidade)
VALUES(seq_idEstadio.NEXTVAL,'Estadio de Lagos', 'Algarve');
commit;

INSERT INTO Estadio(ESTADIOID,NomeEstadio, Localidade)
VALUES(seq_idEstadio.NEXTVAL,'Estadio Municipal de Braga', 'Braga');
commit;

INSERT INTO Estadio(ESTADIOID,NomeEstadio, Localidade)
VALUES(seq_idEstadio.NEXTVAL,'Estadio Municipal de Almada', 'Almada');
commit;

/* Para reiniciar uma sequencia
/*DELETE FROM Estadio where NomeEstadio = 'Estadio da Luz';
ALTER SEQUENCE seq_idEstadio RESTART;*/

/*EQUIPA*/

INSERT INTO Equipas (EQUIPAID,NomeEquipa, PosicaoTabela, EstadioID)
VALUES (seq_idEquipa.NEXTVAL,'Benfica', 1, 1);
commit;

INSERT INTO Equipas (EQUIPAID,NomeEquipa, PosicaoTabela, EstadioID)
VALUES (seq_idEquipa.NEXTVAL,'Sporting', 2 , 2);
commit;

INSERT INTO Equipas (EQUIPAID,NomeEquipa, PosicaoTabela, EstadioID)
VALUES (seq_idEquipa.NEXTVAL,'Porto', 3, 3);
commit;

INSERT INTO Equipas(EQUIPAID,NomeEquipa, Posicaotabela, EstadioID)
VALUES (seq_idEquipa.NEXTVAL,'Paris Saint-Germain Football Club', 4, 4);
commit;

INSERT INTO Equipas(EQUIPAID,NomeEquipa, Posicaotabela, EstadioID)
VALUES (seq_idEquipa.NEXTVAL,'Braga', 5, 5);
commit;

INSERT INTO Equipas(EQUIPAID,NomeEquipa, Posicaotabela, EstadioID)
VALUES (seq_idEquipa.NEXTVAL,'Almada FC', 6, 6);
commit;

/* POSICOES */

INSERT INTO Posicao(PosicaoID,Descricao)
VALUES(seq_idPos.NEXTVAL,'Guarda Redes');
commit;

INSERT INTO Posicao(PosicaoID,Descricao)
VALUES(seq_idPos.NEXTVAL,'Defesa Lateral Esquerdo');
commit;

INSERT INTO Posicao(PosicaoID,Descricao)
VALUES(seq_idPos.NEXTVAL,'Defesa Lateral Direito');
commit;

INSERT INTO Posicao(PosicaoID,Descricao)
VALUES(seq_idPos.NEXTVAL,'Defesa Central');
commit;

INSERT INTO Posicao(PosicaoID,Descricao)
VALUES(seq_idPos.NEXTVAL,'Medio Defensivo');
commit;

INSERT INTO Posicao(PosicaoID,Descricao)
VALUES(seq_idPos.NEXTVAL,'Medio Centro');
commit;

INSERT INTO Posicao(PosicaoID,Descricao)
VALUES(seq_idPos.NEXTVAL,'Meia-atacante');
commit;

INSERT INTO Posicao(PosicaoID,Descricao)
VALUES(seq_idPos.NEXTVAL,'Meio-campista Esquerdo');
commit;

INSERT INTO Posicao(PosicaoID,Descricao)
VALUES(seq_idPos.NEXTVAL,'Meio-campista Direito');
commit;

INSERT INTO Posicao(PosicaoID,Descricao)
VALUES(seq_idPos.NEXTVAL,'Falso 9');
commit;

INSERT INTO Posicao(PosicaoID,Descricao)
VALUES(seq_idPos.NEXTVAL,'Extremo Esquerdo');
commit;

INSERT INTO Posicao(PosicaoID,Descricao)
VALUES(seq_idPos.NEXTVAL,'Extremo Direito');
commit;

INSERT INTO Posicao(PosicaoID,Descricao)
VALUES(seq_idPos.NEXTVAL,'Ponta de Lanca');
commit;

/*TipoAcoes*/

INSERT INTO TipoAcao(tipoAcaoID,Descricao)
VALUES(seq_idAcao.NEXTVAL,'Golo');
commit;

INSERT INTO TipoAcao(tipoAcaoID,Descricao)
VALUES(seq_idAcao.NEXTVAL,'Assistencia');
commit;

INSERT INTO TipoAcao(tipoAcaoID, Descricao)
VALUES(seq_idAcao.NEXTVAL,'Remate');
commit;

INSERT INTO TipoAcao(tipoAcaoID,Descricao)
VALUES(seq_idAcao.NEXTVAL,'Remate a baliza');
commit;

INSERT INTO TipoAcao(tipoAcaoID,Descricao)
VALUES(seq_idAcao.NEXTVAL,'Passes');
commit;

INSERT INTO TipoAcao(tipoAcaoID,Descricao)
VALUES(seq_idAcao.NEXTVAL,'Faltas');
commit;

INSERT INTO TipoAcao(tipoAcaoID,Descricao)
VALUES(seq_idAcao.NEXTVAL,'Cartao Amarelo');
commit;

INSERT INTO TipoAcao(tipoAcaoID,Descricao)
VALUES(seq_idAcao.NEXTVAL,'Cartao Vermelho');
commit;

INSERT INTO TipoAcao(tipoAcaoID,Descricao)
VALUES(seq_idAcao.NEXTVAL,'Foras de jogo');
commit;

INSERT INTO TipoAcao(tipoAcaoID,Descricao)
VALUES(seq_idAcao.NEXTVAL,'Cantos');
commit;

INSERT INTO TipoAcao(tipoAcaoID,Descricao)
VALUES(seq_idAcao.NEXTVAL,'Posse de Bola');
commit;

/* JOGO */
INSERT INTO JOGO (Hora, DataJogo,Resultado,Casa ,EquipaID)
VALUES (2000, '2023-05-20', '10-0', 1, 1);
COMMIT;

INSERT INTO JOGO (Hora, DataJogo,Resultado,Casa ,EquipaID)
VALUES (1900, '2023-06-05', '3-1', 0, 1);
COMMIT;

INSERT INTO JOGO (Hora, DataJogo,Resultado,Casa ,EquipaID)
VALUES (2000, '2023-06-13', '1-1', 1, 1);
COMMIT;

INSERT INTO JOGO (Hora, DataJogo,Resultado,Casa ,EquipaID)
VALUES (1800, '2023-06-22', '0-0', 1, 1);
COMMIT;

INSERT INTO JOGO (Hora, DataJogo,Resultado,Casa ,EquipaID)
VALUES (2030, '2023-06-29', '0-0', 1, 1);
COMMIT;

INSERT INTO JOGO (Hora, DataJogo,Resultado,Casa ,EquipaID)
VALUES (2100, '2023-07-04', '0-1', 1, 1);
COMMIT;

INSERT INTO JOGO (Hora, DataJogo,Resultado,Casa ,EquipaID)
VALUES (1700, '2023-07-10', '4-0', 1, 1);
COMMIT;

/* CONVOCATORIA */
-- JOGO 1 -- 
INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(2000, '2023-05-20', 1, 200800123, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(2000, '2023-05-20', 1, 200845144, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(2000, '2023-05-20', 1, 201801101, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(2000, '2023-05-20', 1, 204805103, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(2000, '2023-05-20', 1, 206865113, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(2000, '2023-05-20', 1, 209815158, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(2000, '2023-05-20', 1, 220803192, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(2000, '2023-05-20', 1, 220805128, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(2000, '2023-05-20', 1, 224825103, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(2000, '2023-05-20', 1, 225805900, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(2000, '2023-05-20', 1, 234567891, 90);
commit;

-- JOGO 2 --
INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(1900, '2023-06-05', 1, 200800123, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(1900, '2023-06-05', 1, 200845144, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(1900, '2023-06-05', 1, 201801101, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(1900, '2023-06-05', 1, 204805103, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(1900, '2023-06-05', 1, 206865113, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(1900, '2023-06-05', 1, 209815158, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(1900, '2023-06-05', 1, 220803192, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(1900, '2023-06-05', 1, 220805128, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(1900, '2023-06-05', 1, 224825103, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(1900, '2023-06-05', 1, 225805900, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(1900, '2023-06-05', 1, 234567891, 90);
commit;

-- JOGO 3 --
INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(2000, '2023-06-13', 1, 200800123, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(2000, '2023-06-13', 1, 200845144, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(2000, '2023-06-13', 1, 201801101, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(2000, '2023-06-13', 1, 204805103, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(2000, '2023-06-13', 1, 206865113, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(2000, '2023-06-13', 1, 209815158, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(2000, '2023-06-13', 1, 220803192, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(2000, '2023-06-13', 1, 220805128, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(2000, '2023-06-13', 1, 224825103, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(2000, '2023-06-13', 1, 225805900, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(2000, '2023-06-13', 1, 234567891, 90);
commit;

-- JOGO 4 --
INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(1800, '2023-06-22', 1, 200800123, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(1800, '2023-06-22', 1, 200845144, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(1800, '2023-06-22', 1, 201801101, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(1800, '2023-06-22', 1, 204805103, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(1800, '2023-06-22', 1, 206865113, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(1800, '2023-06-22', 1, 209815158, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(1800, '2023-06-22', 1, 220803192, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(1800, '2023-06-22', 1, 220805128, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(1800, '2023-06-22', 1, 224825103, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(1800, '2023-06-22', 1, 225805900, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(1800, '2023-06-22', 1, 234567891, 90);
commit;

-- JOGO 5 --
INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(2030, '2023-06-29', 1, 200800123, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(2030, '2023-06-29', 1, 200845144, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(2030, '2023-06-29', 1, 201801101, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(2030, '2023-06-29', 1, 204805103, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(2030, '2023-06-29', 1, 206865113, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(2030, '2023-06-29', 1, 209815158, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(2030, '2023-06-29', 1, 220803192, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(2030, '2023-06-29', 1, 220805128, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(2030, '2023-06-29', 1, 224825103, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(2030, '2023-06-29', 1, 225805900, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(2030, '2023-06-29', 1, 234567891, 90);
commit;

-- JOGO 6 --
INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(2100, '2023-07-04', 1, 200800123, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(2100, '2023-07-04', 1, 200845144, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(2100, '2023-07-04', 1, 201801101, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(2100, '2023-07-04', 1, 204805103, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(2100, '2023-07-04', 1, 206865113, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(2100, '2023-07-04', 1, 209815158, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(2100, '2023-07-04', 1, 220803192, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(2100, '2023-07-04', 1, 220805128, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(2100, '2023-07-04', 1, 224825103, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(2100, '2023-07-04', 1, 225805900, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(2100, '2023-07-04', 1, 234567891, 90);
commit;

--JOGO 7 --
INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(1700, '2023-07-10', 1, 200800123, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(1700, '2023-07-10', 1, 200845144, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(1700, '2023-07-10', 1, 201801101, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(1700, '2023-07-10', 1, 204805103, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(1700, '2023-07-10', 1, 206865113, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(1700, '2023-07-10', 1, 209815158, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(1700, '2023-07-10', 1, 220803192, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(1700, '2023-07-10', 1, 220805128, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(1700, '2023-07-10', 1, 224825103, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(1700, '2023-07-10', 1, 225805900, 90);
commit;

INSERT INTO Convocatoria(Hora, DataJogo, EquipaID, NIF, MinutosJogados)
VALUES(1700, '2023-07-10', 1, 234567891, 90);
commit;

/* JOGA POSICAO */

INSERT INTO Joga_Posicao(PosicaoID, NIF)
VALUES (1, 225805900);
commit;

INSERT INTO Joga_Posicao(PosicaoID, NIF)
VALUES (2, 200800123);
commit;

INSERT INTO Joga_Posicao(PosicaoID, NIF)
VALUES (3, 220803192);
commit;

INSERT INTO Joga_Posicao(PosicaoID, NIF)
VALUES (4, 220805128);
commit;

INSERT INTO Joga_Posicao(PosicaoID, NIF)
VALUES (5, 209815158);
commit;

INSERT INTO Joga_Posicao(PosicaoID, NIF)
VALUES (6, 225805900);
commit;

INSERT INTO Joga_Posicao(PosicaoID, NIF)
VALUES (7, 200845144);
commit;

INSERT INTO Joga_Posicao(PosicaoID, NIF)
VALUES (8, 224825103);
commit;

INSERT INTO Joga_Posicao(PosicaoID, NIF)
VALUES (11, 204805103);
commit;

INSERT INTO Joga_Posicao(PosicaoID, NIF)
VALUES (12, 206865113);
commit;

INSERT INTO Joga_Posicao(PosicaoID, NIF)
VALUES (9, 234567891);
commit;


/* ACOES */
/*Exemplo para ver se funciona, Ronaldo marcou golo pelo benfica no minuto 32*/
INSERT INTO Acoes(Hora, DataJogo, EquipaID, NIF, Minuto, TipoAcaoID)
VALUES(2000, '2023-05-20', 1, 200800123, 32, 1);
commit;

SELECT * FROM PESSOAS;
SELECT * FROM JOGADOR;
SELECT * FROM TREINADORES;
SELECT * FROM EQUIPAS;
SELECT * FROM JOGO;
SELECT * FROM CONVOCATORIA;
SELECT * FROM TIPOACAO;
SELECT * FROM ACOES NATURAL JOIN TIPOACAO;
SELECT * FROM POSICAO;
SELECT * FROM ESTADIO;
select * from pessoas natural join jogador ;
select * from pessoas natural join treinadores;
/*
TRIGGER:
-SEMPRE QUE INSERIR UMA ACAO VERIFICAR SE O MINUTO DA ACAO � INFERIOR OU IGUAL AOS MINUTOS JOGADOS PELO JOGADOR
*/

/* TIPO TRANSFERENCIA */

INSERT INTO TipoT (TipotID,DescricaoT)
VALUES(seq_idTipoT.NEXTVAL,'Compra');
commit;
select * from tipot;

INSERT INTO TipoT (TipotID,DescricaoT)
VALUES(seq_idTipoT.NEXTVAL,'Venda');
commit;

/* Quando fazemos o script isto não é preciso
update tipot
set descricaot='Compra' where tipot.descricaot='compra';
commit;

/* TRANSFERENCIAS */

INSERT INTO Transferencias (TransferenciaID,Valor, DataT, NIF, TipoTID)
VALUES(seq_idTrans.NEXTVAL, 1000000000, TO_DATE('2022-07-15', 'YYYY-MM-DD'),
201801101, 1);
commit;


/* TRANSFERENCIAS EQUIPA */

INSERT INTO Transferencia_equipa(EquipaID, TransferenciaID, NIF)
VALUES (4, 1, 201801101);
commit;

select * from transferencias natural join (transferencia_equipa natural join equipas);


commit;