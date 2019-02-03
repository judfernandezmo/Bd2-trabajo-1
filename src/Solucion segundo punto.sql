--SOLUCION SEGUNDO PUNTO:

----------------------------------------------------------------------------------------------------------------------------------------------------
--Solucion numeral A segundo punto

--Esquema XML (Adicionalmente esta el archivo modeloXML.xml)
<?xml version="1.0" encoding="UTF-8" ?>
<grafo>
  <enlace NO = "1">
    <nodo1> </nodo1>
    <costo> </costo>        
    <nodo2> </nodo2>
  </enlace>
  <enlace NO = "2">
    <nodo1> </nodo1>
    <costo> </costo>        
    <nodo2> </nodo2>
  </enlace>
  ...
  <enlace NO = "n">
   <nodo1> </nodo1>
    <costo> </costo>        
    <nodo2> </nodo2>
  </enlace>
</grafo>


----------------------------------------------------------------------------------------------------------------------------------------------------
--Solucion numeral B segundo punto

--Proceso que recibe el codigo de dos redes e indica cuantas y cuales
--codigos de ciudad tienen en comun los dos grafos de rutas ingresados
  CREATE OR REPLACE PROCEDURE ciudades_comunes
  (r1_id IN red.id_red%TYPE,r2_id IN red.id_red%TYPE)
  IS 
  CURSOR r1 IS  SELECT nodo1,costo,nodo2 
                  FROM red , (XMLTABLE('/grafo/enlace'  
                                     PASSING red.grafo_rutas
                                     COLUMNS  
                                        nodo1  varchar2(20)    PATH './nodo1',  
                                        costo  varchar2(20)    PATH './costo',  
                                        nodo2  varchar2(20)    PATH './nodo2'
                                 ) xmlt)
                  WHERE id_red=r1_id ;
  CURSOR r2 IS  SELECT nodo1,costo,nodo2 
                  FROM red , (XMLTABLE('/grafo/enlace'  
                                     PASSING red.grafo_rutas
                                     COLUMNS  
                                        nodo1  varchar2(20)    PATH './nodo1',  
                                        costo  varchar2(20)    PATH './costo',  
                                        nodo2  varchar2(20)    PATH './nodo2'
                                 ) xmlt)
                  WHERE id_red=r2_id ;

   TYPE t_num IS TABLE OF NUMBER(10) INDEX BY BINARY_INTEGER;
   mis_num t_num;
   mis_num1 t_num;
   mis_num2 t_num;
   i NUMBER:=1;
   j NUMBER:=1;
   k NUMBER:=1;
   numi NUMBER(10);
   cont NUMBER;
  BEGIN  
        
        FOR r1_i IN r1 LOOP
          FOR r2_i IN r2 LOOP

            IF r1_i.nodo1 =r2_i.nodo1 THEN 
                         
                    mis_num(i):=r1_i.nodo1;  
                    i:=i+1;     
                  
            END IF;
           
          END LOOP; 
        END LOOP; 

        FOR i IN 1..mis_num.COUNT LOOP
          cont:=0;
          numi:=mis_num(i);
          mis_num1(j):=numi;
          j:=j+1;
          FOR K IN 1..mis_num1.COUNT LOOP
            IF (mis_num1(K)=numi) THEN
                cont:=cont+1;
            END IF;
          END LOOP;
          IF cont=1 THEN
            mis_num2(k):=numi;
            k:=k+1;
          END IF;
        END LOOP;



       
        DBMS_OUTPUT.PUT_LINE(  'Ciudades Comunes: ' || mis_num2.COUNT);
        FOR i IN 1..mis_num.COUNT LOOP
          DBMS_OUTPUT.PUT_LINE(  'codigo de ciudad ' || mis_num2(i));
        END LOOP;
   
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('');
  END;
   /


----------------------------------------------------------------------------------------------------------------------------------------------------
--Solucion numeral C segundo punto

--creacion de tabla auxiliar para ordenar las rutas entre ciudades
 CREATE TABLE rutasfinales(costo NUMBER(20),ruta VARCHAR(100) PRIMARY KEY) ;
 --creacion de tabla auxiliar para controlar las ciudades repetidas en las rutas
 CREATE TABLE nodos_de_ruta(nodo NUMBER (4) PRIMARY KEY NOT NULL ,indexx NUMBER (4) NOT NULL UNIQUE );


-- procedimiento para imprimir los resultados
 CREATE OR REPLACE PROCEDURE imprimir 
  IS 
    CURSOR rutas IS select * from rutasfinales order by costo DESC;
    validacion NUMBER;
  BEGIN      
      SELECT COUNT(*) INTO validacion FROM rutasfinales;
      IF validacion = 0 THEN
         DBMS_OUTPUT.PUT_LINE('No hay rutas entre las dos ciudades');
      ELSE
         FOR r1_i IN rutas LOOP
           DBMS_OUTPUT.PUT_LINE(r1_i.ruta|| ' Total '||r1_i.costo);
         END LOOP; 
      END IF;        

  END;
  /

