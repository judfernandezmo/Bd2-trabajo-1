CREATE OR REPLACE FUNCTION 	busqueda(r1_id IN red.id_red%TYPE,nodoi IN NUMBER,nodof IN NUMBER)
RETURN vARCHAR IS
CURSOR r1 IS  SELECT nodo1,costo,nodo2 
                  FROM red , (XMLTABLE('/grafo/enlace'  
                                     PASSING red.grafo_rutas
                                     COLUMNS  
                                        nodo1  varchar2(20)    PATH './nodo1',  
                                        costo  varchar2(20)    PATH './costo',  
                                        nodo2  varchar2(20)    PATH './nodo2'
                                 ) xmlt)
                  WHERE id_red=r1_id ;
BEGIN
 DBMS_OUTPUT.PUT_LINE('enlace no directo');     

END;
/