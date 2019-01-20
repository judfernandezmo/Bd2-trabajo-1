 
 CREATE TABLE rutasfinales(costo NUMBER(4),ruta VARCHAR(100) PRIMARY KEY) ;

 CREATE OR REPLACE PROCEDURE pre_rutas
  (r1_id IN red.id_red%TYPE,nodoi IN NUMBER,nodof IN NUMBER)
  IS 
  BEGIN
     IF(nodoi=nodof) THEN
       DBMS_OUTPUT.PUT_LINE('no hay rutas');
     ELSE
      delete from rutasfinales;
      rutas_posibles(r1_id,nodoi,nodof,0,' '); 
      imprimir();   

     END IF;  
  END;
  /

  CREATE OR REPLACE PROCEDURE imprimir 
  IS 
    CURSOR rutas IS select * from rutasfinales order by costo DESC;
  BEGIN              
        DBMS_OUTPUT.PUT_LINE(rutas%NO_DATA_FOUND)
        FOR r1_i IN rutas LOOP
         DBMS_OUTPUT.PUT_LINE(r1_i.ruta|| ' Total '||r1_i.costo);
        END LOOP;     

  END;
  /

  || ' total '|| r1_i.costo

 CREATE OR REPLACE PROCEDURE rutas_posibles
  (r1_id IN red.id_red%TYPE,nodoi IN NUMBER,nodof IN NUMBER,costot IN NUMBER,ruta IN VARCHAR)
  IS 
  costor NUMBER:=0;
  rutar  VARCHAR(20) := INITCAP('');
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
       FOR r1_i IN r1 LOOP
          IF r1_i.nodo1 = nodoi  and r1_i.nodo2 = nodof THEN 
             
             rutar:= ruta||nodoi ||'-' || nodof;
             costor:=costot+r1_i.costo;
             INSERT INTO rutasfinales VALUES(costor,rutar);
             
              
          ELSIF r1_i.nodo1 = nodoi THEN
            
            rutar:=ruta || nodoi ||'-';
            costor:=costot+r1_i.costo;
            rutas_posibles(r1_id,r1_i.nodo2,nodof,costor,rutar);                  

          END IF;

         
       END LOOP; 


  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('FINISH PROCEDURE');
  END;
  /
