-- consultas para llenar la base de datos 

--Insertar en pais
insert into pais(nombre_pais)
select temporal.paiscliente from temporal
where paiscliente is not null
union
select temporal.paisempleado from temporal
where paisempleado is not null
union
select temporal.paistienda from temporal
where paistienda is not null;



-- Insertar en ciudad
--select * from ciudad;
insert into ciudad(nombre_ciudad,fk_id_pais)
select temporal.ciudadcliente, pais.id_pais from temporal
inner join pais on pais.nombre_pais = temporal.paiscliente
where ciudadcliente is not null
union
select temporal.ciudadempleado, pais.id_pais from temporal
inner join pais on pais.nombre_pais = temporal.paisempleado
where temporal.ciudadempleado is not null
union
select temporal.ciudadtienda, pais.id_pais from temporal
inner join pais on pais.nombre_pais = temporal.paistienda
where temporal.ciudadtienda is not null;



--Insertar en direccion
--select * from direccion;
insert into direccion(descripcion_direccion,codigo_postal,fk_id_ciudad)
select distinct temporal.direccioncliente,temporal.codigopostalcliente,ciudad.id_ciudad from temporal
inner join ciudad on ciudad.nombre_ciudad = temporal.ciudadcliente
where temporal.direccioncliente is not null
union
select distinct temporal.direccionempleado,temporal.codigopostalempleado,ciudad.id_ciudad from temporal
inner join ciudad on ciudad.nombre_ciudad = temporal.ciudadcliente
where temporal.direccionempleado is not null
and temporal.codigopostalempleado is not null
union
select distinct temporal.direcciontienda,temporal.codigopostaltienda,ciudad.id_ciudad from temporal
inner join ciudad on ciudad.nombre_ciudad = temporal.ciudadcliente
where temporal.direcciontienda is not null
and temporal.codigopostaltienda is not null;

--Insertar en lenguaje 
--select * from lenguaje;
insert into lenguaje(nombre_idioma)
select DISTINCT temporal.lenguajepelicula from temporal
where temporal.lenguajepelicula is not null;


--Insertar actor
--select * from actor;
insert into actor(nombre_actor,apellido_actor)
select distinct substr(Temporal.actorpelicula,1,INSTR(temporal.actorpelicula,' ')-1) as NombreActor,
substr(Temporal.actorpelicula,INSTR(temporal.actorpelicula,' ')+1) as ApellidoActor from temporal
where Temporal.actorpelicula is not null;

--Clasificacion
--select * from clasificacion;
insert into clasificacion(nombre_clasificacion)
select distinct temporal.clasificacion from temporal
where clasificacion is not null;


--Categoria
--select * from categoria;
insert into Categoria(nombre_categoria)
select distinct temporal.categoriapelicula from temporal
where categoriapelicula is not null;


--Estado actividad si/no
--select * from estado_actividad;
insert into estado_actividad(estado_actividad)
select temporal.clienteactivo from temporal
where clienteactivo is not null
union
select temporal.empleadoactivo from temporal
where empleadoactivo is not null;


--insertar en pelicula
--select * from pelicula;
insert into pelicula(titulo_pelicula,descripcion_pelicula,anio_pelicula, duracion_pelicula,tiempo_renta,costo_renta,costo_danio,fk_id_clasificacion)
select distinct temporal.nombrepelicula, temporal.descripcionpelicula, temporal.aniolanzamiento,temporal.duracion, temporal.diasrenta,temporal.costorenta, temporal.costopordanio, clasificacion.id_clasificacion from temporal
inner join clasificacion on clasificacion.nombre_clasificacion = temporal.clasificacion
where temporal.clasificacion is not null;

--insertar en tienda
insert into Tienda(nombre_tienda,fk_id_direccion)
select distinct temporal.nombretienda, direccion.id_direccion from temporal
inner join Direccion on direccion.descripcion_direccion = temporal.direcciontienda
where temporal.nombretienda is not null;

--insertar en inventario
--select * from inventario;
insert into inventario(fk_id_tienda,fk_id_pelicula)
select distinct tienda.id_tienda, pelicula.id_pelicula from temporal
inner join pelicula on pelicula.titulo_pelicula = temporal.nombrepelicula
inner join tienda on tienda.nombre_tienda = temporal.tiendapelicula
inner join pais on pais.nombre_pais = temporal.paistienda;


--insertar en cliente
insert into cliente(nombre_cliente,apellido_cliente,fecha_registrocliente,correo_electronico,fk_id_direccion,fk_id_estadoactividad,fk_id_tienda)
select distinct substr(temporal.nombrecliente,1,INSTR(temporal.nombrecliente,' ')-1) as Nombre, substr(temporal.nombrecliente,INSTR(temporal.nombrecliente,' ')+1) as Apellido,temporal.fechacreacion,temporal.correocliente,direccion.id_direccion, estado_actividad.id_estadoActividad, tienda.id_tienda from temporal
inner join direccion on direccion.descripcion_direccion = temporal.direccioncliente
inner join estado_actividad on estado_actividad.estado_actividad = temporal.clienteactivo
inner join tienda on tienda.nombre_tienda = temporal.tiendapreferida
inner join ciudad on ciudad.id_ciudad = direccion.fk_id_ciudad
inner join pais on pais.id_pais = ciudad.fk_id_pais
where temporal.nombrecliente is not null
and pais.nombre_pais = temporal.paiscliente
and ciudad.nombre_ciudad = temporal.ciudadcliente;

