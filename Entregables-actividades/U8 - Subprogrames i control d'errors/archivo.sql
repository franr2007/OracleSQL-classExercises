/*1. Crea una funció GET_LLIBRES_BY_AUTOR_ID que, donat un ID d'autor, retorni una NESTED
TABLE amb records dels llibres d'aquest autor.
Crida aquesta funció des d'un bloc anonim passant-li com a parametre un ID d'autor que tengui
llibres i mostra (DBMS_OUTPUT) els seus títols utilitzant alguna estructura iterativa.
(4 punts)
*/
CREATE OR REPLACE TYPE objecteLlibre AS OBJECT (
  id NUMBER,
  titol VARCHAR2(200)
);
/

CREATE OR REPLACE TYPE tablaNestedLLibre AS TABLE OF objecteLlibre;
/

CREATE OR REPLACE FUNCTION GET_LLIBRES_BY_AUTOR_ID(idAutor NUMBER)
RETURN tablaNestedLLibre
IS
  v_resultat tablaNestedLLibre;
BEGIN
  SELECT objecteLlibre(id, titol)
  BULK COLLECT INTO v_resultat
  FROM LLIBRE L
  JOIN autor_llibre AL ON L.ID=al.id_llibre
  WHERE al.id_autor = idAutor;

  RETURN v_resultat;
END;
/


DECLARE
  v_id_autor NUMBER := 2;
  v_llibres tablaNestedLLibre;
BEGIN
  v_llibres := GET_LLIBRES_BY_AUTOR_ID(v_id_autor);

  FOR i IN 1 .. v_llibres.COUNT LOOP
    DBMS_OUTPUT.PUT_LINE(v_llibres(i).titol);
  END LOOP;
END;
/

/*2. Crea un procedure nested ACTUALITZA_LLIBRE_TITOL que, donat l'ID d'un llibre i un VARCHAR2, 
actualitzi el títol del llibre que té l'ID indicat al varchar2 passat com a paràmetre.
Si el llibre no existeix, el procediment ha de mostrar al DBMS_OUTPUT un missatge indicant que no hi
ha cap llibre amb l'ID passat.
(4 punts)
*/

/*3. Defineix una excepció nova LLIBRE_ID_DESCONEGUT i modifica el procedure anterior perquè, en lloc de
mostrar un missatge al DBMS_OUTPUT quan el llibre no existeix, aixequi l'excepció LLIBRE_ID_DESCONEGUT.
Crida la funció des del bloc anònim utilitzant l'ID d'un llibre inexistent i mostra un missatge al
DBMS_OUTPUT quan ocorri l'excepció que has declarat anteriorment.
(2 punts)
.*/