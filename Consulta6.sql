
(Select nombre
From(Select tomador.nombre, count(poliza.idtipocubrimiento) as numdeCubrimientos
     From tomador
     Join poliza On tomador.id = poliza.idtomador
     group by tomador.nombre) t1
Where t1.numdecubrimientos = (Select count(id) From tipo_cubrimiento));
