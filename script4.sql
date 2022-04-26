DO
$$
BEGIN
	RAISE NOTICE 'oi';
	BEGIN
		RAISE NOTICE '%', 1 / 1;
	EXCEPTION
		WHEN division_by_zero THEN
			RAISE NOTICE 'Não vai dar para dividir por zero';
	END;	
	RAISE NOTICE 'Até mais...';
END;
$$


DO
$$
DECLARE
	a INT := fn_valor_aleatorio_entre(0, 5);
BEGIN
	IF a = 0 THEN
		RAISE 'a não pode ser zero';
	ELSE
		RAISE NOTICE 'Valor de a: %', a;
	END IF;

EXCEPTION WHEN OTHERS THEN
	-- SQLSTATE é o código da exceção
	-- SQLERRM é a mensagem
	RAISE NOTICE 'Exceção: %, %', SQLSTATE, SQLERRM;
END;
$$

