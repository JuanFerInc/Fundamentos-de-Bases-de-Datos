--Consulta 1 GOOD
SELECT titulo, edicion,COUNT(DISTINCT cod_tema)
FROM obras o NATURAL JOIN obra_tema
GROUP BY  cod_obra , pais
HAVING count(DISTINCT cod_tema) <=3 and o.pais  = 'URY';


--Consulta 2 GOOD
SELECT cod_autor, nombre_autor
FROM autores a
WHERE not exists(
    SELECT *
    FROM obra_autor
    WHERE a.cod_autor = obra_autor.cod_autor and cod_funcion != '1'
    )and exists(
        SELECT *
        FROM obra_autor
        WHERE cod_autor = a.cod_autor);



--Consulta 3
SELECT nombre_autor
FROM autores a
WHERE NOT exists (SELECT *
	FROM (obras NATURAL JOIN obra_autor) y
	WHERE cod_autor = a.cod_autor and NOT exists(
		SELECT *
		FROM (obra_editorial NATURAL JOIN obras) z
		WHERE cod_obra = y.cod_obra and exists(
			SELECT *
			FROM obra_editorial NATURAL JOIN obras
			WHERE cod_obra = y.cod_obra and cod_editorial != z.cod_editorial
			))
		) and exists (SELECT *
			FROM obra_autor
			WHERE cod_autor = a.cod_autor)

