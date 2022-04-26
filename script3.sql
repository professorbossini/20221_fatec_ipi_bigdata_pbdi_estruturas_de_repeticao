-- criar uma tabela (cod_aluno, nota)
CREATE TABLE tb_aluno(
	cod_aluno SERIAL PRIMARY KEY,
	nota INT NOT NULL
);

-- gerando dez valores e inserindo na tabela
DO
$$
BEGIN
	FOR i IN 1..10 LOOP
		INSERT INTO tb_aluno (nota) VALUES(fn_valor_aleatorio_entre(0, 10));
	END LOOP;
END;
$$
--verificando se deu tudo certo até agora
SELECT * FROM tb_aluno; 


-- calculando a média com um FOR
DO
$$
DECLARE
	aluno RECORD;
	media NUMERIC (10, 2) := 0;
	total INT;
BEGIN
	FOR aluno IN
		SELECT * FROM tb_aluno
	LOOP
		RAISE NOTICE 'Nota: %', aluno.nota;
		media := media + aluno.nota;
	END LOOP;
	SELECT COUNT(*) FROM tb_aluno INTO total;
	RAISE NOTICE 'Média: %', media / total;
END;
$$

--FOR EACH
--calculando a soma de valores armazenados em um vetor
DO
$$
DECLARE
	valores INT[] := ARRAY[
		fn_valor_aleatorio_entre(1, 10),
		fn_valor_aleatorio_entre(1, 10),
		fn_valor_aleatorio_entre(1, 10),
		fn_valor_aleatorio_entre(1, 10),
		fn_valor_aleatorio_entre(1, 10)
	];
	valor INT;
	soma INT := 0;
BEGIN
	FOREACH valor IN ARRAY valores LOOP
		RAISE NOTICE 'Valor da vez: %', valor;
		soma := soma + valor;
	END LOOP;
	RAISE NOTICE 'Soma: %', soma;
END;
$$

DO
$$
DECLARE
	vetor INT[] := ARRAY[1, 2, 3];
	matriz INT[] := ARRAY[
		[1, 2, 3],
		[4, 5, 6],
		[7, 8, 9]
	];
	var_aux INT;
	vet_aux INT[];
BEGIN
	--exemplo sem slice, com vetor
	RAISE NOTICE 'SLICE %, vetor', 0;
	FOREACH var_aux IN ARRAY vetor LOOP
		RAISE NOTICE '%', var_aux;
	END LOOP;
	
	--exemplo com slice igual a 1, com vetor
	RAISE NOTICE 'SLICE %, vetor', 1;
	FOREACH vet_aux SLICE 1 IN ARRAY vetor LOOP
		RAISE NOTICE '%', vet_aux;
		-- vamos percorrer o vet_aux
		FOREACH var_aux IN ARRAY vet_aux LOOP
			RAISE NOTICE '%', var_aux;
		END LOOP;
	END LOOP;
	
	--exemplo com slice igual a 0, com matriz
	RAISE NOTICE 'SLICE %, matriz', 0;
	FOREACH var_aux IN ARRAY matriz LOOP
		RAISE NOTICE '%', var_aux;
	END LOOP;
	
	--exemplo com slice igual a 1, com matriz
	RAISE NOTICE 'SLICE 1, matriz';
	FOREACH vet_aux SLICE 1 IN ARRAY matriz LOOP
		RAISE NOTICE '%', vet_aux;
	END LOOP;
	
	--exemplo slice igual a 2, com matriz
	RAISE NOTICE 'SLICE %, matriz', 2;
	FOREACH vet_aux SLICE 2 IN ARRAY matriz LOOP
		RAISE NOTICE '%', vet_aux;
	END LOOP;
END;
$$










