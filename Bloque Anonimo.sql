/*BLOQUE ANÓNIMO PARA TESTEAR FUNCIONES PROCEDIMIENTOS Y TRIGGERS

WARNING, ADVERTENCIA, OJO CUIDAO: Antes de ejecutar es necesario haber compilado todas las funciones, todos los procedimientos y todos los disparadores que se encuentran en otro documento SQL dentro de esta misma carpeta*/

SET SERVEROUTPUT ON;

/*Bloque anonimo para testear el funcionamiento de los requisitos 2 y 3*/
DECLARE
    V_ESCUDERIA VARCHAR2(20);
    V_PAISORIGEN VARCHAR2(20);
BEGIN
    DBMS_OUTPUT.PUT_LINE('INICIO DE LA APLICACIÓN');
    DBMS_OUTPUT.PUT_LINE('==========================');
    DBMS_OUTPUT.PUT_LINE('Se va a realizar una prueba de los requisitos 2 y 3:');
    DBMS_OUTPUT.PUT_LINE('Se pedira una nacionalidad y el programa deberia generar un listado con todos los pilotos nacidos en la misma');
    V_ESCUDERIA = 'Ferrari';
    V_PAISORIGEN = 'España';
END;
/
EXEC ListaPilotosSegunNacionalidad(V_PAISORIGEN);
EXEC ListaCochesSegunEscuderia(V_ESCUDERIA);


/*El siguiente bloque comprobara el funcionamiento de la tabla AUDITORIA*/
INSERT INTO PILOTO VALUES (NUMLICENCIA.NEXTVAL, 'Takuma Sato', 'Corea del Sur', TO_DATE('28/01/1977', 'DD/MM/YYYY');
UPDATE PILOTO SET PAISORIGEN = 'Japón' WHERE NOMBRE = 'Takuma Sato';
DELETE FROM PILOTO WHERE NOMBRE = 'Takuma Sato';
/*Ejecute el siguiente SELECT para comprobaciones de AUDITORIA
SELECT * FROM AUDITORIA;
*/

BEGIN
    DBMS_OUTPUT.PUT_LINE('==========================');
    DBMS_OUTPUT.PUT_LINE('Finalmente, se va a ejecutar las funciones de los requisitos 4 y 5');
    DBMS_OUTPUT.PUT_LINE('FIN DE LA APLICACIÓN');
END;   
/

/*Mostrar numero de participantes disponibles en una carrera*/
DECLARE
	V_CODIGOCARRERA NUMBER := 1;
    V_PARTDISPONIBLES NUMBER;
BEGIN
	V_PARTDISPONIBLES:=ParticipantesDispEnCarrera(V_CODIGOCARRERA);
    DBMS_OUTPUT.PUT_LINE(v_partdisponibles);
END;
/

/*Mostrar a que escuderia pertenece un modelo de coche*/
DECLARE
    ModeloCoche VARCHAR2(40) := 'W09';
    EscuderiaPedida VARCHAR2(20);
BEGIN
    EscuderiaPedida := buscarescuderiademodelo(ModeloCoche);
    DBMS_OUTPUT.PUT_LINE('El modelo ' || ModeloCoche || ' pertenece a ' || EscuderiaPedida);
END;
/