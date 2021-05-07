/*Requisito 1: controlar las acciones que se realicen en la tabla PILOTO en una tabla auditoria*/
CREATE TABLE AUDITORIA(
    DESCRIPCION VARCHAR2(500)
);

CREATE OR REPLACE TRIGGER AUDITORIAPILOTO
    AFTER INSERT OR UPDATE OR DELETE ON PILOTO
    FOR EACH ROW
BEGIN
    IF INSERTING THEN
    INSERT INTO AUDITORIA VALUES('<'||USER||'> - <'||CURRENT_TIMESTAMP||'> - <INSERT> - <'||
    'NUMLICENCIA: '||:NEW.NUMLICENCIA||' | '||'PILOTO: '||:NEW.NOMBRE||' | '||
    'PAIS ORIGEN: '||:NEW.PAISORIGEN||' | '||'FECHA NACIMIENTO: '||TO_DATE(:NEW.FECHANAC, 'DD/MM/YYYY'));
    ELSIF UPDATING THEN
    INSERT INTO AUDITORIA VALUES('<'||USER||'> - <'||CURRENT_TIMESTAMP||'> - <UPDATE> - <'||
    'NUMLICENCIA: '||:OLD.NUMLICENCIA||' | '||'PILOTO: '||:OLD.NOMBRE||' | '||
    'PAIS ORIGEN: '||:OLD.PAISORIGEN||' | '||'FECHA NACIMIENTO: '||TO_DATE(:OLD.FECHANAC, 'DD/MM/YYYY'));
    ELSIF DELETING THEN
    INSERT INTO AUDITORIA VALUES('<'||USER||'> - <'||CURRENT_TIMESTAMP||'> - <DELETE> - <'||
    'NUMLICENCIA: '||:OLD.NUMLICENCIA||' | '||'PILOTO: '||:OLD.NOMBRE||' | '||
    'PAIS ORIGEN: '||:OLD.PAISORIGEN||' | '||'FECHA NACIMIENTO: '||TO_DATE(:OLD.FECHANAC, 'DD/MM/YYYY'));
    END IF;
END;
/

/*Requisito 2: generar un listado de pilotos dada una nacionalidad*/
create or replace PROCEDURE ListaPilotosSegunNacionalidad(PaisOrigen in Piloto.PaisOrigen%TYPE)
IS
    
    CURSOR C IS
        SELECT P.Nombre, P.NumLicencia, P.FechaNac FROM Piloto P WHERE P.PaisOrigen = PaisOrigen;
        W_NOMBRE VARCHAR2(30);
        W_NUMLICENCIA NUMBER(8);
        W_FECHANAC DATE;
BEGIN
    OPEN C;
    LOOP
     FETCH C INTO W_NOMBRE, W_NUMLICENCIA, W_FECHANAC;
     EXIT WHEN C%NOTFOUND;
     DBMS_OUTPUT.PUT_LINE('NOMBRE: '|| W_NOMBRE ||' NUMERO DE LICENCIA: '|| W_NUMLICENCIA || ' FECHA DE NACIMIENTO: ' || W_FECHANAC);
    END LOOP;
    CLOSE C;
END;
/

/*Requisito 3: generar un listado de coches dada una escuderia*/
create or replace PROCEDURE ListaCochesSegunEscuderia(Escuderia in Coche.Escuderia%TYPE)
IS
    
    CURSOR C IS
        SELECT Co.Modelo, Co.Categoria, Co.Peso, Co.Potencia FROM Coche Co WHERE Co.Escuderia = Escuderia;
        W_MODELO VARCHAR2(40);
        W_CATEGORIA CHAR(3);
        W_PESO NUMBER(4);
        W_POTENCIA NUMBER(3);
BEGIN
    OPEN C;
    LOOP
     FETCH C INTO W_MODELO, W_CATEGORIA, W_PESO, W_POTENCIA;
     EXIT WHEN C%NOTFOUND;
     DBMS_OUTPUT.PUT_LINE('MODELO: '|| W_MODELO ||' CATEGORIA: '|| W_CATEGORIA || ' PESO: ' || W_PESO || 'KG POTENCIA: ' || W_POTENCIA || 'CV');
    END LOOP;
    CLOSE C;
