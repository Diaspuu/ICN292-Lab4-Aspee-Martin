drop database if exists austral;
create database austral;
use austral;

create table autores (
    id_autor int auto_increment,
    nombre varchar(80) not null,
    pais varchar(60),
    genero enum('comic', 'ensayo', 'infantil', 'novela', 'poesia') not null,
    primary key (id_autor)
);

create table colecciones (
id_coleccion int auto_increment, 
titulo varchar(120) not null, 
fecha_publicacion date,
primary key (id_coleccion)
);

create table libros (
id_titulo int auto_increment,
id_autor int,
id_coleccion int,
titulo varchar(210) not null,
paginas int,
ejemplares_vendidos int,
anio int,
primary key (id_titulo),
foreign key (id_autor) references autores(id_autor)
);

create table pagos (
id_pago int auto_increment, 
id_autor int, 
fecha_pago date, 
monto decimal(10,2),
primary key (id_pago),
foreign key (id_autor) references autores(id_autor)
);

insert into autores (nombre, pais, genero) values
('Elena Pizarro',     'Chile',          'novela'),
('Harold Finc',       'Inglaterra',     'Ensayo'),
('Rodrigo Bahamonde', 'Chile',          'Poesía'),
('Valentina Correa',  'Argentina',      'Infantil'),
('Nora Keller',       'Estados Unidos', 'Novela'),
('Kenji Arakawa',      NULL,            'Cómic');

insert into colecciones (titulo, fecha_publicacion) values
('coleccion calor', '2024-02-17'),
('coleccion frio', '2024-07-23');

insert into libros (id_autor, id_coleccion, titulo, paginas, ejemplares_vendidos, anio) values
(1, 1, 'Cielo de Enero',     210,  1500, 2024),
(1, 1, 'Marea Baja',	     185,  800,  2023),
(1, 1, 'El Norte',           200,  2200, 2024),
(2, 2, 'Estrellas que Caen', 240,  3000, 2022),
(2, 2, 'Máquinas',           215,  450,  2024),
(3, 2, 'Luz Artificial',     300,  1200, 2024),
(3, 1, 'Ruido Blanco',       280,  600,  2023),
(4, 2, 'El Barrio de Lila',  190,  5000, 2024),
(4, 2, 'Antes del Amanecer', 205,  2700, 2024),
(4, 2, 'La Calle 8',         175,  900,  2023),
(5, 1, 'Flor de Hierro',     195,  4100, 2024),
(5, 1, 'Hora Dorada',        220,  1800, 2022);

INSERT INTO pagos (id_autor, fecha_pago, monto) VALUES 
(1, '2026-08-13', 125000.50),
(1, '2026-09-06', 180000.25),
(3, '2026-10-19', 360000.25),
(5, '2026-11-27', 420000.75);

select nombre, genero
from autores
where pais <> 'chile'
order by nombre;

select titulo, paginas
from libros
where paginas between 190 and 220
order by paginas;

select 
	count(*) as libros,
	sum(ejemplares_vendidos) as total_ventas,
	avg(paginas)	as prom_paginas,
	min(anio) as anio_mas_antiguo,
    max(ejemplares_vendidos) as max_ventas
from libros;

select genero
from autores
order by genero;

select a.nombre, COUNT(*) as total_libros
from autores a
join libros l on a.id_autor = l.id_autor
group by a.id_autor, a.nombre
having COUNT(*) > 1
order by a.nombre;

select titulo, ejemplares_vendidos
from libros
where anio = 2024 and ejemplares_vendidos >= 2000
order by ejemplares_vendidos desc
limit 3;

insert into libros (id_autor, id_coleccion, titulo, paginas, ejemplares_vendidos, anio) values
(3, 2, 'papel mojado', 260, 50, 2024);
select id_autor, id_coleccion, titulo, paginas, ejemplares_vendidos, anio
from libros
order by id_autor;

delete from libros
where id_autor=3 and titulo = 'papel mojado'; 
select id_autor, id_coleccion, titulo, paginas, ejemplares_vendidos, anio
from libros
order by id_autor;

update libros
set ejemplares_vendidos = ejemplares_vendidos + 100
where id_autor = 1 and titulo = 'cielo de enero';
select id_autor, id_coleccion, titulo, paginas, ejemplares_vendidos, anio
from libros
order by id_autor;

select l.titulo, c.titulo as coleccion, c.fecha_publicacion
from libros l 
join colecciones c on l.id_coleccion = c.id_coleccion;

select a.nombre, p.fecha_pago, p.monto
from autores a
join pagos p on a.id_autor = p.id_autor;

select a.nombre, sum(p.monto) as total_pagado
from pagos p
join autores a on p.id_autor = a.id_autor
group by a.id_autor, a.nombre;