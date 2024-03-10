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