END;
/

/*Requisito 4: comprobar cuantos participantes disponibles quedan en una carrera*/
create or replace FUNCTION ParticipantesDispEnCarrera(Codigo_Carrera NUMBER)
RETURN NUMBER
IS ParticipantesInscritos Carrera.Max_Participantes%TYPE;
Maximo_Participantes Carrera.Max_Participantes%TYPE;
Max_Participantes NUMBER;
PartInscritos NUMBER;
BEGIN
    SELECT C.Max_Participantes INTO Maximo_Participantes FROM Carrera C WHERE C.Codigo_Carrera = Codigo_Carrera;
    Max_Participantes := Maximo_Participantes;
    SELECT COUNT(*) INTO ParticipantesInscritos FROM Participante P WHERE P.Codigo_Carrera = Codigo_Carrera;
    PartInscritos := ParticipantesInscritos;
    RETURN Max_Participantes - PartInscritos;
END ParticipantesDispEnCarrera;
/

/*Requisito 5: buscar a que escuderia pertenece un determinado modelo de coche*/
create or replace FUNCTION BuscarEscuderiaDeModelo (ModeloCoche VARCHAR2)
RETURN VARCHAR2 IS
    EscuderiaPedida coche.escuderia%TYPE;
BEGIN
    SELECT Escuderia INTO EscuderiaPedida FROM Coche WHERE Modelo=ModeloCoche;
    RETURN EscuderiaPedida;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20002, 'El modelo en cuestion no esta registrado');
        RETURN '';
END BuscarEscuderiaDeModelo;
/

/*Requisito 6: no esta permitido introducir datos en ninguna tabla entre las 3:00 y las 4:59 horas. Supongamos que es una medida preventiva
para poder realizar una copia de seguridad diaria con mayor eficiencia*/
CREATE OR REPLACE TRIGGER LIMITACIONHORASCARRERA
    BEFORE INSERT ON CARRERA
    BEGIN
        IF (TO_CHAR(SYSDATE,'HH24') IN ('3','4')) THEN
            RAISE_APPLICATION_ERROR (-20003,'No se puede añadir datos a la base de datos entre las 3:00 y las 4:59');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER LIMITACIONHORASCOCHE
    BEFORE INSERT ON COCHE
    BEGIN
        IF (TO_CHAR(SYSDATE,'HH24') IN ('3','4')) THEN
            RAISE_APPLICATION_ERROR (-20003,'No se puede añadir datos a la base de datos entre las 3:00 y las 4:59');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER LIMITACIONHORASESCUDERIA
    BEFORE INSERT ON ESCUDERIA
    BEGIN
        IF (TO_CHAR(SYSDATE,'HH24') IN ('3','4')) THEN
            RAISE_APPLICATION_ERROR (-20003,'No se puede añadir datos a la base de datos entre las 3:00 y las 4:59');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER LIMITACIONHORASJEFEESCUDERIA
    BEFORE INSERT ON JEFEESCUDERIA
    BEGIN
        IF (TO_CHAR(SYSDATE,'HH24') IN ('3','4')) THEN
            RAISE_APPLICATION_ERROR (-20003,'No se puede añadir datos a la base de datos entre las 3:00 y las 4:59');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER LIMITACIONHORASPARTICIPANTE
    BEFORE INSERT ON PARTICIPANTE
    BEGIN
        IF (TO_CHAR(SYSDATE,'HH24') IN ('3','4')) THEN
            RAISE_APPLICATION_ERROR (-20003,'No se puede añadir datos a la base de datos entre las 3:00 y las 4:59');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER LIMITACIONHORASPILOTO
    BEFORE INSERT ON PILOTO
    BEGIN
        IF (TO_CHAR(SYSDATE,'HH24') IN ('3','4')) THEN
            RAISE_APPLICATION_ERROR (-20003,'No se puede añadir datos a la base de datos entre las 3:00 y las 4:59');
    END IF;
END;
/
