-- Crear tabla temporal
CREATE TABLE TEMPORAL (	
	NOMBRECLIENTE VARCHAR2(1000), 
	CORREOCLIENTE VARCHAR2(1000), 
	CLIENTEACTIVO VARCHAR2(10), 
	FECHACREACION DATE, 
	TIENDAPREFERIDA VARCHAR2(1000), 
	DIRECCIONCLIENTE VARCHAR2(1000), 
	CODIGOPOSTALCLIENTE NUMBER(10), 
	CIUDADCLIENTE VARCHAR2(50), 
	PAISCLIENTE VARCHAR2(50), 
	FECHARENTA TIMESTAMP (6), 
	FECHARETORNO  TIMESTAMP (6), 
	MONTOAPAGAR  NUMBER(5,2), 
	FECHAPAGO  TIMESTAMP (6), 
	NOMBREEMPLEADO  VARCHAR2(50), 
	CORREOEMPLEADO  VARCHAR2(100), 
	EMPLEADOACTIVO  VARCHAR2(5), 
	TIENDAEMPLEADO  VARCHAR2(50), 
	USUARIOEMPLEADO VARCHAR2(50), 
	CONTRASENIAEMPLEADO VARCHAR2(200), 
	DIRECCIONEMPLEADO VARCHAR2(100), 
	CODIGOPOSTALEMPLEADO NUMBER(10), 
	CIUDADEMPLEADO VARCHAR2(50), 
	PAISEMPLEADO VARCHAR2(50), 
	NOMBRETIENDA VARCHAR2(50), 
	ENCARGADOTIENDA VARCHAR2(50), 
	DIRECCIONTIENDA VARCHAR2(50), 
	CODIGOPOSTALTIENDA NUMBER(10), 
	CIUDADTIENDA VARCHAR2(50), 
	PAISTIENDA VARCHAR2(50), 
	TIENDAPELICULA VARCHAR2(50), 
	NOMBREPELICULA VARCHAR2(50), 
	DESCRIPCIONPELICULA VARCHAR2(350), 
	ANIOLANZAMIENTO NUMBER(10), 
	DIASRENTA NUMBER(10), 
	COSTORENTA NUMBER(10,2), 
	DURACION NUMBER(10), 
	COSTOPORDANIO NUMBER(10), 
	CLASIFICACION VARCHAR2(50), 
	LENGUAJEPELICULA VARCHAR2(150), 
	CATEGORIAPELICULA VARCHAR2(150), 
	ACTORPELICULA VARCHAR2(50)
   ) 

--- Creacion de tablas
create Table Pais (
    ID_pais number(10)  generated always as identity (start with 1 increment by 1) primary key,
    Nombre_pais varchar2(250) not null
);

-- Creacion de la tabla Ciudad
create Table Ciudad (
    ID_Ciudad number(10) generated always as identity (start with 1 increment by 1) primary key,
    Nombre_ciudad varchar2(250) not null,
    FK_ID_pais int not null,
    --llave fornanea
    constraint FK_Ciudad_Pais foreign key(FK_ID_pais) references Pais(ID_pais)
);

--creacion de la tabla dirección
create table Direccion(
    ID_direccion number(10) generated always as identity (start with 1 increment by 1) primary key,
    Descripcion_direccion varchar2(350) ,
    Codigo_Postal number(5) ,
    FK_ID_ciudad number(5) not null,
    --llave fornanea
    constraint FK_Direccion_Ciudad foreign key(FK_ID_ciudad) references Ciudad(ID_Ciudad)
);

--Crear tabla de tienda
create table Tienda(
    ID_tienda number(10) generated always as identity (start with 1 increment by 1) primary key,
    Nombre_tienda varchar2(250) not null,
    FK_ID_direccion number(5) not null,
    --llave fornanea
    constraint FK_ID_direccion foreign key(FK_ID_direccion) references Direccion(ID_direccion)
);

--Creat tabla de empleado
create table Tipo_empleado (
    ID_tipoEmpleado number(10) generated always as identity (start with 1 increment by 1) primary key,
    Tipo_empleado varchar2(25) not null
);

