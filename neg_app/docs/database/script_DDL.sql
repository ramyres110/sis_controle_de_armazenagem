/* SQL Manager Lite for InterBase and Firebird 5.5.4.52620                                            */
/* -------------------------------------------------------------------------------------------------- */
/* Author: Ramyres Aquino - @ramyres110 */
/* Dt: 22/05/2020 */
/* Changed by Ramyres at 23/05/2020 */

CONNECT '..\..\data\DATABASE.fdb' USER 'sysdba' PASSWORD 'masterkey';

/* Structure for the `TB_USERS` table :  */
CREATE TABLE TB_USERS (
  ID INTEGER NOT NULL PRIMARY KEY,
  USERNAME VARCHAR(75) NOT NULL,
  "PASSWORD" VARCHAR(255) NOT NULL,
  CREATED_BY INTEGER,
  CREATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
  CHANGED_BY INTEGER,
  CHANGED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);
/* Definition for the `TB_USERS_ID_GEN` generator :  */
CREATE GENERATOR TB_USERS_ID_GEN;
/* Definition for the `BI_TB_USERS_ID` trigger :  */
SET TERM ^ ;
CREATE TRIGGER BI_TB_USERS_ID FOR TB_USERS ACTIVE BEFORE INSERT POSITION 0 AS
BEGIN
  IF (NEW.ID IS NULL) THEN
      NEW.ID = GEN_ID(TB_USERS_ID_GEN, 1);
END^
SET TERM ; ^



/* Structure for the `TB_STORAGES` table :  */
CREATE TABLE TB_STORAGES (
  ID INTEGER NOT NULL,
  "NAME" VARCHAR(255) NOT NULL,
  CREATED_BY INTEGER NOT NULL,
  CREATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
  CHANGED_BY INTEGER,
  CHANGED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);
ALTER TABLE TB_STORAGES ADD PRIMARY KEY (ID);
ALTER TABLE TB_STORAGES ADD CONSTRAINT FK_STOR_US_CREATED FOREIGN KEY (CREATED_BY) REFERENCES TB_USERS (ID) ON DELETE CASCADE;
ALTER TABLE TB_STORAGES ADD CONSTRAINT FK_STOR_US_CHANGED FOREIGN KEY (CHANGED_BY) REFERENCES TB_USERS (ID) ON DELETE CASCADE;
/* Definition for the `TB_STORAGES_ID_GEN` generator :  */
CREATE GENERATOR TB_STORAGES_ID_GEN;
/* Definition for the `BI_TB_STORAGES_ID` trigger :  */
SET TERM ^ ;
CREATE TRIGGER BI_TB_STORAGES_ID FOR TB_STORAGES ACTIVE BEFORE INSERT POSITION 0 AS
BEGIN
  IF (NEW.ID IS NULL) THEN
      NEW.ID = GEN_ID(TB_STORAGES_ID_GEN, 1);
END^
SET TERM ; ^



/* Structure for the `TB_GRAINS` table :  */
CREATE TABLE TB_GRAINS (
  ID INTEGER NOT NULL,
  "DESCRIPTION" VARCHAR(255) NOT NULL,
  PRICE_KG FLOAT NOT NULL,
  CREATED_BY INTEGER NOT NULL,
  CREATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
  CHANGED_BY INTEGER,
  CHANGED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);
ALTER TABLE TB_GRAINS ADD PRIMARY KEY (ID);
ALTER TABLE TB_GRAINS ADD CONSTRAINT FK_GRAN_US_CREATED FOREIGN KEY (CREATED_BY) REFERENCES TB_USERS (ID) ON DELETE CASCADE;
ALTER TABLE TB_GRAINS ADD CONSTRAINT FK_GRAN_US_CHANGED FOREIGN KEY (CHANGED_BY) REFERENCES TB_USERS (ID) ON DELETE CASCADE;
/* Definition for the `TB_GRAINS_ID_GEN` generator :  */
CREATE GENERATOR TB_GRAINS_ID_GEN;
/* Definition for the `BI_TB_GRAINS_ID` trigger :  */
SET TERM ^ ;
CREATE TRIGGER BI_TB_GRAINS_ID FOR TB_GRAINS ACTIVE BEFORE INSERT POSITION 0 AS
BEGIN
  IF (NEW.ID IS NULL) THEN
      NEW.ID = GEN_ID(TB_GRAINS_ID_GEN, 1);
END^
SET TERM ; ^



/* Structure for the `TB_PRODUCERS` table :  */
CREATE TABLE TB_PRODUCERS (
  ID INTEGER NOT NULL,
  "NAME" VARCHAR(255) NOT NULL,
  DOCUMENT VARCHAR(25) NOT NULL,
  PHONE VARCHAR(25),
  EMAIL VARCHAR(255),
  CREATED_BY INTEGER NOT NULL,
  CREATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
  CHANGED_BY INTEGER NOT NULL,
  CHANGED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);
