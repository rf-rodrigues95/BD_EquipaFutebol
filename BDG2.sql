
Table PESSOAS dropped.


Table TREINADORES dropped.


Table JOGADOR dropped.


Table POSICAO dropped.


Table JOGA_POSICAO dropped.


Table MORADA dropped.


Table TIPOT dropped.


Table JOGO dropped.


Table TRANSFERENCIAS dropped.


Table TRANSFERENCIA_EQUIPA dropped.


Table CONVOCATORIA dropped.


Table ESTADIO dropped.


Table EQUIPAS dropped.


Table ACOES dropped.


Table TIPOACAO dropped.


Sequence SEQ_ID dropped.


Sequence SEQ_IDESTADIO dropped.


Sequence SEQ_IDEQUIPA dropped.


Sequence SEQ_IDPOS dropped.


Sequence SEQ_IDACAO dropped.


Error starting at line : 26 in command -
DROP TRIGGER PosicaoPK
Error report -
ORA-04080: trigger 'POSICAOPK' não existe
04080. 00000 -  "trigger '%s' does not exist"
*Cause:    The TRIGGER name is invalid.
*Action:   Check the trigger name.

Error starting at line : 27 in command -
DROP TRIGGER EquipaPK
Error report -
ORA-04080: trigger 'EQUIPAPK' não existe
04080. 00000 -  "trigger '%s' does not exist"
*Cause:    The TRIGGER name is invalid.
*Action:   Check the trigger name.

Error starting at line : 28 in command -
DROP TRIGGER EstadioPK
Error report -
ORA-04080: trigger 'ESTADIOPK' não existe
04080. 00000 -  "trigger '%s' does not exist"
*Cause:    The TRIGGER name is invalid.
*Action:   Check the trigger name.

Error starting at line : 29 in command -
DROP TRIGGER check_nif_before_insert_new_manager
Error report -
ORA-04080: trigger 'CHECK_NIF_BEFORE_INSERT_NEW_MANAGER' não existe
04080. 00000 -  "trigger '%s' does not exist"
*Cause:    The TRIGGER name is invalid.
*Action:   Check the trigger name.

Error starting at line : 30 in command -
DROP TRIGGER check_nif_before_insert_new_player
Error report -
ORA-04080: trigger 'CHECK_NIF_BEFORE_INSERT_NEW_PLAYER' não existe
04080. 00000 -  "trigger '%s' does not exist"
*Cause:    The TRIGGER name is invalid.
*Action:   Check the trigger name.

Sequence SEQ_ID created.


Sequence SEQ_IDESTADIO created.


Sequence SEQ_IDEQUIPA created.


Sequence SEQ_IDPOS created.


Sequence SEQ_IDACAO created.


Table MORADA created.


Table PESSOAS created.


Table TREINADORES created.


Table JOGADOR created.


Table POSICAO created.


Table JOGA_POSICAO created.


Table ESTADIO created.


Table EQUIPAS created.


Table JOGO created.


Table CONVOCATORIA created.


Table TIPOACAO created.


Table ACOES created.


Table TIPOT created.


Table TRANSFERENCIAS created.


Table TRANSFERENCIA_EQUIPA created.


Trigger POSICAOPK compiled


Trigger EQUIPAPK compiled


Trigger ESTADIOPK compiled


Trigger CHECK_NIF_BEFORE_INSERT_NEW_PLAYER compiled


Trigger CHECK_NIF_BEFORE_INSERT_NEW_MANAGER compiled


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


LOCALIDADE                                                                                                                                                                                                                                                 PAIS                                                                                                                                                                                                                                                      
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Almada                                                                                                                                                                                                                                                     Portugal                                                                                                                                                                                                                                                  
Fernao Ferro                                                                                                                                                                                                                                               Portugal                                                                                                                                                                                                                                                  
Braga                                                                                                                                                                                                                                                      Portugal                                                                                                                                                                                                                                                  
Seixal                                                                                                                                                                                                                                                     Portugal                                                                                                                                                                                                                                                  
Amora                                                                                                                                                                                                                                                      Portugal                                                                                                                                                                                                                                                  
Lisboa                                                                                                                                                                                                                                                     Portugal                                                                                                                                                                                                                                                  
Porto                                                                                                                                                                                                                                                      Portugal                                                                                                                                                                                                                                                  
Mirandela                                                                                                                                                                                                                                                  Portugal                                                                                                                                                                                                                                                  
Algarve                                                                                                                                                                                                                                                    Portugal                                                                                                                                                                                                                                                  
Saint Petersburg                                                                                                                                                                                                                                           Russia                                                                                                                                                                                                                                                    
Faro                                                                                                                                                                                                                                                       Portugal                                                                                                                                                                                                                                                  

