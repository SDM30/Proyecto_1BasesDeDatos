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
