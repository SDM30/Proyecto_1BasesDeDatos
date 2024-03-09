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
JOIN poliza p ON t1.idpoliza = p.id;