LOCALIDADE                                                                                                                                                                                                                                                 PAIS                                                                                                                                                                                                                                                      
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Manchester                                                                                                                                                                                                                                                 Inglaterra                                                                                                                                                                                                                                                

12 rows selected. 


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


       NIF NOME                                                                                                                                                                                                                                                          SALARIO DATAINIC DATAFIMC DATANASC NACIONALIDADE                                                                                                                                                                                                                                              LOCALIDADE                                                                                                                                                                                                                                                
---------- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ---------- -------- -------- -------- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 234567890 Jorge Jesus                                                                                                                                                                                                                                                 300000000 23.01.01 23.12.31 54.07.24 Portuguesa                                                                                                                                                                                                                                                 Almada                                                                                                                                                                                                                                                    
 234567891 Pep Guardiola                                                                                                                                                                                                                                               300000000 23.01.01 23.12.31 71.01.18 Espanhola                                                                                                                                                                                                                                                  Manchester                                                                                                                                                                                                                                                


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


       NIF NOME                                                                                                                                                                                                                                                          SALARIO DATAINIC DATAFIMC DATANASC NACIONALIDADE                                                                                                                                                                                                                                              LOCALIDADE                                                                                                                                                                                                                                                
---------- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ---------- -------- -------- -------- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 234567890 Jorge Jesus                                                                                                                                                                                                                                                 300000000 23.01.01 23.12.31 54.07.24 Portuguesa                                                                                                                                                                                                                                                 Almada                                                                                                                                                                                                                                                    
 234567891 Pep Guardiola                                                                                                                                                                                                                                               300000000 23.01.01 23.12.31 71.01.18 Espanhola                                                                                                                                                                                                                                                  Manchester                                                                                                                                                                                                                                                
 234567893 Cristiano Ronaldo                                                                                                                                                                                                                                          3000000000 23.01.01 23.12.31 85.02.05 Portuguesa                                                                                                                                                                                                                                                 Funchal                                                                                                                                                                                                                                                   
 200800123 Francisco Almeida                                                                                                                                                                                                                                            60000000 23.06.23 25.06.23 97.04.16 Portuguesa                                                                                                                                                                                                                                                 Seixal                                                                                                                                                                                                                                                    


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


       NIF
----------
 200800123


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


       NIF
----------
 200800123
 200845144
 204805103
 206865113
 209815158
 220803192
 220805128
 224825103
 225805900
 234567891

10 rows selected. 


1 row inserted.


Commit complete.


Error starting at line : 466 in command -
INSERT INTO TREINADORES (NIF,CARGO)
VALUES (234567891,'Adjunto')
Error report -
ORA-20001: NIF already exists in Treinadores table.
ORA-06512: na "BDG106.CHECK_NIF_BEFORE_INSERT_NEW_MANAGER", linha 9
ORA-04088: erro durante a execução do trigger 'BDG106.CHECK_NIF_BEFORE_INSERT_NEW_MANAGER'


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


1 row inserted.


Commit complete.


       NIF
----------
 200800123
 200845144
 204805103
 206865113
 209815158
 220803192
 220805128
 224825103
 225805900
 234567891

10 rows selected. 


       NIF CARGO                                                                                                                                                                                                                                                     
---------- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 234567890 Principal                                                                                                                                                                                                                                                 


  EQUIPAID NOMEEQUIPA                                                                                                                                                                                                                                                 POSICAOTABELA  ESTADIOID
---------- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ------------- ----------
         1 Benfica                                                                                                                                                                                                                                                                1          1
         2 Sporting                                                                                                                                                                                                                                                               2          2
         3 Porto                                                                                                                                                                                                                                                                  3          3


      HORA DATAJOGO RESULTADO        CASA   EQUIPAID
---------- -------- ---------- ---------- ----------
      2000 23.05.20 10-0                1          1


      HORA DATAJOGO   EQUIPAID        NIF MINUTOSJOGADOS
---------- -------- ---------- ---------- --------------
      2000 23.05.20          1  200800123             60


      HORA DATAJOGO   EQUIPAID        NIF     MINUTO TIPOACAOID
---------- -------- ---------- ---------- ---------- ----------
      2000 23.05.20          1  200800123         32          1


 POSICAOID DESCRICAO                                                                                                                                                                                                                                                 
