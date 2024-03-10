Create view punto5 as
(SELECT t2.nomdept as nombredept, (t2.tomadores/t3.totaltomadores)*100 as participacion
 FROM (SELECT COUNT(DISTINCT p.idtomador) as tomadores, t1.nomdept
     FROM poliza p JOIN (SELECT t.id as idtomador, d.nombre as nomdept
                        FROM tomador t JOIN departamento d
                        ON t.iddepartamento= d.id)t1
     ON p.idtomador= t1.idtomador
     GROUP BY t1.nomdept)t2, (SELECT COUNT (id) as totaltomadores
 FROM tomador)t3);