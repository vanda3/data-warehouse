-- quantos servicos partem do aeroporto
SELECT SUM(Se.Nr_Viagens)
FROM Services Se, Location L, Stand St
WHERE 	Se.LocalI_ID = L.Local_ID 
	AND	L.Stand_ID = St.Stand_ID
	AND St.Nome LIKE 'Sá Carneiro';

-- quantos servicos partem de cada stand
SELECT St.Nome, SUM(Se.Nr_Viagens)
FROM Services Se, Location L, Stand St
WHERE 	Se.LocalI_ID = L.Local_ID 
	AND	L.Stand_ID = St.Stand_ID
GROUP BY 1
ORDER BY 2 DESC;

-- quantos servicos partem de cada freguesia & concelho
SELECT L.Concelho, L.Freguesia, SUM(Se.Nr_Viagens)
FROM Services Se, Location L
WHERE 	Se.LocalI_ID = L.Local_ID 
GROUP BY 1,2
ORDER BY 1,2 ASC;

-- quantos servicos partem de cada freguesia & concelho & stand
SELECT St.Nome, L.Freguesia, L.Concelho, SUM(Se.Nr_Viagens)
FROM Services Se, Location L, Stand St
WHERE 	Se.LocalI_ID = L.Local_ID 
	AND (St.Stand_ID IS NULL OR L.Stand_ID = St.Stand_ID)
GROUP BY 1,2,3
ORDER BY 4 DESC LIMIT 10;

-- quantos servicos comecam stands
SELECT SUM(Se.Nr_Viagens)
FROM Services Se, Location L, Stand St
WHERE 	Se.LocalI_ID = L.Local_ID 
	AND	L.Stand_ID = St.Stand_ID
	AND St.Stansd_ID IS NOT NULL;

-- quantos servicos nao comecam em stands
SELECT SUM(Se.Nr_Viagens)
FROM Services Se, Location L
WHERE 	Se.LocalI_ID = L.Local_ID 
	AND	L.Stand_ID IS NULL;

-- isto devia dar (?) mas podemos smp ver a diferenca
SELECT SUM(Se.Nr_Viagens) - Nr_Viagens_Stands FROM 
Services Se,(SELECT SUM(Se.Nr_Viagens) AS Nr_Viagens_Stands
FROM Services Se, Location L, Stand St
WHERE 	Se.LocalI_ID = L.Local_ID 
	AND	L.Stand_ID = St.Stand_ID
	AND St.Stand_ID IS NOT NULL) AS S
GROUP BY Nr_Viagens_Stands;

-- quantos servicos por mes
SELECT T.Mes, SUM(Se.Nr_Viagens)
FROM Services Se, Tempo T
WHERE	Se.TempoI_ID = T.Tempo_ID
GROUP BY 1
ORDER BY 1 ASC;

-- quantos servicos por hora
SELECT T.Hora, SUM(Se.Nr_Viagens)
FROM Services Se, Tempo T
WHERE	Se.TempoI_ID = T.Tempo_ID
GROUP BY 1
ORDER BY 1 ASC;

-- top 10 rotas preferidas (ids, gostaria de mudar isto para freguesias/concelhos)
SELECT Se.LocalI_ID, Se.LocalF_ID, Sum(Se.Nr_Viagens)
FROM Services Se
GROUP BY 1,2
ORDER BY 3 DESC LIMIT 10;

-- nr de viagens do aeroporto dividido por mês
SELECT 
  Zone,
  State,
  COUNT(Sponsored),
  COUNT(Enrolled),
  COUNT(PickedUp)
FROM MasterData
GROUP BY Zone, StateName
  WITH ROLLUP=
SELECT SUM(Se.Nr_Viagens)
FROM Services Se, Location L, Stand St
WHERE 	Se.LocalI_ID = L.Local_ID 
	AND	L.Stand_ID = St.Stand_ID
	AND St.Nome LIKE 'Sá Carneiro';

select stand.nome as stand, tempo.mes as mes, tempo.dia, sum(nr_viagens) as viagens 
from stand, location, tempo
where location.local_id in (select localf_id from services where locali_id=36)
AND location.stand_id=stand.stand_id
AND stand.stand_id=taxi_stands.id
GROUP BY CUBE stand, mes, dia;


-- Os percursos com mais viagens por mês
select services.locali_id as locali, services.localf_id as localf, tempo.mes, count(services.nr_viagens) as viagens
from services, tempo
where services.tempoi_id=tempo.tempo_id
group by 1,2,3
order by 4 desc;

select count (*) from (select services.locali_id, services.localf_id, tempo.mes
from services, tempo
group by 1,2,3) as s;


select l1.freguesia as FreguesiaInicial, l1.concelho as ConcelhoInicial, l2.freguesia as FreguesiaFinal, l2.concelho as ConcelhoFinal, tempo.mes as Mes
from services, (select services.locali_id from location where )
where services.locali_id=location.local_id
AND 




-- SUPER ROLLUP
SELECT localocation.freguesia as Freguesia, sum(services.nr_viagens),  CAST(AVG(tempo_total) AS INTEGER) AS AVG_Tempo
FROM services, location
where services.locali_id=location.local_id
GROUP BY ROLLUP(concelho, freguesia);


select l1.concelho, l1.freguesia, l2.concelho, l2.freguesia, mes
from



select services.locali_id as locali, services.localf_id as localf, tempo.mes as mes, count(services.nr_viagens) as viagens
from services, tempo
where services.tempoi_id=tempo.tempo_id
group by 1,2,3
order by 4 desc;

