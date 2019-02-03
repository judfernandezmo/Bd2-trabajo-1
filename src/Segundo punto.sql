--Creacion de la tabla red
CREATE TABLE red(
id_red NUMBER(8) PRIMARY KEY,
nombre_red VARCHAR2(40) NOT NULL,
grafo_rutas XMLTYPE
); 

--Insercion de datos en la tabla red
INSERT INTO red VALUES(5,'ejemplo', XMLTYPE('
<grafo>
    <enlace NO = "1">
        <nodo1>100</nodo1>
        <costo>50</costo>        
        <nodo2>300</nodo2>
    </enlace>
    <enlace NO = "2">
        <nodo1>100</nodo1>
        <costo>90</costo>        
        <nodo2>300</nodo2>
    </enlace>
     <enlace NO = "3">
        <nodo1>100</nodo1>
        <costo>100</costo>        
        <nodo2>200</nodo2>
    </enlace>
    <enlace NO = "4">
        <nodo1>200</nodo1>
        <costo>20</costo>        
        <nodo2>40</nodo2>
    </enlace>
    <enlace NO = "5">
        <nodo1>31</nodo1>
        <costo>30</costo>        
        <nodo2>42</nodo2>
    </enlace>
     <enlace NO = "6">
        <nodo1>42</nodo1>
        <costo>90</costo>        
        <nodo2>52</nodo2>
    </enlace>
    <enlace NO = "7">
        <nodo1>52</nodo1>
        <costo>10000</costo>        
        <nodo2>12</nodo2>
    </enlace>
</grafo>'));

INSERT INTO red VALUES(330,'profesor', XMLTYPE('
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

INSERT INTO red VALUES(33,'ejemplo2', XMLTYPE('
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
        <nodo1>4</nodo1>
        <costo>20</costo>        
        <nodo2>2</nodo2>
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
</grafo>'));

INSERT INTO red VALUES(26,'varios_ejemplo', XMLTYPE('
<grafo>
    <enlace NO = "1">
        <nodo1>1</nodo1>
        <costo>100</costo>        
        <nodo2>2</nodo2>
    </enlace>
    <enlace NO = "2">
        <nodo1>2</nodo1>
        <costo>100</costo>        
        <nodo2>3</nodo2>
    </enlace>
     <enlace NO = "3">
        <nodo1>3</nodo1>
        <costo>100</costo>        
        <nodo2>2</nodo2>
    </enlace>
    <enlace NO = "4">
        <nodo1>3</nodo1>
        <costo>100</costo>        
        <nodo2>4</nodo2>
    </enlace>
</grafo>'));
INSERT INTO red VALUES(12,'Santiejemplo', XMLTYPE('
<grafo>
    <enlace NO = "1">
        <nodo1>1</nodo1>
        <costo>100</costo>        
        <nodo2>2</nodo2>
    </enlace>
    <enlace NO = "2">
        <nodo1>2</nodo1>
        <costo>100</costo>        
        <nodo2>3</nodo2>
    </enlace>
     <enlace NO = "3">
        <nodo1>3</nodo1>
        <costo>100</costo>        
        <nodo2>2</nodo2>
    </enlace>
    <enlace NO = "4">
        <nodo1>3</nodo1>
        <costo>100</costo>        
        <nodo2>4</nodo2>
    </enlace>
    <enlace NO = "5">
        <nodo1>4</nodo1>
        <costo>100</costo>        
        <nodo2>2</nodo2>
    </enlace>
</grafo>'));

INSERT INTO red VALUES(10,'critico', XMLTYPE('
<grafo>
    <enlace NO = "1">
        <nodo1>1</nodo1>
        <costo>100</costo>        
        <nodo2>2</nodo2>
    </enlace>
    <enlace NO = "2">
        <nodo1>2</nodo1>
        <costo>100</costo>        
        <nodo2>3</nodo2>
    </enlace>
     <enlace NO = "3">
        <nodo1>3</nodo1>
        <costo>100</costo>        
        <nodo2>2</nodo2>
    </enlace>
    <enlace NO = "4">
        <nodo1>3</nodo1>
        <costo>100</costo>        
        <nodo2>4</nodo2>
    </enlace>
    <enlace NO = "5">
        <nodo1>4</nodo1>
        <costo>100</costo>        
        <nodo2>1</nodo2>
    </enlace>
     <enlace NO = "5">
        <nodo1>4</nodo1>
        <costo>100</costo>        
        <nodo2>2</nodo2>
    </enlace>
</grafo>'));