--Crear tabla Estado FK_ID_estadoActividad
Create table Estado_actividad (
    ID_estadoActividad number(10) generated always as identity (start with 1 increment by 1) primary key,
    Estado_actividad varchar2(25)
);

--Crear tabla de empleado
create table Empleado(
    ID_empleado number(10) generated always as identity (start with 1 increment by 1) primary key,
    Nombre_Empleado varchar2(250) not null,
    Apellido_Empleado varchar2(250) not null,
    Correo_Empleado varchar(350) not null,
    User_Empleado varchar2(250) not null,
    Password_Empleado varchar2(1050) not null,
    --
    FK_ID_direccion number(10) not null,
    FK_ID_estadoActividad number(10) not null,
    FK_ID_tipoEmpleado number(10) not null,
    FK_ID_tienda number(10) not null,
    --llave foranea
    constraint FK_ID_direccion_empleado foreign key(FK_ID_direccion) references Direccion(ID_direccion),
    constraint FK_ID_estadoActividad_empleado foreign key(FK_ID_estadoActividad) references Estado_actividad(ID_estadoActividad),
    constraint FK_ID_tipoEmpleado_empleado foreign key(FK_ID_tipoEmpleado) references Tipo_empleado(ID_tipoEmpleado),
    constraint FK_ID_tienda_empleado foreign key(FK_ID_tienda) references Tienda(ID_tienda)
);



--Crear la tabla cliente
Create table cliente(
    ID_cliente number(10) generated always as identity (start with 1 increment by 1) primary key,
    Nombre_Cliente varchar2(250) not null,
    Apellido_Cliente varchar2(250) not null,
    Fecha_registroCliente timestamp,
    Correo_electronico varchar2(250) not null,
    --
    FK_ID_direccion number(10) not null,
    FK_ID_estadoActividad number(10) not null,
    FK_ID_tienda number(10) not null,
    --llave foranea
    constraint FK_ID_estadoActividad_cliente foreign key(FK_ID_estadoActividad) references Estado_actividad(ID_estadoActividad),
    constraint FK_ID_direccion_cliente foreign key(FK_ID_direccion) references Direccion(ID_direccion),
    constraint FK_ID_tienda_cliente foreign key(FK_ID_tienda) references Tienda(ID_tienda)
);


--create la tabla de lenguaje
create table Lenguaje(
    ID_lenguaje number(10) generated always as identity (start with 1 increment by 1) primary key,
    Nombre_idioma varchar2(250) not null

);

-- Crear la tabla de actor 
create table Actor (
    ID_actor number(10) generated always as identity (start with 1 increment by 1) primary key,
    Nombre_actor varchar2(250) not null,
    Apellido_actor varchar2(250) not null
);

--Crear la tabla Categoria
create table Categoria (
    ID_categoria number(10) generated always as identity (start with 1 increment by 1) primary key,
    Nombre_categoria varchar2(250) not null
);

-- Crear la tabla de Clasificacion
create table Clasificacion (
    ID_clasificacion number(10) generated always as identity (start with 1 increment by 1) primary key,
    Nombre_clasificacion varchar2(250) not null
);

--Crear la tabla Pelicula
create table Pelicula(
    ID_pelicula number(10) generated always as identity (start with 1 increment by 1) primary key,
    Titulo_pelicula varchar2(500) not null,
    Descripcion_pelicula varchar2(2500) not null,
    Anio_pelicula number(10) not null,
    Duracion_pelicula number(10) not null,
    Tiempo_renta number(10) not null,
    Costo_renta number(10,2),
    Costo_danio number(10,2),
    --
    FK_ID_clasificacion number(10) not null,
    --llave foranea
    constraint FK_ID_clasificacion_pelicula foreign key(FK_ID_clasificacion) references Clasificacion(ID_clasificacion)
);


