CREATE TABLE departamento
(   ID number(10,0) generated always as identity NOT NULL,
    nombre  varchar(25) UNIQUE NOT NULL,
    porcentaje number NOT NULL,
    CONSTRAINT chk_porcentaje CHECK (porcentaje >= 0 AND porcentaje <= 100),
    primary key (ID)
);

CREATE TABLE tomador
(
    id number(10,0) generated always as identity NOT NULL,
    cedula varchar(10) UNIQUE NOT NULL,
    nombre varchar(20) NOT null,
    genero varchar(9) CHECK (genero = 'Masculino' OR genero ='Femenino') NOT null,
    edad number(3) CHECK (edad between 18 and 100) NOT NULL,
    iddepartamento number(10,0) NOT NULL,
    foreign key (iddepartamento) references departamento on delete set null,
    primary key(id)
    
);

CREATE TABLE tipo_cubrimiento
(
   id number(10,0) generated always as identity NOT NULL,
   nombre varchar(20) UNIQUE NOT NULL,
   porcentaje number NOT NULL,
   CONSTRAINT chk_porcentaje1 CHECK(porcentaje >= 0 AND porcentaje <= 100),
   primary key(id)
);

CREATE TABLE Poliza 
(
    id number(10,0) generated always as identity NOT NULL,
     numero varchar(10) UNIQUE NOT NULL,
     valorasegurable number(10,0) default 0 CHECK (valorasegurable >=0) NOT NULL,
     fechainicio date NOT NULL,
     fechafin date NOT NULL,
     idtipocubrimiento number(10,0) NOT NULL,
     idtomador number(10,0) NOT NULL,
     foreign key (idtipocubrimiento) references tipo_cubrimiento,
     foreign key (idtomador) references tomador,
     primary key (id)
);