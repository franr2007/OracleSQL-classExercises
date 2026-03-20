--1. Obtén les dades de l'investigador que cobra més.
--Columnes: totes les d'investigador
SELECT * FROM INVESTIGADOR 
ORDER BY SALARI_MENSUAL DESC 
FETCH FIRST 1 ROW ONLY ;

--2.Obtén el nom complet i el salari dels investigadors amb nom acabat per "a" i primer llinatge acabat per "z". Ordena els resultats per salari, de més a menys.
--Columnes: nom complet, salari
--Ordenació: salari, de més a menys
SELECT I.NOM ||' '||I.llinatge1||' '|| I.llinatge2 AS NOM_COMPLET,I.SALARI_MENSUAL FROM INVESTIGADOR I 
WHERE UPPER(I.NOM) LIKE '%A' 
AND UPPER(I.llinatge1) LIKE '%Z' 
ORDER BY I.salari_mensual DESC;

--3. Obtén el NIF de proveïdor, la descripció i la data de recepció de les 3 factures rebudes més recentment.
--Columnes: NIF proveïdor, descripció factura.
SELECT P.NIF,f.descripcio FROM PROVEIDOR P 
JOIN FACTURA F ON P.NIF=f.nif_proveidor 
ORDER BY f.data_recepcio DESC 
FETCH FIRST 3 ROWS ONLY ;

--4. Calcula el salari promig dels investigadors segons la seva especialitat, ordenant per salari promig de menys a més.
--Columnes: especialitat, salari promig
--Ordenació: salari promig, de menys a més
SELECT I.especialitat ,AVG(I.salari_mensual)AS MEDIA_SALARIO FROM INVESTIGADOR I 
GROUP BY I.especialitat 
ORDER BY MEDIA_SALARIO;

--5. Obtén el DNI, nom i llinatges d'aquells investigadors que NO són responsables de cap projecte.
--Columnes: DNI, nom, llinatges
SELECT I.DNI, I.NOM, I.llinatge1|| ' '||I.llinatge2 AS APELLIDOS FROM INVESTIGADOR I 
LEFT JOIN PROJECTE P ON I.DNI=p.dni_responsable 
WHERE p.dni_responsable IS NULL;

--6. Obtén els ingressos obtinguts (imports base de les seves factures) per cada proveidor (nom), però només si el proveïdor ha ingressat 500 euros o més.
--Columnes: nom proveïdor, total ingressos
--Ordenació: total ingressos, de més a menys
SELECT P.nom, SUM(f.import_base) AS TOTAL_INGRESSOS FROM PROVEIDOR P 
JOIN FACTURA F ON P.NIF=f.nif_proveidor 
WHERE f.import_base > 500 
GROUP BY P.NOM 
ORDER BY TOTAL_INGRESSOS DESC ;

--7. Obtén el total d'IVA pagat per cada projecte (referència). Si algun projecte no té factures, ha d'aparèixer un 0. 
--Columnes: referència del projecte, IVA pagat. 
SELECT P.referencia, NVL(SUM(f.import_iva),0)AS TOTAL_IVA FROM PROJECTE P 
LEFT JOIN FACTURA F ON p.codi=f.codi_projecte 
GROUP BY p.referencia 
ORDER BY TOTAL_IVA DESC;

--8. Obtén una llista d'investigadors (dni i nom complet) amb els projectes en que participen (referència i descripció) i la proporció de participació entre projecte i investigador. Ordena per proporció descendent i, en cas d'haver-n'hi d'iguals, per nom complet de manera alfabètica.
--Només hi han de sortir els investigadors que participen en algun projecte. 
--La proporció de participació és el percentatge de participació però expressat entre 0 (0%) i 1 (100%)
--Ordenació: proporció descendent, nom complet alfabèticament
SELECT I.DNI,I.NOM||' '||I.llinatge1||' '||I.llinatge2 AS NOM_COMPLET, p.referencia ,p.descripcio, MIN(pt.percentatge) AS PROPORCIO FROM INVESTIGADOR I 
JOIN PROJECTE P ON I.DNI=p.dni_responsable 
JOIN PARTICIPACIO PT ON pt.codi_projecte=p.codi
GROUP BY I.DNI,I.NOM,I.llinatge1,I.llinatge2 , p.referencia ,p.descripcio
ORDER BY PROPORCIO DESC, NOM_COMPLET;

--9.Obtén el nom, llinatges i àrea d'especialització dels investigadors que participen en qualsevol projecte que tengui factures. NO PODEN SORTIR INVESTIGADORS REPETITS.
--L'àrea d'especialització es calcula segons l'especialitat i pot ser: Ciències (Física i Biologia), Salut (Medicina i Infermeria) i Tecnologia (Informàtica).
--Columnes: nom investigador, llinatges investigador, àrea d'especialització
SELECT DISTINCT I.NOM, I.llinatge1||' '||I.llinatge2 AS APELLIDOS, I.especialitat FROM investigador I 
JOIN PARTICIPACIO PT ON I.DNI=pt.dni_investigador 
JOIN projecte P ON pt.codi_projecte=p.codi
JOIN FACTURA F ON f.codi_projecte=p.codi;

--10.Obtén un llistat amb el cost de cada projecte (suma dels imports base i iva de les factures) que tengui factures i de cada investigador (cost anual en base al salari mensual) que participi a algun projecte.
--Columnes: tipus (Investigador o Projecte), identificador (DNI investigador o referència projecte) i cost (sou mensual extrapolat a tot l'any o import total factures).
--Ordenació: cost descendent.
SELECT CASE
            WHEN P.codi=1 THEN 'PROJECTE'
            WHEN P.codi=2 THEN 'PROJECTE'
            WHEN P.codi=3 THEN 'PROJECTE'
            WHEN P.codi=4 THEN 'PROJECTE'
            END AS TIPUS,
            P.referencia AS IDENTIFICADOR,
            SUM(f.import_base)+SUM(f.import_iva) AS COST
FROM PROJECTE P JOIN FACTURA F ON P.CODI=F.CODI_PROJECTE GROUP BY P.CODI,p.referencia ORDER BY COST DESC
UNION
SELECT CASE
            WHEN I.DNI='11111111A' THEN 'INVESTIGADOR'
            WHEN I.DNI='22222222B' THEN 'INVESTIGADOR'
            WHEN I.DNI='33333333C' THEN 'INVESTIGADOR'
            WHEN I.DNI='44444444D' THEN 'INVESTIGADOR'
            WHEN I.DNI='55555555E' THEN 'INVESTIGADOR'
            END AS TIPUS,
            i.dni AS IDENTIFICADOR,
            SUM(i.salari_mensual)*12 AS COST
FROM investigador I  GROUP BY I.DNI ORDER BY COST;