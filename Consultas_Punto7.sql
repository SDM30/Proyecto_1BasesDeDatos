Create view punto7 as
(Select d.nombre as nom_departamento,
    sum(case when lower(t.genero) = 'femenino' then 1 else 0 end) as cant_mujeres,
    sum(case when lower(t.genero) = 'masculino' then 1 else 0 end) as cant_hombres,
    count(*) as total
from departamento d join tomador t on d.id = t.iddepartamento
group by d.nombre);
