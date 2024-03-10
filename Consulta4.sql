Create view punto4 as
(SELECT EXTRACT(YEAR FROM fechafin) AS añopoliza, extract(MONTH FROM fechafin) AS mespoliza, sum(valorasegurable) AS total
FROM poliza
GROUP BY extract(YEAR FROM fechafin), extract(MONTH FROM fechafin));
