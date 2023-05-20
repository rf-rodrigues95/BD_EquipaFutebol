Script for database creation

/*O jogo so deve ter 90 minutos*/

DROP TABLE Pessoas cascade constraints;
DROP TABLE Treinadores cascade constraints;
DROP TABLE Jogador cascade constraints;
DROP TABLE Posicao cascade constraints;
DROP TABLE Joga_Posicao cascade constraints;
DROP TABLE Morada cascade constraints;
DROP TABLE TipoT cascade constraints;
DROP TABLE Jogo cascade constraints;
DROP TABLE TransferenciaID cascade constraints;
DROP TABLE Transferencia_equipa cascade constraints;
/*O que faltava adicionar*/
DROP TABLE Estadio cascade constraints;
DROP TABLE Equipas cascade constraints;
DROP TABLE Acoes cascade constraints;
DROP TABLE TipoAcao cascade constraints;


CREATE SEQUENCE seq_id
  START WITH 1
  INCREMENT BY 1;

CREATE TABLE Pessoas (
	NIF NUMBER DEFAULT seq_id.NEXTVAL,
	Nome varchar(250),
	Salario NUMBER,
	DataInicioC DATE NOT NULL,
	DataFimC DATE NOT NULL,
	DataNascimento DATE NOT NULL
	Nacionalidade varchar(250),
	Localidade varchar(250),

	CONSTRAINT pessoas_pk PRIMARY KEY (NIF)
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
	PosicaoID NUMBER DEFAULT seq_id.NEXTVAL,
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

CREATE TABLE Morada (
	Localidade varchar(250),
	Pais varchar(250)
    
    CONSTRAINT morada_pk PRIMARY KEY (Localidade)
);

CREATE TABLE Estadio (
	EstadioID NUMBER DEFAULT seq_id.NEXTVAL,
	NomeEstadio varchar(250),
    Localidade varchar(250),

	CONSTRAINT estadio_pk PRIMARY KEY (EstadioID),
	CONSTRAINT fk_localidade FOREIGN KEY (Localidade) REFERENCES Morada (Localidade)

);

CREATE TABLE Equipas (
	EquipaID NUMBER DEFAULT seq_id.NEXTVAL,
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