--Crear la tabla Pelicula_traduccion
create table Pelicula_traduccion(
    FK_ID_pelicula number(10) not null,
    FK_ID_lenguaje number(10) not null,
    --llave foranea
    constraint FK_ID_pelicula_PeliculaTraduccion foreign key(FK_ID_pelicula) references Pelicula(ID_pelicula),
    constraint FK_ID_lenguaje_PeliculaTraduccion foreign key(FK_ID_lenguaje) references Lenguaje(ID_lenguaje)
);


--crear la tabla de pelicula Pelicula_categoria
create table Pelicula_categoria(
    FK_ID_categoria number(10) not null,
    FK_ID_pelicula number(10) not null,
    --llave foranea
    constraint FK_ID_categoria_PeliculaCategoria foreign key(FK_ID_categoria) references Categoria(ID_categoria),
    constraint FK_ID_pelicula_PeliculaCategoria foreign key(FK_ID_pelicula) references Pelicula(ID_pelicula)
);

--crear la tabla de pelicula actor 
create table Pelicula_actor(
    FK_ID_actor number(10) not null,
    FK_ID_pelicula number(10) not null,
    --llave foranea
    constraint FK_ID_actor_PeliculaActor foreign key(FK_ID_actor) references Actor(ID_actor),
    constraint FK_ID_pelicula_PeliculaActor foreign key(FK_ID_pelicula) references Pelicula(ID_pelicula)
);


--crear la tabla de inventario 
create table Inventario (
    ID_inventario number(10) generated always as identity (start with 1 increment by 1) primary key,
    --
    FK_ID_tienda number(10) not null,
    FK_ID_pelicula number(10) not null,
    --llave foranea
    constraint FK_ID_tienda_inventario foreign key(FK_ID_tienda) references Tienda(ID_tienda),
    constraint FK_ID_pelicula_invetario foreign key(FK_ID_pelicula) references Pelicula(ID_pelicula)
);


--crear la tabla de alquiler
create table Alquiler (
    ID_alquiler number(10) generated always as identity (start with 1 increment by 1) primary key,
    Fecha_alquiler timestamp,
    Fecha_retorno timestamp,
    Monto_pelicula number(10,2),
    --
    FK_ID_inventario number(10) not null,
    FK_ID_empleado number(10) not null,
    FK_ID_cliente number(10) not null,
    --llave foranea
    constraint FK_ID_inventario_alquiler foreign key(FK_ID_inventario) references Inventario(ID_inventario),
    constraint FK_ID_empleado_alquiler foreign key(FK_ID_empleado) references Empleado(ID_empleado),
    constraint FK_ID_cliente_alquiler foreign key(FK_ID_cliente) references Cliente(ID_cliente)
);

--crear la tabla de factura
create table Factura(
    ID_factura number(10) generated always as identity (start with 1 increment by 1) primary key,
    Monto_total number(10,2),
    Fecha_rentabilidad timestamp,
    --

    FK_ID_alquiler number(10) not null,
    --llave foranea
    constraint FK_ID_alquiler_factura foreign key(FK_ID_alquiler) references Alquiler(ID_alquiler)
);





--Eliminacion de tablas
drop table pais CASCADE CONSTRAINTS;
drop table Ciudad CASCADE CONSTRAINTS;
drop table Direccion CASCADE CONSTRAINTS;
drop table Tienda CASCADE CONSTRAINTS;
drop table Tipo_empleado CASCADE CONSTRAINTS;
drop table Estado_actividad CASCADE CONSTRAINTS;
drop table Empleado CASCADE CONSTRAINTS;
drop table Cliente CASCADE CONSTRAINTS;
drop table Lenguaje CASCADE CONSTRAINTS;
drop table Actor CASCADE CONSTRAINTS;
drop table Categoria CASCADE CONSTRAINTS;
drop table Clasificacion CASCADE CONSTRAINTS;
drop table Pelicula CASCADE CONSTRAINTS;
drop table Pelicula_traduccion CASCADE CONSTRAINTS;
drop table Pelicula_categoria CASCADE CONSTRAINTS;
drop table Pelicula_actor CASCADE CONSTRAINTS;
drop table inventario CASCADE CONSTRAINTS;
drop table alquiler CASCADE CONSTRAINTS;
drop table factura CASCADE CONSTRAINTS;