-- insertar en pelicula_traduccion
insert into pelicula_traduccion(fk_id_pelicula,fk_id_lenguaje)
select distinct pelicula.id_pelicula, lenguaje.id_lenguaje from temporal
inner join pelicula on pelicula.titulo_pelicula = temporal.nombrepelicula
inner join lenguaje on lenguaje.nombre_idioma = temporal.lenguajepelicula
where temporal.nombrepelicula is not null
and temporal.lenguajepelicula is not null;




--insertar en pelicula actor 5462

insert into pelicula_actor(fk_id_actor,fk_id_pelicula)
select distinct actor.id_actor,pelicula.id_pelicula from temporal
inner join actor on  actor.nombre_actor ||' '|| actor.apellido_actor = temporal.actorpelicula
inner join pelicula on pelicula.titulo_pelicula = temporal.nombrepelicula
where nombrepelicula is not null
and actorpelicula is not null;


--insertar  pelicula categoria
--select * from pelicula_categoria;
insert into pelicula_categoria(fk_id_categoria,fk_id_pelicula)
select distinct categoria.id_categoria, pelicula.id_pelicula from temporal
inner join categoria on categoria.nombre_categoria = temporal.categoriapelicula
inner join pelicula on pelicula.titulo_pelicula = temporal.nombrepelicula
where temporal.categoriapelicula is not null
and temporal.nombrepelicula is not null;




--insert en tipo empleado
--select * from tipo_empleado;
insert into tipo_empleado(tipo_empleado) values('Encargado');
insert into tipo_empleado(tipo_empleado) values('Empleado');


--insertar a los empleado 2 empleados
select * from empleado;
insert into empleado(nombre_empleado,apellido_empleado,correo_empleado,user_empleado,password_empleado,fk_id_direccion,fk_id_estadoactividad,fk_id_tipoempleado,fk_id_tienda)
select distinct substr(temporal.nombreempleado,1,INSTR(temporal.nombreempleado,' ')-1) as Nombre, 
substr(temporal.nombreempleado,INSTR(temporal.nombreempleado,' ')+1) as Apellido,
temporal.correoempleado, temporal.usuarioempleado, temporal.contraseniaempleado,
direccion.id_direccion, estado_actividad.id_estadoactividad,
CASE WHEN temporal.nombreempleado = temporal.encargadotienda THEN 2 ELSE 1 END as Tipo_empleado, tienda.id_tienda from temporal
inner join direccion on direccion.descripcion_direccion = temporal.direccionempleado
inner join estado_actividad on estado_actividad.estado_actividad = temporal.clienteactivo
inner join tienda on tienda.nombre_tienda = temporal.nombretienda
where direccionempleado is not null
and temporal.clienteactivo is not null
and estado_actividad.estado_actividad = 'Si';


--insertar en alquiler
insert into alquiler(fecha_alquiler,fecha_retorno,fk_id_inventario,fk_id_empleado,fk_id_cliente,Monto_pelicula)
select nueva.fechatemp,nueva.fecharetorno, inventario.id_inventario,nueva.empleado, nueva.cliente,
nueva.monto
from inventario 
inner join (
        select distinct temporal.fecharenta as fechatemp
        , temporal.fecharetorno as fecharetorno
        ,cliente.id_cliente as cliente
        ,empleado.id_empleado as empleado
        ,tienda.id_tienda as idtienda
        ,pelicula.id_pelicula as idpelicula
        ,temporal.costorenta as monto
        
        from temporal
            inner join cliente on cliente.nombre_cliente ||' '|| cliente.apellido_cliente = temporal.nombrecliente
            inner join empleado on  empleado.nombre_empleado ||' '|| empleado.apellido_empleado = temporal.nombreempleado
            inner join tienda on temporal.tiendapelicula  = tienda.nombre_tienda
            inner join pelicula on temporal.nombrepelicula = pelicula.titulo_pelicula
        
        
        
        where temporal.fecharenta is not null
        and temporal.montoapagar is not null
        and temporal.nombrecliente is not null
        ) 
 nueva on inventario.fk_id_tienda = nueva.idtienda 
and inventario.fk_id_pelicula = nueva.idpelicula;


---fake
select distinct temporal.fecharenta, temporal.fecharetorno, temporal.montoapagar,cliente.id_cliente
--,empleado.id_empleado 
from temporal
inner join cliente on cliente.nombre_cliente ||' '|| cliente.apellido_cliente = temporal.nombrecliente
--inner join empleado on  empleado.nombre_empleado ||' '|| empleado.apellido_empleado = temporal.nombreempleado
where temporal.fecharenta is not null
and temporal.montoapagar is not null
and temporal.nombrecliente is not null;
