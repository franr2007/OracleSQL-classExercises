SELECT CUSTOMERS.NAME,CUSTOMERS.SURNAME FROM customers
    JOIN SALES ON customers.id_customer=sales.customer 
    JOIN ALBUMS ON albums.id_album=sales.album 
    JOIN ARTISTS ON ARTISTS.ID_ARTIST=ALBUMS.ARTIST 
WHERE ARTISTS.NAME='The Beatles'; --1

SELECT AL.TITLE,AL.PRICE FROM ALBUMS AL WHERE STOCK<10; --2

SELECT G.NAME,G.DESCRIPTION FROM GENRES G WHERE UPPER(G.NAME) LIKE '%ROCK%'; --3

SELECT DISTINCT C.NAME,C.SURNAME, S.TOTAL FROM SALES S 
    JOIN CUSTOMERS C ON s.customer=c.id_customer 
GROUP BY C.NAME,C.SURNAME,S.TOTAL; --4

SELECT AL.TITLE,AL.YEAR FROM ALBUMS AL 
    JOIN GENRES G ON AL.GENRE=G.ID_GENRE 
WHERE UPPER(G.NAME)='POP'; --5

SELECT A.NAME,A.BIOGRAPHY FROM ARTISTS A 
    JOIN ALBUMS AL ON a.id_artist=al.artist 
    JOIN SALES S ON s.album=al.id_album 
GROUP BY A.NAME,A.BIOGRAPHY,AL.title HAVING SUM(s.quantity)>10; --6

SELECT G.NAME, AVG(AL.PRICE) AS PRECIOMEDIO FROM ALBUMS AL 
    JOIN GENRES G ON al.genre=g.id_genre 
GROUP BY G.NAME 
ORDER BY PRECIOMEDIO; --7

SELECT C.NAME, C.SURNAME FROM customers C 
    LEFT JOIN SALES S ON c.id_customer=s.customer 
WHERE S.CUSTOMER IS NULL; --8

SELECT al.title, al.genre FROM ALBUMS AL 
    LEFT JOIN SALES S ON al.id_album=s.album 
WHERE s.album IS NULL; --9

SELECT A.NAME, a.country FROM ARTISTS A 
    LEFT JOIN ALBUMS AL ON a.id_artist=al.artist 
WHERE al.artist IS NULL; --10

SELECT g.name, g.description FROM GENRES G 
    LEFT JOIN ALBUMS AL ON g.id_genre=al.genre 
WHERE al.artist IS NULL; --11



--1: Mostra els noms i llinatges dels clients que hagin comprat algun album dels Beatles

--2: Mostra el nom i el preu dels àlbums amb un estoc inferior a 10

--3: Mostra el nom i la descripció dels gèneres que contenen la praula "rock".

--4: Mostra el total de doblers gastat per cada client.

--5: Mostra el títol i l'any dels àlbums del gènere Pop.

--6: Mostra el nom i la biografia dels artistes que han venut més de 10 àlbums.

--7: Mostra el preu promig dels àlbums per cada gènere, ordenats de menor a major.

--8: Mostra el nom i el cognom dels clients que no han fet cap compra.

--9: Mostra el títol i el gènere dels àlbums que no s'han venut mai.

--10: Mostra el nom i el país dels artistes que no tenen cap àlbum al catàleg de la botiga.

--11: Mostra el nom i la descripció dels gèneres que no tenen cap àlbum al catàleg de la botiga.

--12: Mostra el total d'ingressos obtinguts per les vendes de cada gènere d'àlbum. S'ha de veure el nom del gènere i els seus ingressos. Si un gènere no ha venut res, ha de sortir 0.

--13: Mostra el títol i l'artista (nom) de cada àlbum sense vendes, distingint si l'àlbum és del segle XX o del segle XXI.