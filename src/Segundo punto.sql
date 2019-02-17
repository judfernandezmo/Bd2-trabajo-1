--Creacion de la tabla red
CREATE TABLE red(
id_red NUMBER(8) PRIMARY KEY,
nombre_red VARCHAR2(40) NOT NULL,
grafo_rutas XMLTYPE
); 



--Insercion de datos en la tabla red
INSERT INTO red VALUES(330,'ejemplo_documento_insercion', XMLTYPE('
<grafo>
    <enlace NO = "1">
        <nodo1>1</nodo1>
        <costo>100</costo>        
        <nodo2>2</nodo2>
    </enlace>
    <enlace NO = "2">
        <nodo1>1</nodo1>
        <costo>50</costo>        
        <nodo2>3</nodo2>
    </enlace>
     <enlace NO = "3">
        <nodo1>1</nodo1>
        <costo>90</costo>        
        <nodo2>4</nodo2>
    </enlace>
    <enlace NO = "4">
        <nodo1>2</nodo1>
        <costo>20</costo>        
        <nodo2>4</nodo2>
    </enlace>
    <enlace NO = "5">
        <nodo1>3</nodo1>
        <costo>30</costo>        
        <nodo2>4</nodo2>
    </enlace>
     <enlace NO = "6">
        <nodo1>4</nodo1>
        <costo>90</costo>        
        <nodo2>5</nodo2>
    </enlace>
    <enlace NO = "7">
        <nodo1>5</nodo1>
        <costo>10000</costo>        
        <nodo2>1</nodo2>
    </enlace>
</grafo>'));

---casos de prueba


INSERT INTO red VALUES(330,'CasoBase', XMLTYPE('
<grafo>
    <enlace NO = "1">
        <nodo1>1</nodo1>
        <costo>100</costo>        
        <nodo2>2</nodo2>
    </enlace>
    <enlace NO = "2">
        <nodo1>1</nodo1>
        <costo>50</costo>        
        <nodo2>3</nodo2>
    </enlace>
     <enlace NO = "3">
        <nodo1>1</nodo1>
        <costo>90</costo>        
        <nodo2>4</nodo2>
    </enlace>
    <enlace NO = "4">
        <nodo1>2</nodo1>
        <costo>20</costo>        
        <nodo2>4</nodo2>
    </enlace>
    <enlace NO = "5">
        <nodo1>3</nodo1>
        <costo>30</costo>        
        <nodo2>4</nodo2>
    </enlace>
     <enlace NO = "6">
        <nodo1>4</nodo1>
        <costo>90</costo>        
        <nodo2>5</nodo2>
    </enlace>
    <enlace NO = "7">
        <nodo1>5</nodo1>
        <costo>10000</costo>        
        <nodo2>1</nodo2>
    </enlace>
</grafo>'));

INSERT INTO red VALUES(220,'CasoCorreoMod', XMLTYPE('
<grafo>
    <enlace NO = "1">
        <nodo1>1</nodo1>
        <costo>12</costo>        
        <nodo2>2</nodo2>
    </enlace>
    <enlace NO = "2">
        <nodo1>2</nodo1>
        <costo>1</costo>        
        <nodo2>3</nodo2>
    </enlace>
     <enlace NO = "3">
        <nodo1>3</nodo1>
        <costo>3</costo>        
        <nodo2>2</nodo2>
    </enlace> 
    <enlace NO = "6">
        <nodo1>3</nodo1>
        <costo>1</costo>        
        <nodo2>1</nodo2>
    </enlace>
    <enlace NO = "4">
        <nodo1>3</nodo1>
        <costo>3</costo>        
        <nodo2>4</nodo2>
    </enlace>   
     <enlace NO = "5">
        <nodo1>4</nodo1>
        <costo>90</costo>        
        <nodo2>2</nodo2>
    </enlace>
</grafo>'));

INSERT INTO red VALUES(1,'CasoPacho1', XMLTYPE('
<grafo>
    <enlace NO = "1">
        <nodo1>1</nodo1>
        <costo>10</costo>        
        <nodo2>2</nodo2>
    </enlace>
    <enlace NO = "2">
        <nodo1>1</nodo1>
        <costo>10</costo>        
        <nodo2>4</nodo2>
    </enlace>
     <enlace NO = "3">
        <nodo1>2</nodo1>
        <costo>10</costo>        
        <nodo2>3</nodo2>
    </enlace> 
    <enlace NO = "6">
        <nodo1>3</nodo1>
        <costo>10</costo>        
        <nodo2>2</nodo2>
    </enlace>
    <enlace NO = "4">
        <nodo1>3</nodo1>
        <costo>10</costo>        
        <nodo2>4</nodo2>
    </enlace>   
     <enlace NO = "5">
        <nodo1>4</nodo1>
        <costo>10</costo>        
        <nodo2>1</nodo2>
    </enlace>
</grafo>'));

INSERT INTO red VALUES(2,'CasoPacho2', XMLTYPE('
<grafo>
    <enlace NO = "1">
        <nodo1>1</nodo1>
        <costo>10</costo>        
        <nodo2>2</nodo2>
    </enlace>
    <enlace NO = "2">
        <nodo1>2</nodo1>
        <costo>10</costo>        
        <nodo2>3</nodo2>
    </enlace>
     <enlace NO = "3">
        <nodo1>3</nodo1>
        <costo>10</costo>        
        <nodo2>2</nodo2>
    </enlace> 
    <enlace NO = "4">
        <nodo1>3</nodo1>
        <costo>10</costo>        
        <nodo2>4</nodo2>
    </enlace>
    <enlace NO = "5">
        <nodo1>4</nodo1>
        <costo>10</costo>        
        <nodo2>3</nodo2>
    </enlace>   
     <enlace NO = "6">
        <nodo1>4</nodo1>
        <costo>10</costo>        
        <nodo2>5</nodo2>
    </enlace>
    <enlace NO = "7">
        <nodo1>5</nodo1>
        <costo>10</costo>        
        <nodo2>4</nodo2>
    </enlace>
    <enlace NO = "8">
        <nodo1>5</nodo1>
        <costo>10</costo>        
        <nodo2>2</nodo2>
    </enlace>
    <enlace NO = "9">
        <nodo1>5</nodo1>
        <costo>10</costo>        
        <nodo2>6</nodo2>
    </enlace>
    <enlace NO = "10">
        <nodo1>6</nodo1>
        <costo>10</costo>        
        <nodo2>1</nodo2>
    </enlace>
    <enlace NO = "11">
        <nodo1>6</nodo1>
        <costo>10</costo>        
        <nodo2>7</nodo2>
    </enlace>

</grafo>'));

INSERT INTO red VALUES(3,'CasoPacho3', XMLTYPE('
<grafo>
    <enlace NO = "1">
        <nodo1>1</nodo1>
        <costo>10</costo>        
        <nodo2>2</nodo2>
    </enlace>
    <enlace NO = "2">
        <nodo1>2</nodo1>
        <costo>10</costo>        
        <nodo2>3</nodo2>
    </enlace>
     <enlace NO = "3">
        <nodo1>3</nodo1>
        <costo>10</costo>        
        <nodo2>1</nodo2>
    </enlace> 
    <enlace NO = "4">
        <nodo1>4</nodo1>
        <costo>10</costo>        
        <nodo2>5</nodo2>
    </enlace>
    <enlace NO = "5">
        <nodo1>5</nodo1>
        <costo>10</costo>        
        <nodo2>8</nodo2>
    </enlace>   
     <enlace NO = "6">
        <nodo1>8</nodo1>
        <costo>10</costo>        
        <nodo2>4</nodo2>
    </enlace>
</grafo>'));

INSERT INTO red VALUES(100,'CasoNULL', XMLTYPE('
<grafo>
    <enlace NO = "1">
        <nodo1>100</nodo1>
        <costo></costo>        
        <nodo2></nodo2>
    </enlace>
</grafo>'));

execute ciudades_comunes(330,220);
execute ciudades_comunes(3,1);
execute ciudades_comunes(100,1);
