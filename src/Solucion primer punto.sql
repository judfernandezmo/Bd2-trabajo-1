--SOLUCION PRIMER PUNTO:

----------------------------------------------------------------------------------------------------------------------------------------------------
--Solucion numeral A primer punto

-- Funcion que recibe el sucpadre del elemento y
-- devuelve la suma de las ganancias de las sucursales padre.
CREATE OR REPLACE FUNCTION 
	fn_ganancia_padre(sucpadre_f IN NUMBER)
	RETURN NUMBER 
	AS 
		ganancia_f NUMBER;
		gananciai sucursal.ganancia%TYPE;
		acomulador NUMBER;

		CURSOR cur IS
		SELECT ganancia 
		FROM sucursal
		START WITH codsuc = sucpadre_f
		CONNECT BY PRIOR sucpadre = codsuc;
	
		BEGIN 
		acomulador := 0;
		OPEN cur;
		LOOP
			FETCH cur INTO gananciai;
			EXIT WHEN cur%NOTFOUND;
			acomulador := acomulador + gananciai; 
			DBMS_OUTPUT.PUT_LINE('gananciai=  ' || gananciai);
			DBMS_OUTPUT.PUT_LINE('acomulador=  ' || acomulador);
		END LOOP;
		CLOSE cur;
	RETURN acomulador;
END fn_ganancia_padre; 

--Trigger que verifica insercion de ganancia
CREATE OR REPLACE TRIGGER ver_insert_ganancia 
BEFORE INSERT ON sucursal
FOR EACH ROW
DECLARE
	ganancia_p sucursal.ganancia%TYPE;
BEGIN
	ganancia_p := fn_ganancia_padre(:NEW.sucpadre);
	IF ganancia_p < :NEW.ganancia THEN
		RAISE_APPLICATION_ERROR(-20505, '¡Ganancia insertada mayor a suma de ganancia de los padres!');
	END IF;
END;

--Trigger que verifica la actualizacion de ganancia
CREATE OR REPLACE TRIGGER ver_update_ganancia 
BEFORE UPDATE OF ganancia ON sucursal 
FOR EACH ROW
DECLARE
	PRAGMA AUTONOMOUS_TRANSACTION;
	ganancia_p sucursal.ganancia%TYPE;
BEGIN
	DBMS_OUTPUT.PUT_LINE('valor codsuc= '||:NEW.codsuc);
	DBMS_OUTPUT.PUT_LINE('valor ganancia= '||:NEW.ganancia);
	DBMS_OUTPUT.PUT_LINE('valor sucpadre= '||:NEW.sucpadre);

	ganancia_p := fn_ganancia_padre(:NEW.sucpadre);
	DBMS_OUTPUT.PUT_LINE('ganancia ingresada=  '||:NEW.ganancia);

	IF ganancia_p < :NEW.ganancia THEN
		RAISE_APPLICATION_ERROR(-20505, '¡Ganancia insertada mayor a suma de ganancia de los padres!');
	END IF;
END;


----------------------------------------------------------------------------------------------------------------------------------------------------
--Solucion numeral B primer punto

--Definimos el tipo arreglo globalmente:
CREATE OR REPLACE TYPE aux_array AS TABLE OF NUMBER;
--Definimos variables globales:
CREATE OR REPLACE PACKAGE general 
IS
	arreglo_nivel aux_array;
	iterador NUMBER;
END;

--Funcion que verifica los niveles:
CREATE OR REPLACE FUNCTION (nivel IN NUMBER)
RETURN aux_array
AS 
	level_i sucursal.level%TYPE;
	codsuc_i sucursal.codsuc%TYPE;
	ganancia_i sucursal.ganancia%TYPE;

	CURSOR cur IS
		SELECT codsuc, ganancia, level
		FROM sucursal
		START WITH codsuc = 1
		CONNECT BY PRIOR codsuc = sucpadre;
BEGIN 
	OPEN cur;
		LOOP
			FETCH cur.codsuc, cur.ganancia, cur.level
			 INTO codsuc_i, ganancia_i, level_i;
			EXIT WHEN cur%NOTFOUND;
			arreglo_nivel 
			DBMS_OUTPUT.PUT_LINE('gananciai=  ' || gananciai);
			DBMS_OUTPUT.PUT_LINE('acomulador=  ' || acomulador);
		END LOOP;
	CLOSE cur;
	RETURN
END;

--Procedimiento que recibe lista de niveles
--y obtiene la suma de las ganancias de dichos niveles
CREATE OR REPLACE PROCEDURE suma_niveles (arreglo IN aux_array)
AS 
BEGIN
	DBMS_OUTPUT.PUT_LINE('Cantidad de elementos:  ' || arreglo.COUNT);
	FOR i IN arreglo.FIRST .. arreglo.LAST
	LOOP
		DBMS_OUTPUT.PUT_LINE('Pos:  ' || i || '  Val:  ' || arreglo(i));

	END LOOP;
END;

--Prueba del proceso
DECLARE     
valores aux_array := aux_array ((2), (3), (5), (1), (7));   
BEGIN     
suma_niveles(valores);   
END;


----------------------------------------------------------------------------------------------------------------------------------------------------
--Solucion numeral c primer punto

--Proceso de actualización nivel
CREATE OR REPLACE PROCEDURE update_nivel (o_sucpadre IN sucursal.sucpadre%TYPE, 
	sucpadre_b IN sucursal.sucpadre%TYPE)
AS 
BEGIN
	DBMS_OUTPUT.PUT_LINE('Updated:  ' || sucpadre_b);
	DBMS_OUTPUT.PUT_LINE('Updated sucpadre sin b pero con o :v:  ' || o_sucpadre);
	UPDATE sucursal SET sucpadre = o_sucpadre
    WHERE codsuc = sucpadre_b; 
    DBMS_OUTPUT.PUT_LINE('C marnat');
END;

--Trigger para verificar borrado
CREATE OR REPLACE TRIGGER ver_borrado
BEFORE DELETE ON sucursal
FOR EACH ROW
DECLARE
    PRAGMA AUTONOMOUS_TRANSACTION;
    sucpadre_g sucursal.sucpadre%TYPE;
    sucpadre_b sucursal.sucpadre%TYPE;
    CURSOR curso IS
		SELECT codsuc
		FROM sucursal
		WHERE sucpadre = :OLD.codsuc;
BEGIN
    sucpadre_g := :OLD.sucpadre;
    DBMS_OUTPUT.PUT_LINE('codsuc ingresado= '|| :OLD.codsuc);
    IF (sucpadre_g IS NOT NULL) THEN
        DBMS_OUTPUT.PUT_LINE('codsuc ingresado= '|| :OLD.codsuc);
        DBMS_OUTPUT.PUT_LINE('sucpadre ingresado= '|| :OLD.sucpadre);
        OPEN curso;
        LOOP
			FETCH curso INTO sucpadre_b;
			EXIT WHEN curso%NOTFOUND;
			DBMS_OUTPUT.PUT_LINE('sucpadre_b= '|| sucpadre_b);
			update_nivel(sucpadre_g,sucpadre_b);
		END LOOP;
		CLOSE curso; 
    ELSE 
        RAISE_APPLICATION_ERROR(-20505, '¡No se puede borrar el elemento base!');
    END IF;	
END;