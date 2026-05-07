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
        WHERE ID= p_ids(id);

    v_suma := v_suma + v_credito;
    END LOOP;
    

END;
/