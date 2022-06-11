CREATE TABLE NEGOCIACAO (
  CODIGO INTEGER  NOT NULL,
  PRODUTOR INTEGER ,
  DISTRIBUIDOR INTEGER ,
  VALOR FLOAT,
  "DATA" DATE,
  STATUS SMALLINT);


ALTER TABLE NEGOCIACAO ADD PRIMARY KEY (CODIGO);