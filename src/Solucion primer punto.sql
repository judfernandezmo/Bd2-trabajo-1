--Solucion numeral a primer punto

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

--prueba funcion fn_ganancia_padre
DECLARE
	valor NUMBER;
BEGIN
	valor := fn_ganancia_padre('2');
	DBMS_OUTPUT.put_line ('valor de la funcion=   ' || valor);
END;

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