SELECT L.titol, g.nom FROM LLIBRE L, llibre_genere LG, genere G WHERE l.id=lg.id_llibre AND g.nom=lg.nom_genere; --1

SELECT l.titol, a.nom || ' ' || a.cognoms AS NOMBREAUTOR FROM LLIBRE L,autor_llibre AL,AUTOR A WHERE l.id=al.id_llibre AND a.id=al.id_autor; --2

SELECT l.titol,g.nom, a.nom || ' ' || a.cognoms AS NOMBREAUTOR FROM LLIBRE L, autor_llibre AL, AUTOR A, llibre_genere LG, genere G WHERE l.id=al.id_llibre AND al.id_autor=a.id AND l.id=lg.id_llibre AND lg.nom_genere=g.nom; --3

SELECT l.titol FROM LLIBRE L,autor_llibre AL, autor A WHERE l.id=al.id_llibre AND a.id=al.id_autor GROUP BY l.titol HAVING COUNT(A.ID)=1; --4

SELECT a.nom || ' ' || a.cognoms AS NOMBRE_AUTOR, SUM(l.exemplars) AS TOTAL_EJEMPLARES FROM LLIBRE L, autor_llibre AL, autor A WHERE l.id=al.id_llibre AND a.id=al.id_autor GROUP BY a.nom,a.cognoms; --5

--Sense JOIN
--1. Llista els llibres (títol) amb el seu gènere (nom).
--Columnes: títol del llibre, nom del gènere

--2. Llista els títols i autor (nom i llinatge) dels llibres d'autors no espanyols.
--Columnes: títol llibre, nom i llinatge autor

--3. Llista els títols, el gènere (nom) i l'autor (nom i llinatges) de cada llibre. (Si un llibre té més d'un autor o gènere, el seu títol sortirà repetit).
--Columnes: títol llibre, nom gènere, nom i llinatges autor

--4. Llista els llibres (títol) amb només un autor.
--Columnes: títol llibre

--5. Llista el nombre d'exemplars totals de cada autor (nom i llinatges).
--Columnes: nom i llinatges autor, número d'exemplars d'entre tots els seus llibres

--Amb JOIN
--6. Llista els autors (nom i llinatges) sense llibres.
--Columnes: nom i llinatges autor

--7. Llista els llibres (títol) amb el seu gènere (nom).
--Columnes: títol llibre, nom gènere

--8. Llista els gèneres (nom) sense llibres.
--Columnes: nom gènere

--9. Llista els títols i autor (nom i llinatge) dels llibres d'autors espanyols.
--Columnes: títol llibre, nom i llinatge autor

--10. Llista els títols, el gènere (nom) i l'autor (nom i llinatges) de cada llibre. (Si un llibre té més d'un autor o gènere, el seu títol sortirà repetit). Mostra només els que tenen autor conegut i gènere.
--Columnes: títol llibre, nom gènere, nom i llinatges autor

--11. Repeteix la consulta anterior, però també han de poder sortir els llibres sense gènere ni autor.
--Columnes: títol llibre, nom gènere, nom i llinatges autor

--12. Llista els llibres (títol) amb més d'un autor.
--Columnes: títol llibre

--13. Llista el nombre d'exemplars totals de l'autor "Federico García Lorca".
--Columnes: número d'exemplars

--14. Llista el nombre d'exemplars totals de cada autor. Si un autor no té cap llibre (i per tant, exemplars), ha de sortir un 0.
--Columnes: nom i llinatges autor, número d'exemplars total

--15. Llista el primer i darrer any en que va treure un llibre cada autor, només d'aquells autors que tenen llibres.
--Columnes: nom i llinatges autor, primer any de llançament d'un llibre, darrer any de llançament d'un llibre