---------- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
         1 Guarda Redes                                                                                                                                                                                                                                              
         2 Defesa Lateral Esquerdo                                                                                                                                                                                                                                   
         3 Defesa Lateral Direito                                                                                                                                                                                                                                    
         4 Defesa Central                                                                                                                                                                                                                                            
         5 Médio Defensivo                                                                                                                                                                                                                                           
         6 Médio Centro                                                                                                                                                                                                                                              
         7 Meia-atacante                                                                                                                                                                                                                                             
         8 Meio-campista Esquerdo                                                                                                                                                                                                                                    
         9 Meio-campista Direito                                                                                                                                                                                                                                     
        10 Falso 9                                                                                                                                                                                                                                                   
        11 Extremo Esquerdo                                                                                                                                                                                                                                          

 POSICAOID DESCRICAO                                                                                                                                                                                                                                                 
---------- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        12 Extremo Direito                                                                                                                                                                                                                                           
        13 Ponta de Lança                                                                                                                                                                                                                                            

13 rows selected. 


 ESTADIOID NOMEESTADIO                                                                                                                                                                                                                                                LOCALIDADE                                                                                                                                                                                                                                                
---------- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
         1 Estadio da Luz                                                                                                                                                                                                                                             Lisboa                                                                                                                                                                                                                                                    
         2 Estádio José Alvalade                                                                                                                                                                                                                                      Lisboa                                                                                                                                                                                                                                                    
         3 Estádio do Dragão                                                                                                                                                                                                                                          Porto                                                                                                                                                                                                                                                     


       NIF NOME                                                                                                                                                                                                                                                          SALARIO DATAINIC DATAFIMC DATANASC NACIONALIDADE                                                                                                                                                                                                                                              LOCALIDADE                                                                                                                                                                                                                                                
---------- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ---------- -------- -------- -------- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 234567891 Pep Guardiola                                                                                                                                                                                                                                               300000000 23.01.01 23.12.31 71.01.18 Espanhola                                                                                                                                                                                                                                                  Manchester                                                                                                                                                                                                                                                
 200800123 Francisco Almeida                                                                                                                                                                                                                                            60000000 23.06.23 25.06.23 97.04.16 Portuguesa                                                                                                                                                                                                                                                 Seixal                                                                                                                                                                                                                                                    
 220803192 Tiago Monteiro                                                                                                                                                                                                                                               75000000 21.09.16 25.09.16 96.03.20 Portuguesa                                                                                                                                                                                                                                                 Amora                                                                                                                                                                                                                                                     
 220805128 Nuno Fernandes                                                                                                                                                                                                                                               45000000 22.07.06 26.07.06 00.01.02 Portuguesa                                                                                                                                                                                                                                                 Braga                                                                                                                                                                                                                                                     
 209815158 S�rgio Fernandes                                                                                                                                                                                                                                             65000000 21.09.04 25.09.04 96.04.08 Portuguesa                                                                                                                                                                                                                                                 Lisboa                                                                                                                                                                                                                                                    
 225805900 Augusto Moreira                                                                                                                                                                                                                                              15000000 23.09.20 27.09.20 93.06.25 Portuguesa                                                                                                                                                                                                                                                 Fernao Ferro                                                                                                                                                                                                                                              
 200845144 Ant�nio Baltazar                                                                                                                                                                                                                                             85000000 22.07.15 25.07.15 97.10.11 Portuguesa                                                                                                                                                                                                                                                 Mirandela                                                                                                                                                                                                                                                 
 224825103 Benedito Pereira                                                                                                                                                                                                                                             95000000 22.12.31 24.12.31 94.08.12 Portuguesa                                                                                                                                                                                                                                                 Lisboa                                                                                                                                                                                                                                                    
 204805103 Joaquim Gon�alves                                                                                                                                                                                                                                            99000000 20.12.20 24.12.20 01.01.29 Portuguesa                                                                                                                                                                                                                                                 Almada                                                                                                                                                                                                                                                    
 206865113 Gon�alo Ramos                                                                                                                                                                                                                                               999000000 21.12.16 25.12.16 97.12.17 Portuguesa                                                                                                                                                                                                                                                 Lisboa                                                                                                                                                                                                                                                    

10 rows selected. 


       NIF NOME                                                                                                                                                                                                                                                          SALARIO DATAINIC DATAFIMC DATANASC NACIONALIDADE                                                                                                                                                                                                                                              LOCALIDADE                                                                                                                                                                                                                                                 CARGO                                                                                                                                                                                                                                                     
---------- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ---------- -------- -------- -------- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 234567890 Jorge Jesus                                                                                                                                                                                                                                                 300000000 23.01.01 23.12.31 54.07.24 Portuguesa                                                                                                                                                                                                                                                 Almada                                                                                                                                                                                                                                                     Principal                                                                                                                                                                                                                                                 

