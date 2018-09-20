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
CREATE OR REPLACE TRIGGER check_insert_ganancia 
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
CREATE OR REPLACE TRIGGER check_update_ganancia 
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

--Procedimiento que recibe lista de niveles
--y obtiene la suma de las ganancias de dichos niveles
CREAT OR REPLACE PROCEDURE suma_niveles @codes VARCHAR(MAX)
IS 
	arreglo tipo_array;
	i NUMBER;
BEGIN
	DBMS_OUTPUT.PUT_LINE(arreglo.COUNT);
	i:= arreglo.FIRST;
	WHILE i IS NOT NULL LOOP
		DBMS_OUTPUT.PUT_LINE('Pos:  ' || i || '  Val:  ' || arreglo(i));
		i := arreglo.NEXT(i);
	END LOOP;
END;