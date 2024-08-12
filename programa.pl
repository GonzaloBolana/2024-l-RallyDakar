ganador(1997,peterhansel,moto(1995, 1)).
ganador(1998,peterhansel,moto(1998, 1)).
ganador(2010,sainz,auto(touareg)).
ganador(2010,depress,moto(2009, 2)).
ganador(2010,karibov,camion([vodka, mate])).
ganador(2010,patronelli,cuatri(yamaha)).
ganador(2011,principeCatar,auto(touareg)).
ganador(2011,coma,moto(2011, 2)).
ganador(2011,chagin,camion([repuestos, mate])).
ganador(2011,patronelli,cuatri(yamaha)).
ganador(2012,peterhansel,auto(countryman)).
ganador(2012,depress,moto(2011, 2)).
ganador(2012,deRooy,camion([vodka, bebidas])).
ganador(2012,patronelli,cuatri(yamaha)).
ganador(2013,peterhansel,auto(countryman)).
ganador(2013,depress,moto(2011, 2)).
ganador(2013,nikolaev,camion([vodka, bebidas])).
ganador(2013,patronelli,cuatri(yamaha)).
ganador(2014,coma,auto(countryman)).
ganador(2014,coma,moto(2013, 3)).
ganador(2014,karibov,camion([tanqueExtra])).
ganador(2014,casale,cuatri(yamaha)).
ganador(2015,principeCatar,auto(countryman)).
ganador(2015,coma,moto(2013, 2)).
ganador(2015,mardeev,camion([])).
ganador(2015,sonic,cuatri(yamaha)).
ganador(2016,peterhansel,auto(2008)).
ganador(2016,prince,moto(2016, 2)).
ganador(2016,deRooy,camion([vodka, mascota])).
ganador(2016,patronelli,cuatri(yamaha)).
ganador(2017,peterhansel,auto(3008)).
ganador(2017,sunderland,moto(2016, 4)).
ganador(2017,nikolaev,camion([ruedaExtra])).
ganador(2017,karyakin,cuatri(yamaha)).
ganador(2018,sainz,auto(3008)).
ganador(2018,walkner,moto(2018, 3)).
ganador(2018,nicolaev,camion([vodka, cama])).
ganador(2018,casale,cuatri(yamaha)).
ganador(2019,principeCatar,auto(hilux)).
ganador(2019,prince,moto(2018, 2)).
ganador(2019,nikolaev,camion([cama, mascota])).
ganador(2019,cavigliasso,cuatri(yamaha)).

pais(peterhansel,francia).
pais(sainz,espania).
pais(depress,francia).
pais(karibov,rusia).
pais(patronelli,argentina).
pais(principeCatar,catar).
pais(coma,espania).
pais(chagin,rusia).
pais(deRooy,holanda).
pais(nikolaev,rusia).
pais(casale,chile).
pais(mardeev,rusia).
pais(sonic,polonia).
pais(prince,australia).
pais(sunderland,reinoUnido).
pais(karyakin,rusia).
pais(walkner,austria).
pais(cavigliasso,argentina).



%Punto 1:

marcaDelModelo(peugeot,2008).
marcaDelModelo(peugeot,3008).
marcaDelModelo(mini, countryman).
marcaDelModelo(volkswagen,touareg).
marcaDelModelo(toyota,hilux).

/*
marcaDelModelo(mini,buggy) pondria dando a entender que el modelo buggy es de la marca mini, por ende cuando realizamos
la consulta la misma nos retorna un true.

Sin Embargo, si nosotros hariamos esta consulta marcaDelModelo(mini,dkr), el mismo nos daria falso ya que no hace falta que 
lo definamos en nuestra base de conocimiento.

*/

%Punto 2: ganador(2012,depress,moto(2011, 2)).

ganadorReincidente(Competidor):-
    ganoEn(UnAnio, Competidor),
    ganoEn(OtroAnio, Competidor),
    UnAnio \= OtroAnio.

ganoEn(Anio,Competidor):-
    ganador(Anio,Competidor,_).


%Punto 3:

/*

inspirador e inspirado deben ser del mismo pais y puede inspirarlo

Inspirador gana a Inspirado (loInspira)
O (loInspira): gano en algun año anterior al inspirado.
*/
inspiraA(Inspirador,Inspirado):-
    sonDelMismoPais(Inspirador,Inspirado),
    loInspira(Inspirador,Inspirado).


sonDelMismoPais(Inspirador,Inspirado):-
    pais(Inspirador,UnPais),
    pais(Inspirado,OtroPais),
    UnPais = OtroPais.

loInspira(Inspirador,Inspirado):-  %Caso en que gano el Inspirador y no el inspirado.
    ganoEn(Anio,Inspirador),
    not(ganoEn(Anio,Inspirado)).

