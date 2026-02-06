SELECT EDITORIAL, COUNT(*) AS recompte FROM LLIBRES GROUP BY EDITORIAL;--1

SELECT EDITORIAL, COUNT(*) AS recompte FROM LLIBRES GROUP BY EDITORIAL HAVING COUNT(*)>5;--2

SELECT EDITORIAL, AVG(PREU) AS precioMedio FROM LLIBRES GROUP BY EDITORIAL ORDER BY precioMedio DESC; --3

SELECT EDITORIAL, AVG(preu) AS precioMedio FROM LLIBRES GROUP BY EDITORIAL HAVING AVG(PREU)>25 ORDER BY editorial; --4

SELECT EDITORIAL, COUNT(*) FROM LLIBRES WHERE EDITORIAL NOT IN('Planeta') GROUP BY EDITORIAL ; --5

SELECT EDITORIAL, COUNT(*) FROM LLIBRES WHERE EDITORIAL NOT IN('Planeta') AND PREU IS NOT NULL GROUP BY EDITORIAL ; --6

SELECT EDITORIAL, AVG(PREU) AS precioMedio FROM LLIBRES GROUP BY EDITORIAL HAVING COUNT(*)>2; --7

SELECT EDITORIAL, MAX(PREU) AS precioMasAlto FROM LLIBRES GROUP BY EDITORIAL ORDER BY precioMasAlto DESC; --8

-- 1. Llistar la quantitat de llibres agrupats per editorial:
-- Columnes: Editorial, recompte llibres

-- 2. Llistar la quantitat de llibres agrupats per editorial, però només els grups editorials que tenen més de quatre llibres:
-- Columnes: Editorial, recompte llibres

-- 3. Llistar la mitjana dels preus dels llibres agrupats per editorial i ordenats per preu descendent:
-- Columnes: editorial, preu mitjà

-- 4. Llistar la mitjana dels preus dels llibres agrupats per editorial, però només aquells la mitjana dels quals superi els 25 euros:
-- Columnes: editorial, preu mitjà

-- 5. Llistar nombre de llibres agrupats per editorial sense tenir en compte l'editorial "Planeta":
-- Columnes: editorial, recompte llibres

-- 6. Llistar nombre de llibres agrupats per editorial sense tenir en compte l'editorial "Planeta" ni els llibres amb preu nul:
-- Columnes: editorial, recompte llibres

-- 7. Llistar mitjana dels preus agrupats per editorial d'aquelles editorials que tenen més de 2 llibres:
-- Columnes: editorial, preu mitjà

-- 8. Llistar el preu més gran d'un llibre per editorial i ordenat per preu descendent:
-- Columnes: editorial, preu més car

-- 9. Llistar el preu més gran d'un llibre per editorial d'aquelles que tinguin, almenys, un llibre que superi els 30 euros:
-- Columnes: editorial, preu més car

-- 10. Llistar el títol i l'autor dels llibres amb títol que comenci per la lletra "M" i l'autor dels quals contingui la lletra "H", independent de majúscula/minúscula:
-- Columnes: títol, autor

-- 11. Llistar la quantitat de llibres agrupats per autor, ordenat per quantitat descendent:
-- Columnes: autor, quantitat llibres

-- 12. Llista les diferents lletres inicials dels titols dels llibres i el preu promig dels llibres amb un títol que comenci per aquesta lletra. Ordena per preu ascendent:
-- Columnes: Lletra inicial títol, preu mitjà