ALTER TABLE TB_PRODUCERS ADD PRIMARY KEY (ID);
ALTER TABLE TB_PRODUCERS ADD CONSTRAINT FK_PROD_US_CREATED FOREIGN KEY (CREATED_BY) REFERENCES TB_USERS (ID) ON DELETE CASCADE;
ALTER TABLE TB_PRODUCERS ADD CONSTRAINT FK_PROD_US_CHANGED FOREIGN KEY (CHANGED_BY) REFERENCES TB_USERS (ID) ON DELETE CASCADE;
/* Definition for the `TB_PRODUCERS_ID_GEN` generator :  */
CREATE GENERATOR TB_PRODUCERS_ID_GEN;
/* Definition for the `BI_TB_PRODUCERS_ID` trigger :  */
SET TERM ^ ;
CREATE TRIGGER BI_TB_PRODUCERS_ID FOR TB_PRODUCERS ACTIVE BEFORE INSERT POSITION 0 AS
BEGIN
  IF (NEW.ID IS NULL) THEN
      NEW.ID = GEN_ID(TB_PRODUCERS_ID_GEN, 1);
END^
SET TERM ; ^



/* Structure for the `TB_CONTRACTS` table :  */
CREATE TABLE TB_CONTRACTS (
  ID INTEGER NOT NULL,
  STORAGE_ID INTEGER NOT NULL,
  PRODUCER_ID INTEGER NOT NULL,
  GRAIN_ID INTEGER NOT NULL,
  INITIAL_WEIGHT FLOAT,
  INITIAL_WEIGHTED_BY INTEGER,
  INITIAL_WEIGHTED_AT TIMESTAMP,
  FINAL_WEIGHT FLOAT,
  FINAL_WEIGHTED_BY INTEGER,
  FINAL_WEIGHTED_AT TIMESTAMP,
  MOISTURE_PERCENT FLOAT,
  MOISTURE_BY INTEGER,
  MOISTURE_AT TIMESTAMP,
  IS_VALIDATED SMALLINT DEFAULT 0,
  VALIDATED_BY VARCHAR(255),
  VALIDATED_AT TIMESTAMP,
  EXTERNAL_ID INTEGER,
  CREATED_BY INTEGER NOT NULL,
  CREATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP(0),
  CHANGED_BY INTEGER,
  CHANGED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP(0)
);
ALTER TABLE TB_CONTRACTS ADD PRIMARY KEY (ID);
ALTER TABLE TB_CONTRACTS ADD CONSTRAINT FK_CONT_STOR FOREIGN KEY (STORAGE_ID) REFERENCES TB_STORAGES (ID) ON DELETE CASCADE;
ALTER TABLE TB_CONTRACTS ADD CONSTRAINT FK_CONT_PROD FOREIGN KEY (PRODUCER_ID) REFERENCES TB_PRODUCERS (ID) ON DELETE CASCADE;
ALTER TABLE TB_CONTRACTS ADD CONSTRAINT FK_CONT_GRAN FOREIGN KEY (GRAIN_ID) REFERENCES TB_GRAINS (ID) ON DELETE CASCADE;
ALTER TABLE TB_CONTRACTS ADD CONSTRAINT FK_CONT_US_CREATED FOREIGN KEY (CREATED_BY) REFERENCES TB_USERS (ID) ON DELETE CASCADE;
ALTER TABLE TB_CONTRACTS ADD CONSTRAINT FK_CONT_US_CHANGED FOREIGN KEY (CHANGED_BY) REFERENCES TB_USERS (ID) ON DELETE CASCADE;
ALTER TABLE TB_CONTRACTS ADD CONSTRAINT FK_CONT_US_IN_WEIG FOREIGN KEY (INITIAL_WEIGHTED_BY) REFERENCES TB_USERS (ID) ON DELETE CASCADE;
ALTER TABLE TB_CONTRACTS ADD CONSTRAINT FK_CONT_US_FI_WEIG FOREIGN KEY (FINAL_WEIGHTED_BY) REFERENCES TB_USERS (ID) ON DELETE CASCADE;
ALTER TABLE TB_CONTRACTS ADD CONSTRAINT FK_CONT_US_MOISTUR FOREIGN KEY (MOISTURE_BY) REFERENCES TB_USERS (ID) ON DELETE CASCADE;
/* Definition for the `TB_CONTRACTS_ID_GEN` generator :  */
CREATE GENERATOR TB_CONTRACTS_ID_GEN;
/* Definition for the `BI_TB_CONTRACTS_ID` trigger :  */
SET TERM ^ ;
CREATE TRIGGER BI_TB_CONTRACTS_ID FOR TB_CONTRACTS ACTIVE BEFORE INSERT POSITION 0 AS
BEGIN
  IF (NEW.ID IS NULL) THEN
      NEW.ID = GEN_ID(TB_CONTRACTS_ID_GEN, 1);
END^
SET TERM ; ^



/* Privileges for the `TB_USERS` :  */
GRANT SELECT, INSERT, DELETE, REFERENCES, UPDATE ON TB_USERS TO SYSDBA WITH GRANT OPTION;
/* Privileges for the `TB_GRAINS` :  */
GRANT SELECT, INSERT, DELETE, REFERENCES, UPDATE ON TB_GRAINS TO SYSDBA WITH GRANT OPTION;
/* Privileges for the `TB_PRODUCERS` :  */
GRANT SELECT, INSERT, DELETE, REFERENCES, UPDATE ON TB_PRODUCERS TO SYSDBA WITH GRANT OPTION;
/* Privileges for the `TB_STORAGE` :  */
GRANT SELECT, INSERT, DELETE, REFERENCES, UPDATE ON TB_STORAGES TO SYSDBA WITH GRANT OPTION;
/* Privileges for the `TB_CONTRACTS` :  */
GRANT SELECT, INSERT, DELETE, REFERENCES, UPDATE ON TB_CONTRACTS TO SYSDBA WITH GRANT OPTION;