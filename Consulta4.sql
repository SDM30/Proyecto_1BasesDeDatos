Create view punto4 as
(SELECT EXTRACT(YEAR FROM fechafin) AS a�opoliza, extract(MONTH FROM fechafin) AS mespoliza, sum(valorasegurable) AS total
FROM poliza
GROUP BY extract(YEAR FROM fechafin), extract(MONTH FROM fechafin));