loInspira(Inspirador,Inspirado):- %Gano en algun año anterio al inspirado.
    ganoEn(UnAnio,Inspirador),
    ganoEn(OtroAnio,Inspirado),
    UnAnio < OtroAnio.


%Punto 4:

marcaDeLaFortuna(Conductor,Marca):-
    ganoEn(_,Conductor),
    marcaQueUso(Conductor,Marca),
    not(ganoConOtraMarca(Conductor,Marca)).

ganoConOtraMarca(Conductor,Marca):-
    marcaQueUso(Conductor,Marca),
    marcaQueUso(Conductor,OtraMarca),
    Marca \= OtraMarca.

marcaQueUso(Conductor,Marca):-
    ganador(_,Conductor,Vehiculo),
    marca(Vehiculo,Marca).


marca(auto(Modelo),Marca):- % Marca y modelo del auto.
    marcaDelModelo(Marca,Modelo).

marca(Camion,kamaz):-
    lleva(vodka,Camion).
marca(Camion,iveco):-
    esCamion(Camion),
    not(lleva(vodka,Camion)).

esCamion(camion(_)).

lleva(Item,camion(Items)):-
    member(Item, Items). %Con el member busco si ese item pertenece a los items 
    

marca(cuatri(Marca), Marca).

marca(Moto,ktm):-
    fabricadasAnio(2000,Moto).

marca(Moto,yamaha):-
    esMoto(Moto),
    not(fabricadasAnio(2000,Moto)).

fabricadasAnio(Anio,oto(AnioDeFabricacion,_)):-
    AnioDeFabricacion >= Anio.

esMoto(moto(_,_)).


%Punto 5:
/*
heroePopular(Conductor) -> Se cumple cuando:

- Sirvio de inspiracion a alguien.
- Fue el unico que cuando gano no uso un vehiculo caro.

*/

heroePopular(Conductor):-
    loInspira(Conductor,_), %Hay que ver si inspiro a alguien
    unicoSinVehiculoCaro(Conductor).


/*
unicoSinVehiculoCaro(Conductor), se cumple si:

- No uso un vehiculo caro el año que gano.
- Para todo otro ganador ese mismo año, uso un vehiculo caro.


*/

unicoSinVehiculoCaro(Conductor):-
    ganoEn(Anio,Conductor),
    not(usoUnVehiculoCaro(Conductor,Anio)),
    forall(otroGanador(Anio,Conductor,OtroConductor), usoUnVehiculoCaro(OtroConductor,Anio)).

otroGanador(Anio,Conductor,OtroConductor):-
    ganoEn(Anio,Conductor),
    ganoEn(Anio,OtroConductor),
    Conductor \= Conductor.

/*
Un vehiculo es caro cuando: 
- Marca cara (toyota, mini, iveco) o tiene 3 suspensiones extras.
- la de las motos son indicadas, los cuatri llevan 4, otros vehiculos no llevan.

*/
marcaCara(toyota).
marcaCara(mini).
marcaCara(iveco).

esCaro(Vehiculo):-
    marca(Vehiculo,Marca),
    marcaCara(Marca).

esCaro(Vehiculo):-
    suspensionesExtra(Vehiculo,Suspension),
    Suspension >= 3.

suspensionesExtra(moto(_,Suspension),Suspension).
suspensionesExtra(cuatri(_),4).

usoUnVehiculoCaro(Conductor,Anio):-
    ganador(Anio,Conductor,Vehiculo),
    esCaro(Vehiculo).

%Punto 6:

etapa(marDelPlata,santaRosa,60).
etapa(santaRosa,sanRafael,290).
etapa(sanRafael,sanJuan,208).
etapa(sanJuan,chilecito,326).
etapa(chilecito,fiambala,177).
etapa(fiambala,copiapo,274).
etapa(copiapo,antofagasta,477).
etapa(antofagasta,iquique,557).
etapa(iquique,arica,377).
etapa(arica,arequipa,478).
etapa(arequipa,nazca,246).
etapa(nazca,pisco,276).
etapa(pisco,lima,29).

%Punto 6.a:

/*
Necesitamos un predicado que permita saber cuántos kilómetros existen entre dos locaciones distintas. 
¡Atención! Debe poder calcularse también entre locaciones que no pertenezcan a la misma etapa. 
Por ejemplo, entre sanRafael y copiapo hay 208+326+177+274 = 985 km

*/

distancia(Inicial,Final,Kilometros):- etapa(Inical,Final,Kilometros).

distancia(Inicial,Final,Kilometros):- 
    etapa(Inical,SiguienteLugar,KilometrajeMomento),
    distancia(SiguienteLugar,Final,KilometrajeRestante),
    Kilometros is KilometrajeMomento + KilometrajeRestante.

