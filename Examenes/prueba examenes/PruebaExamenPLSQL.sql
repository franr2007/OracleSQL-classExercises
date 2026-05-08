--Actividades examen

--actividad1
DECLARE
    TYPE t_ids_array IS VARRAY(10) OF NUMBER;
    v_id_assignatura t_ids_array := t_ids_array(8,9,10);

    v_total_credits NUMBER;

    ASSIGNATURA_INVALIDA EXCEPTION;

    FUNCTION total_credits(p_ids t_ids_array) RETURN NUMBER IS
    v_suma NUMBER := 0;
    v_credito NUMBER;
BEGIN   
    FOR I IN 1..p_ids.COUNT LOOP
        SELECT CREDITS_ECTS
        INTO v_credito
        FROM ASSIGNATURA
        WHERE ID= p_ids(I);

    v_suma := v_suma + v_credito;
    END LOOP;
    
    RETURN v_suma;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE ASSIGNATURA_INVALIDA;
END total_credits;


BEGIN
    v_total_credits:=total_credits(v_id_assignatura);
    DBMS_OUTPUT.PUT_lINE('TOTAL CREDITOS:'|| v_total_credits);
    EXCEPTION 
    WHEN ASSIGNATURA_INVALIDA THEN
    DBMS_OUTPUT.PUT_lINE('ERROR ID NO ENCONTRADO');
END;
/

--ACTIVIDAD2

DECLARE
    TYPE t_llista_asig IS TABLE OF ASSIGNATURA%ROWTYPE;
    v_resultado t_llista_asig;

    FUNCTION get_assignatures_by_grau(p_id_grau t_llista_asig) RETURN t_llista_asig IS
        v_taula_retorn t_llista_asig;
    BEGIN
        SELECT *
        BULK COLLECT INTO v_taula_retorn
        FROM ASSIGNATURA
        WHERE ID_GRAU= p_id_grau;
        
        RETURN v_taula_retorn;
    END get_assignatures_by_grau;

BEGIN
    -- Guardamos el resultado de la función en nuestra variable
    v_resultado := get_assignatures_by_grau(8);

    -- Recorremos la lista para imprimir el nombre de cada asignatura
    FOR i IN 1 .. v_resultado.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('- ' || v_resultado(i).nom);
    END LOOP;
END;
/