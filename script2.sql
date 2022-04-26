CREATE OR REPLACE FUNCTION fn_valor_aleatorio_entre (lim_inferior INT, lim_superior INT) RETURNS INT AS
$$
BEGIN
	RETURN FLOOR(RANDOM() * (lim_superior - lim_inferior + 1) + lim_inferior)::INT;
END;
$$ LANGUAGE plpgsql;

SELECT fn_valor_aleatorio_entre (1, 10);

DO
$$
BEGIN
	LOOP
		RAISE NOTICE 'Teste loop simples...';
	END LOOP;
END;
$$

DO
$$
DECLARE
	contador INT := 1;
BEGIN
	LOOP
		RAISE NOTICE '%', contador;
		contador := contador + 1;
		IF contador > 10 THEN
			EXIT;
		END IF;
	END LOOP;
END;
$$

DO
$$
DECLARE
	contador INT := 0;
BEGIN
	LOOP
		contador := contador + 1;
		EXIT WHEN contador > 100;
		IF contador % 7 = 0 THEN
			CONTINUE;
		END IF;
		
		CONTINUE WHEN contador % 11 = 0;
		
		RAISE NOTICE '%', contador;
	END LOOP;
END;
$$

DO
$$
DECLARE
	i INT;
	j INT;
BEGIN
	i := 0;
	<<externo>>
	LOOP
		i := i + 1;
		EXIT WHEN i > 10;
		j := 1;
		<<interno>>
		LOOP
			RAISE NOTICE '% %', i, j;
			j := j + 1;
			EXIT WHEN j > 10;
			EXIT externo WHEN j > 5;
		END LOOP;	
	END LOOP;
END;
$$

DO
$$
DECLARE
	i INT;
	j INT;
BEGIN
	i := 0;
	<<externo>>
	LOOP
		i := i + 1;
		EXIT WHEN i > 10;
		j := 1;
		<<interno>>
		LOOP
			RAISE NOTICE '% %', i, j;
			j := j + 1;
			EXIT WHEN j > 10;
			CONTINUE externo WHEN j > 5;
		END LOOP;
	END LOOP;
END;
$$

DO
$$
DECLARE
	nota INT;
	media NUMERIC(10, 2) := 0;
	contador INT := 0;
BEGIN
	SELECT fn_valor_aleatorio_entre(0, 11) - 1 INTO nota;
	WHILE nota >= 0 LOOP
		RAISE NOTICE '%', nota;
		media := media + nota;
		contador := contador + 1;
		SELECT fn_valor_aleatorio_entre(0, 11) - 1 INTO nota;
	END LOOP;
	IF contador > 0 THEN
		RAISE NOTICE 'Média %.', media / contador;	
	ELSE
		RAISE NOTICE 'Nenhuma nota gerada.';
	END IF;
END;
$$

DO
$$
BEGIN
	RAISE NOTICE 'de 1 a 10, pulando de um em um';
	FOR i IN 1..10 LOOP
		RAISE NOTICE '%', i;
	END LOOP;
	
	RAISE NOTICE 'E agora?';
	FOR i IN 10..1 LOOP
		RAISE NOTICE '%', i;
	END LOOP;
	
	RAISE NOTICE 'De 10 a 1, pulando de um em um';
	FOR i IN REVERSE 10..1 LOOP
		RAISE NOTICE '%', i;
	END LOOP;
	
	RAISE NOTICE 'De 1 a 50, pulando de dois em dois';
	FOR i IN 1..50 BY 2 LOOP
		RAISE NOTICE '%', i;
	END LOOP;
	
	RAISE NOTICE 'De 1 a 5, pulando de três em três';
	FOR i IN 1..5 BY 3 LOOP
		RAISE NOTICE '%', i;
	END LOOP;
	
	RAISE NOTICE 'De 10 a 1, pulando de 3 em 3';
	FOR i IN REVERSE 10..1 BY 3 LOOP
		RAISE NOTICE '%', i;
	END LOOP;
END;
$$







