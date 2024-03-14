--PUNTO 1

CREATE VIEW punto1 AS
SELECT t1.idpoliza, (t1.suma/100)*p.valorasegurable AS res
FROM
    (SELECT t1.idpol AS idpoliza, SUM(por2 + por1) AS suma
     FROM
        (SELECT p.id AS idpoliza, tc.porcentaje AS por2
         FROM poliza p JOIN tipo_cubrimiento tc
         ON p.idtipocubrimiento = tc.id) t2
     JOIN
         (SELECT k.id AS idpol, dept.porcentaje AS por1
          FROM departamento dept JOIN 
               (SELECT p.id AS id, t.iddepartamento AS iddept
                FROM poliza p JOIN tomador t
                ON p.idtomador = t.id) k
          ON k.iddept = dept.id) t1
    ON t2.idpoliza = t1.idpol
    GROUP BY t1.idpol) t1
JOIN poliza p 
ON t1.idpoliza = p.id;

--PUNTO 2

Create view punto2 as
(
Select poltomdeptip.nombre as nombreTomador, poltomdeptip.tipoCubrimiento, poltomdeptip.nombredep as nombreDepartamento, poltomdeptip.numeroPoliza, p.res as valorPoliza
From(
    Select poltomdep.pId, poltomdep.numeroPoliza, poltomdep.idtipocubrimiento, poltomdep.depId, poltomdep.nombre, poltomdep.nombredep, tipo_cubrimiento.nombre as tipoCubrimiento
    From (
        Select polizatomador.pId, polizatomador.numeroPoliza, polizatomador.idtipocubrimiento, polizatomador.depId, polizatomador.nombre as nombre, departamento.nombre as nombredep
        From (Select poliza.id as pId, poliza.numero as numeroPoliza,poliza.idtipocubrimiento,tomador.iddepartamento as depId , tomador.nombre 
                From tomador
                Left Join poliza On tomador.id = poliza.idtomador) polizatomador
        Join departamento On polizatomador.depId = departamento.id
      ) PolTomDep
    Left Join tipo_cubrimiento ON poltomdep.idtipocubrimiento = tipo_cubrimiento.id
    ) PolTomDepTip
Left Join punto1 p ON poltomdeptip.pid = p.idpoliza
);

-- PUNTO 3

Create view punto3 as
(SELECT nomtomador AS nombretomador, valoraseg AS valorasegurable, totalpol as totalpoliza, sum(valoraseg + totalpol) as total
FROM
    (SELECT t1.nombretomador as nomtomador, sum(t1.valorasegurable) as valoraseg, sum(punto1.res) as totalpol
     FROM punto1 JOIN
            (SELECT t.nombre as nombretomador, p.id as idpoliza, p.valorasegurable as valorasegurable
             FROM tomador t JOIN poliza p
             ON t.id= p.idtomador)t1
     ON t1.idpoliza= punto1.idpoliza
     GROUP BY t1.nombretomador)t2
     GROUP BY t2.nomtomador,valoraseg, totalpol);
     
-- PUNTO 4

Create view punto4 as
(SELECT EXTRACT(YEAR FROM fechafin) AS añopoliza, extract(MONTH FROM fechafin) AS mespoliza, sum(valorasegurable) AS total
FROM poliza
GROUP BY extract(YEAR FROM fechafin), extract(MONTH FROM fechafin));

--´Punto 5

Create view punto5 as
(SELECT t2.nomdept as nombredept, (t2.tomadores/t3.totaltomadores)*100 as participacion
 FROM (SELECT COUNT(DISTINCT p.idtomador) as tomadores, t1.nomdept
     FROM poliza p JOIN (SELECT t.id as idtomador, d.nombre as nomdept
                        FROM tomador t JOIN departamento d
                        ON t.iddepartamento= d.id)t1
     ON p.idtomador= t1.idtomador
     GROUP BY t1.nomdept)t2, (SELECT COUNT (id) as totaltomadores
 FROM tomador)t3);
 
 -- Punto 6

Create view punto6 as
(Select nombre
From(Select tomador.nombre, count(poliza.idtipocubrimiento) as numdeCubrimientos
     From tomador
     Join poliza On tomador.id = poliza.idtomador
     group by tomador.nombre) t1
Where t1.numdecubrimientos = (Select count(id) From tipo_cubrimiento));

--PUNTO 7

Create view punto7 as
(Select d.nombre as nom_departamento,
    sum(case when lower(t.genero) = 'femenino' then 1 else 0 end) as cant_mujeres,
    sum(case when lower(t.genero) = 'masculino' then 1 else 0 end) as cant_hombres,
    count(*) as total
from departamento d join tomador t on d.id = t.iddepartamento
group by d.nombre);



