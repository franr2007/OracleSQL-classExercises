/*1. Crea un procediment standalone update_placa_salari que, donat un codi de placa i un salari, actualitzi el salari de la plaça a l'indicat. (Taula PLACA)
Si el nou salari de la placa suposa una disminució del salari actual que té la plaça indicada, no s'ha de dur a terme l'actualització i s'ha de mostrar un missatge "Salari invàlid".
(2 punts)
*/
CREATE OR REPLACE PROCEDURE update_placa_salari(p_codi_plaza NUMBER, p_salari NUMBER) IS
v_salario_actual NUMBER;
BEGIN
    SELECT SALARI INTO v_salario_actual FROM PLACA WHERE CODI= p_codi_plaza;
    IF (p_salari < v_salario_actual) THEN
    DBMS_OUTPUT.PUT_LINE('SALARIO INVALIDO');
    ELSE
    UPDATE PLACA SET SALARI=p_salari WHERE CODI = p_codi_plaza;
    END IF;
END;
/

/*2. Crea un BLOC ANÒNIM amb una funció (dins el bloc anònim, és a dir, nested) anomenada GET_NOMINES que, donat un NSS d'empleat, retorni una nested table amb records de les nòmines d'aquest empleat. Aquests records han de tenir tota la informació dels registres de la taula NOMINA.
Per exemple, si es crida la funció amb un NSS 111111111111, la funció ha de retornar una nested table amb totes les nòmines d'aquest empleat.
Declara els tipus necessaris dins el bloc anònim. (2,5 punts)
2.1. Crida la funció amb un NSS existent i imprimeix la data de pagament i l'import de totes les seves nòmines. (1 punt).
2.2. Declara una excepció EMPLEAT_INEXISTENT que s'aixequi si l'empleat indicat no existeix i gestiona-la al bloc anònim des d'on crides la funció mostrant un missatge. (1 punt)
2.3. Aseegura't que davant qualsevol altre excepció és mostri un missatge "Error desconegut". (0,5 punts)
*/

DECLARE
    TYPE t_nomina IS TABLE OF NOMINA%ROWTYPE;
    v_nomina t_nomina;

    v_resultado t_nomina;

    EMPLEAT_INEXISTENT EXCEPTION;

    FUNCTION GET_NOMINES(p_nss_empleat NUMBER) RETURN t_nomina IS
    v_record t_nomina;
    BEGIN
        SELECT * BULK COLLECT INTO v_record FROM NOMINA WHERE NSS_EMPLEAT= p_nss_empleat;
        RETURN v_record;

        EXCEPTION
        WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: L EMPLEAT NO EXSISTEIX');
        RAISE EMPLEAT_INEXISTENT;
        WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR DESCONEGUT');
        RAISE EMPLEAT_INEXISTENT;
    END GET_NOMINES;
BEGIN
    v_resultado := GET_NOMINES(111111111111);
    FOR I IN 1 .. v_resultado.COUNT LOOP
    DBMS_OUTPUT.PUT_LINE('DATA_PAGAMENT: '||v_resultado(I).DATA_PAGAMENT||' IMPORT: '|| v_resultado(I).IMPORT);
    END LOOP;
END;
/

/*3. Crea una funció anomenada get_nom_placa_supervisora_maxima que, donat un codi de placa, retorni el nom de la plaça supervisora de nivell més alt, 
que no té per què ser la supervisora immediata.
Per exemple, la plaça amb ID 3 és supervisada per la 2, però com que la 2 és supervisada per la 1 s'hauria de retornar el nom de la 1.
Si s'indica un codi de plaça sense supervisora com a paràmetre, s'ha de retornar el nom d'aquesta.
No vos preocupeu de control d'errors, basta funcioni amb un codi de plaça existent.
COMPROVACIÓ: Qualsevol codi de plaça vàlid que li poseu vos hauria de retornar "Cap Direccio"
(3 punts)
*/

DECLARE
    v_resultado VARCHAR2(50);

    FUNCTION get_nom_plaza_supervisora_maxima(p_codi_plaza NUMBER) RETURN VARCHAR2 IS
        v_nom_plaza VARCHAR2(50);
        v_codi_plaza_super NUMBER;
    BEGIN
        SELECT CODI_PLACA_SUPERVISORA INTO  v_codi_plaza_super FROM PLACA WHERE CODI= p_codi_plaza;
        FOR I IN 0 .. p_codi_plaza LOOP
        IF v_codi_plaza_super = NULL THEN v_codi_plaza_super:= 0;
        END IF;

        CASE
            WHEN v_codi_plaza_super = 0 
            THEN SELECT NOM INTO v_nom_plaza FROM PLACA WHERE CODI_PLACA_SUPERVISORA=null;
            ELSE v_codi_plaza_super:= v_codi_plaza_super-1;
            END CASE;
        END LOOP;
        RETURN v_nom_plaza;

    END get_nom_plaza_supervisora_maxima;
BEGIN
    v_resultado:=get_nom_plaza_supervisora_maxima(0);
    DBMS_OUTPUT.PUT_LINE(v_resultado);
END;
/