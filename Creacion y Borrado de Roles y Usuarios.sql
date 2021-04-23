CREATE USER C##JEFE IDENTIFIED BY 1234;
CREATE USER C##PILOTO IDENTIFIED BY 1234;
CREATE USER C##MECANICO IDENTIFIED BY 1234;
CREATE USER C##ORGANIZADOR IDENTIFIED BY 1234;

CREATE ROLE C##ROLJEFE;
GRANT SELECT, INSERT, UPDATE, DELETE ON JEFEESCUDERIA TO C##ROLJEFE;
GRANT SELECT, INSERT, UPDATE, DELETE ON ESCUDERIA TO C##ROLJEFE;
GRANT SELECT, INSERT, UPDATE, DELETE ON COCHE TO C##ROLJEFE;
GRANT SELECT ON CARRERA TO C##ROLJEFE;
GRANT CREATE SESSION TO C##ROLJEFE;
GRANT C##ROLJEFE TO C##JEFE;
REVOKE C##ROLJEFE FROM C##JEFE;

CREATE ROLE C##ROLPILOTO;
GRANT SELECT, INSERT, UPDATE, DELETE ON PILOTO TO C##ROLPILOTO;
GRANT SELECT ON CARRERA TO C##ROLPILOTO;
GRANT CREATE SESSION TO C##ROLPILOTO;
GRANT C##ROLPILOTO TO C##PILOTO;
REVOKE C##ROLPILOTO FROM C##PILOTO;

CREATE ROLE C##ROLMECANICO;
GRANT SELECT, INSERT, UPDATE, DELETE ON COCHE TO C##ROLMECANICO;
GRANT CREATE SESSION TO C##ROLMECANICO;
GRANT C##ROLMECANICO TO C##MECANICO;
REVOKE C##ROLMECANICO FROM C##MECANICO;

CREATE ROLE C##ROLORGANIZADOR;
GRANT SELECT, INSERT, UPDATE, DELETE ON PARTICIPANTE TO C##ROLORGANIZADOR;
GRANT SELECT, INSERT, UPDATE, DELETE ON CARRERA TO C##ROLORGANIZADOR;
GRANT SELECT ON JEFEESCUDERIA TO C##ROLORGANIZADOR;
GRANT SELECT ON ESCUDERIA TO C##ROLORGANIZADOR;
GRANT SELECT ON COCHE TO C##ROLORGANIZADOR;
GRANT SELECT ON PILOTO TO C##ROLORGANIZADOR;
GRANT CREATE SESSION TO C##ROLORGANIZADOR;
GRANT C##ROLORGANIZADOR TO C##ORGANIZADOR;
REVOKE C##ROLORGANIZADOR TO C##ORGANIZADOR;

DROP USER C##JEFE CASCADE;
DROP USER C##PILOTO CASCADE;
DROP USER C##MECANICO CASCADE;
DROP USER C##ORGANIZADOR CASCADE;