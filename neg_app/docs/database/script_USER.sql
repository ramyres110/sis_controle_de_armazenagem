/* SQL Manager Lite for InterBase and Firebird 5.5.4.52620                                            */
/* -------------------------------------------------------------------------------------------------- */
/* Author: Ramyres Aquino - @ramyres110 */
/* Dt: 22/05/2020 */
/* Changed by Ramyres at 23/05/2020 */

CONNECT '..\..\data\DATABASE.fdb' USER 'sysdba' PASSWORD 'masterkey';

INSERT INTO TB_USERS(USERNAME,"PASSWORD") VALUES ('admin','21232F297A57A5A743894A0E4A801FC3');

COMMIT;

EXIT;