--procedimiento que itera sobre la red en la busqueda de las rutas posibles entre dos ciudades

 CREATE OR REPLACE PROCEDURE rutas
    (red_id IN red.id_red%TYPE,nodoi IN NUMBER,nodof IN NUMBER,ruta IN VARCHAR,costot IN NUMBER, i IN NUMBER)
   IS
   CURSOR red IS  SELECT nodo1,costo,nodo2 
                    FROM red , (XMLTABLE('/grafo/enlace'  
                                       PASSING red.grafo_rutas
                                       COLUMNS  
                                          nodo1  varchar2(20)    PATH './nodo1',  
                                          costo  varchar2(20)    PATH './costo',  
                                          nodo2  varchar2(20)    PATH './nodo2'
                                   ) xmlt)
                    WHERE id_red=red_id;
    rutar  VARCHAR(20) := INITCAP('');                
    costor NUMBER;
    j NUMBER;
    val NUMBER;
    
   BEGIN

    FOR red_i IN red LOOP
    SELECT COUNT(*) INTO val FROM nodos_de_ruta WHERE nodo=red_i.nodo2 or nodo=red_i.nodo1 ;
      IF red_i.nodo1 = nodoi  and red_i.nodo2 = nodof THEN
        INSERT INTO nodos_de_ruta VALUES(red_i.nodo1,i);
        j:=i+1;
        INSERT INTO nodos_de_ruta VALUES(red_i.nodo2,j);

        rutar:= ruta||nodoi ||'-' || nodof;
        costor:=costot+red_i.costo;
        INSERT INTO rutasfinales VALUES(costor,rutar);
        delete from nodos_de_ruta;
        Exit;


      ELSIF red_i.nodo1 = nodoi THEN
        IF val = 0 THEN 
          INSERT INTO nodos_de_ruta VALUES(red_i.nodo1,i);
          costor:=costot+red_i.costo;
          j:=i+1;
          rutar:=ruta || nodoi ||'-';
          rutas(red_id,red_i.nodo2,nodof,rutar,costor,j);
        ELSE    
          delete from nodos_de_ruta;
          CONTINUE;
        END IF;

      END IF;


    END LOOP;
        
   END;
   /

-- prodecimiento que recibe los datos iniciales  y llama los demas procedimientos para su implementacion

CREATE OR REPLACE PROCEDURE pre_busqueda
  (red_id IN red.id_red%TYPE,nodoi IN NUMBER,nodof IN NUMBER)
  IS 
    CURSOR red_v1 IS  SELECT nodo1,costo,nodo2 
                  FROM red , (XMLTABLE('/grafo/enlace'  
                                     PASSING red.grafo_rutas
                                     COLUMNS  
                                        nodo1  varchar2(20)    PATH './nodo1',  
                                        costo  varchar2(20)    PATH './costo',  
                                        nodo2  varchar2(20)    PATH './nodo2'
                                 ) xmlt)
                  WHERE id_red=red_id and nodo1=nodoi;

    CURSOR red_v2 IS  SELECT nodo1,costo,nodo2 
                  FROM red , (XMLTABLE('/grafo/enlace'  
                                     PASSING red.grafo_rutas
                                     COLUMNS  
                                        nodo1  varchar2(20)    PATH './nodo1',  
                                        costo  varchar2(20)    PATH './costo',  
                                        nodo2  varchar2(20)    PATH './nodo2'
                                 ) xmlt)
                  WHERE id_red=red_id and nodo2=nodof;

    red_v1i red_v1%ROWTYPE;
    red_v2i red_v2%ROWTYPE;
  BEGIN
     IF(nodoi=nodof) THEN
       DBMS_OUTPUT.PUT_LINE('Las ciudades deben ser distintas');
     ELSE
      delete from rutasfinales;
      delete from nodos_de_ruta;  

        OPEN red_v1;
        FETCH red_v1 INTO red_v1i;
        
        IF(red_v1%FOUND)THEN

          OPEN red_v2;
            FETCH red_v2 INTO red_v2i;
        
            IF(red_v2%FOUND)THEN  

              rutas(red_id,nodoi,nodof,'',0,1);
              imprimir();  
             
            ELSE
              DBMS_OUTPUT.PUT_LINE('No hay rutas entre las dos ciudades');
            END IF;
          CLOSE red_v2;
          
        ELSE
          DBMS_OUTPUT.PUT_LINE('No hay rutas entre las dos ciudades');
        END IF;
       CLOSE red_v1;
     END IF;  
  END;
  /