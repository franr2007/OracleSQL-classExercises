--Sense JOIN
--1. Llista els llibres (títol) amb el seu gènere (nom).
--Columnes: títol del llibre, nom del gènere
SELECT L.titol, g.nom 
FROM LLIBRE L, llibre_genere LG, genere G 
WHERE l.id=lg.id_llibre AND g.nom=lg.nom_genere; --1

--2. Llista els títols i autor (nom i llinatge) dels llibres d'autors no espanyols.
--Columnes: títol llibre, nom i llinatge autor
SELECT l.titol, a.nom || ' ' || a.cognoms AS NOMBREAUTOR 
FROM LLIBRE L,autor_llibre AL,AUTOR A 
WHERE l.id=al.id_llibre AND a.id=al.id_autor; --2

--3. Llista els títols, el gènere (nom) i l'autor (nom i llinatges) de cada llibre. (Si un llibre té més d'un autor o gènere, el seu títol sortirà repetit).
--Columnes: títol llibre, nom gènere, nom i llinatges autor
SELECT l.titol,g.nom, a.nom || ' ' || a.cognoms AS NOMBREAUTOR 
FROM LLIBRE L, autor_llibre AL, AUTOR A, llibre_genere LG, genere G 
WHERE l.id=al.id_llibre AND al.id_autor=a.id AND l.id=lg.id_llibre AND lg.nom_genere=g.nom; --3

--4. Llista els llibres (títol) amb només un autor.
--Columnes: títol llibre
SELECT l.titol 
FROM LLIBRE L,autor_llibre AL, autor A 
WHERE l.id=al.id_llibre AND a.id=al.id_autor 
GROUP BY l.titol HAVING COUNT(A.ID)=1; --4

--5. Llista el nombre d'exemplars totals de cada autor (nom i llinatges).
--Columnes: nom i llinatges autor, número d'exemplars d'entre tots els seus llibres
SELECT a.nom || ' ' || a.cognoms AS NOMBRE_AUTOR, SUM(l.exemplars) AS TOTAL_EJEMPLARES 
FROM LLIBRE L, autor_llibre AL, autor A 
WHERE l.id=al.id_llibre AND a.id=al.id_autor 
GROUP BY a.nom,a.cognoms; --5

--Amb JOIN
--6. Llista els autors (nom i llinatges) sense llibres.
--Columnes: nom i llinatges autor
SELECT A.NOM, A.COGNOMS 
FROM AUTOR A 
LEFT JOIN AUTOR_LLIBRE AL ON A.ID = AL.ID_AUTOR 
WHERE AL.ID_LLIBRE IS NULL;

--7. Llista els llibres (títol) amb el seu gènere (nom).
--Columnes: títol llibre, nom gènere
SELECT L.TITOL, G.NOM 
FROM LLIBRE L 
JOIN LLIBRE_GENERE LG ON L.ID = LG.ID_LLIBRE 
JOIN GENERE G ON G.NOM = LG.NOM_GENERE;

--8. Llista els gèneres (nom) sense llibres.
--Columnes: nom gènere
SELECT G.NOM 
FROM GENERE G 
LEFT JOIN LLIBRE_GENERE LG ON G.NOM = LG.NOM_GENERE 
WHERE LG.ID_LLIBRE IS NULL;

--9. Llista els títols i autor (nom i llinatge) dels llibres d'autors espanyols.
--Columnes: títol llibre, nom i llinatge autor
SELECT L.TITOL, A.NOM, A.COGNOMS 
FROM LLIBRE L 
JOIN AUTOR_LLIBRE AL ON L.ID = AL.ID_LLIBRE 
JOIN AUTOR A ON A.ID = AL.ID_AUTOR 
WHERE UPPER(A.NACIONALITAT) = 'ESP';

--10. Llista els títols, el gènere (nom) i l'autor (nom i llinatges) de cada llibre. (Si un llibre té més d'un autor o gènere, el seu títol sortirà repetit). Mostra només els que tenen autor conegut i gènere.
--Columnes: títol llibre, nom gènere, nom i llinatges autor
SELECT L.TITOL, G.NOM, A.NOM, A.COGNOMS 
FROM LLIBRE L 
JOIN AUTOR_LLIBRE AL ON L.ID = AL.ID_LLIBRE 
JOIN AUTOR A ON A.ID = AL.ID_AUTOR 
JOIN LLIBRE_GENERE LG ON L.ID = LG.ID_LLIBRE 
JOIN GENERE G ON G.NOM = LG.NOM_GENERE;

--11. Repeteix la consulta anterior, però també han de poder sortir els llibres sense gènere ni autor.
--Columnes: títol llibre, nom gènere, nom i llinatges autor
SELECT L.TITOL, G.NOM, A.NOM, A.COGNOMS 
FROM LLIBRE L 
LEFT JOIN AUTOR_LLIBRE AL ON L.ID = AL.ID_LLIBRE 
LEFT JOIN AUTOR A ON A.ID = AL.ID_AUTOR 
LEFT JOIN LLIBRE_GENERE LG ON L.ID = LG.ID_LLIBRE 
LEFT JOIN GENERE G ON G.NOM = LG.NOM_GENERE;

--12. Llista els llibres (títol) amb més d'un autor.
--Columnes: títol llibre
SELECT L.TITOL 
FROM LLIBRE L 
JOIN AUTOR_LLIBRE AL ON L.ID = AL.ID_LLIBRE 
GROUP BY L.TITOL 
HAVING COUNT(AL.ID_AUTOR) > 1;

--13. Llista el nombre d'exemplars totals de l'autor "Federico García Lorca".
--Columnes: número d'exemplars
SELECT SUM(L.EXEMPLARS) 
FROM LLIBRE L 
JOIN AUTOR_LLIBRE AL ON L.ID = AL.ID_LLIBRE 
JOIN AUTOR A ON A.ID = AL.ID_AUTOR 
WHERE A.NOM = 'Federico' AND A.COGNOMS = 'García Lorca';

--14. Llista el nombre d'exemplars totals de cada autor. Si un autor no té cap llibre (i per tant, exemplars), ha de sortir un 0.
--Columnes: nom i llinatges autor, número d'exemplars total
SELECT A.NOM, A.COGNOMS, NVL(SUM(L.EXEMPLARS), 0)
FROM AUTOR A
LEFT JOIN AUTOR_LLIBRE AL ON A.ID = AL.ID_AUTOR
LEFT JOIN LLIBRE L ON L.ID = AL.ID_LLIBRE
GROUP BY A.NOM, A.COGNOMS;

--15. Llista el primer i darrer any en que va treure un llibre cada autor, només d'aquells autors que tenen llibres.
--Columnes: nom i llinatges autor, primer any de llançament d'un llibre, darrer any de llançament d'un llibre
SELECT A.NOM, A.COGNOMS, MIN(L.AN) AS PrimerLlancament, MAX(L.AN) AS DarrerLlancament 
FROM AUTOR A 
JOIN AUTOR_LLIBRE AL ON A.ID = AL.ID_AUTOR 
JOIN LLIBRE L ON L.ID = AL.ID_LLIBRE
GROUP BY A.NOM, A.COGNOMS;