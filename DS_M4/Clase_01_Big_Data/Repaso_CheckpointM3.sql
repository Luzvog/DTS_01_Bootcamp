use henry_checkpoint_m3;

create view v_venta as
select	year(v.Fecha)				as Anio,
		month(v.Fecha)				As Mes,
		sum(v.Precio * v.Cantidad)	as Venta
from 	venta v
group by year(v.Fecha), month(v.Fecha);

create view v_gasto as
select	year(g.Fecha)				as Anio,
		month(g.Fecha)				As Mes,
		sum(g.Monto)				as Gasto
from 	gasto g
group by year(g.Fecha), month(g.Fecha);

create view v_compra as
select	year(c.Fecha)				as Anio,
		month(c.Fecha)				As Mes,
		sum(c.Precio * c.Cantidad)	as Compra
from 	compra c
group by year(c.Fecha), month(c.Fecha);

select * from v_venta where mes = 4;
select * from v_gasto where mes = 4;
select * from v_compra where mes = 4;

select	g1.Mes,
		g1.Ganancia	as G_2020,
        g2.Ganancia	as G_2019,
		(g1.Ganancia / g2.Ganancia) as Proporcion,
		g1.Ganancia - g2.Ganancia as Diferencia
from
	(select	v.Mes,
			(v.Venta - g.Gasto - c.Compra) Ganancia
	from 	v_venta v join v_gasto g
				on (v.Mes = g.Mes and v.Anio = g.Anio)
			join v_compra c
				on (v.Mes = c.Mes and v.Anio = c.Anio)
	where 	v.Anio = 2020) as g1
join
	(select	v.Mes,
			(v.Venta - g.Gasto - c.Compra) Ganancia
	from 	v_venta v join v_gasto g
				on (v.Mes = g.Mes and v.Anio = g.Anio)
			join v_compra c
				on (v.Mes = c.Mes and v.Anio = c.Anio)
	where 	v.Anio = 2019) as g2
    on (g1.Mes = g2.Mes)
order by Proporcion desc;
/*
Feb 2019 = 1, 
Feb 2020 = 11, 
Dif = 10; 

Mar 2019 = 20, 
Mar 2020 = 30; 
Dif = 10. 

¿Cuál creció más? Febrero, porque creció 1000%, Marzo sólo 50%
*/
select 	e.IdEmpleado,
		e.CodigoEmpleado,
        s.Sucursal,
        (v.Precio * v.Cantidad * c.Porcentaje / 100)	as Comision
from empleado e join sucursal s
		on (e.idSucursal = s.IdSucursal)
	join comisiones c
		On (e.CodigoEmpleado = c.CodigoEmpleado
			And s.IdSucursal = c.IdSucursal)
	join venta v
		on (v.IdEmpleado = e.IdEmpleado
			And year(v.Fecha) = c.Anio
            and month(v.Fecha) = c.Mes
            and c.Anio = 2020
            and c.Mes = 12)
Group by e.IdEmpleado,
		e.CodigoEmpleado,
        s.Sucursal
Order by Comision Desc;

select * from comisiones;