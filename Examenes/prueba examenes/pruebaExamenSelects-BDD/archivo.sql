--1. Retorna les dades (totes) de la nota més alta.
SELECT * FROM NOTA ORDER BY NOTA DESC FETCH FIRST ROW ONLY;

--2. Retorna el DNI i el correu electrònic dels alumnes amb un nom que acabi per "ra" i amb un primer llinatge que comenci per "Mar” , ordenant per DNI ascendent.
--Columnes: DNI, correu electrònic
--Ordenació: DNI ascendent
SELECT A.DNI, A.EMAIL FROM alumne A WHERE UPPER(A.NOM) LIKE '%RA' AND UPPER(A.LLINATGE1) LIKE 'MAR%' ORDER BY DNI;

--3. Retorna el DNI i el nom complet (nom i llinatges) del professor que cobra MÉS.
--Columnes: DNI, nom complet
SELECT DNI, NOM || ' ' || LLINATGE1 || ' ' || LLINATGE2 AS NOMBRECOMPLETO FROM PROFESSOR WHERE SALARI =(SELECT MAX(SALARI) FROM professor);

--4. Retorna la mitjana de notes per ID d'assignatura ordenant per nota promig descendent.
--Columnes: ID d'assignatura, nota mitjana
--Ordenació: nota mitjana descendent
SELECT id_assignatura, AVG(NOTA)AS MEDIANOTAS FROM NOTA GROUP BY id_assignatura ORDER BY AVG(NOTA) DESC;

--5. Retorna informació de les notes (DNI alumne, convocatòria, nota) de l'assignatura "Estructura de computadors".
--Columnes: DNI alumne, convocatòria, nota
SELECT N.DNI_ALUMNE,N.CONVOCATORIA,N.NOTA FROM NOTA N JOIN ASSIGNATURA A ON A.ID=n.id_assignatura WHERE UPPER(a.nom)= 'ESTRUCTURA DE COMPUTADORS';

--6. Retorna les dades dels alumnes (NOMÉS dels alumnes) que NO tenen cap nota, ordenant els resultats alfabèticament seguint la següent prioritat: primer llinatge, segon llinatge, nom.
--Columnes: totes les d'alumnes
--Ordenació: alfabèticament segons la prioritat indicada: 1r llinatge, 2n llinatge, nom
SELECT * FROM ALUMNE A LEFT JOIN NOTA N ON A.DNI=n.dni_alumne WHERE n.nota IS NULL ORDER BY a.llinatge1 ,a.llinatge2 ,a.nom;

--7. Retorna el nombre d'assignatures per cada grau (nom), ordenant pel nombre d'assignatures, del grau que en té més al que en té menys.
--Columnes: Nom grau, nombre d'assignatures
--Ordenació: Nombre d'assignatures, de més a menys
SELECT g.nom,COUNT(A.ID) AS RECOMPTEASSIG FROM ASSIGNATURA A JOIN GRAU G ON G.ID=a.id_grau GROUP BY g.nom ORDER BY RECOMPTEASSIG DESC;

--8. Retorna informació de totes les notes (dni alumne, convocatòria, nota) juntament amb la informació de l'assignatura (nom, pla) i grau (nom) corresponent.
--Columnes: DNI alumne, any de convocatòria, nota, nom de l'assignatura, pla de l'assignatura, nom del grau.
SELECT n.dni_alumne,n.convocatoria,n.nota,a.nom,a.pla,g.nom FROM NOTA N JOIN assignatura A ON n.id_assignatura=a.id JOIN GRAU G ON a.id_grau=g.id;

--9. Retorna la nota mitjana de cada assignatura del grau "Informàtica", ordenant de menys nota a més.
--Columnes: nom de l'assignatura, nota mitjana
--Ordenació: nota mitjana, de menys a més
SELECT A.NOM, AVG(N.NOTA) AS MEDIA FROM NOTA N JOIN ASSIGNATURA A ON n.id_assignatura=a.id JOIN GRAU G ON a.id_grau=g.id WHERE UPPER(g.nom)='INFORMÀTICA' GROUP BY A.NOM ORDER BY MEDIA;

--10.Retorna el salari combinat (sumat) de dels professors de cada grau. Si un grau no té assignatures o professors assignats a les seves assignatures, ha de sortir un 0.
--Columnes: Nom grau, salari total professors
SELECT G.NOM, NVL(SUM(P.SALARI),0)AS SALARIOTOTAL FROM PROFESSOR P RIGHT JOIN assignatura A ON p.dni=a.dni_professor RIGHT JOIN GRAU G ON a.id_grau=g.id GROUP BY G.NOM ORDER BY SALARIOTOTAL DESC;