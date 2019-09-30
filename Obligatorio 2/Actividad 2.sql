--Consutla 4 GOOD
SELECT titulo, isbn
FROM obras o
WHERE(
    SELECT count(*) > 0
    FROM obra_autor oa2
    WHERE oa2.cod_obra = o.cod_obra
    ) and (
    SELECT count(*)
    from obra_editorial oe
    Where oe.cod_obra = o.cod_obra
    )>(
        SELECT count(*)
        from obra_autor oa
        WHERE oa.cod_obra = o.cod_obra
        );

--Consulta 5 GOOD
SELECT  cod_editorial, nombre_editorial
FROM ( editoriales Natural join  obras NATURAL join obra_editorial) e
WHERE e.edicion ~ '1[^0-9]'
GROUP BY cod_editorial
HAVING count(DISTINCT cod_obra) >= all(
    SELECT count(DISTINCT cod_obra)
    FROM editoriales NATURAL JOIN obras NATURAL JOIN obra_editorial cod_obra
    WHERE edicion ~ '1[^0-9]'
    GROUP BY cod_editorial);




--Consulta 6 GOOD
SELECT cod_obra
FROM (obras NATURAL JOIN obra_autor NATURAL JOIN obra_tema) a
WHERE  a.pais = 'ARG' and  a.cod_funcion = '1' and exists(
    SELECT *
    FROM (obra_tema NATURAL JOIN obra_autor cod_obra) ot
    WHERE ot.cod_obra != a.cod_obra and ot.cod_autor = a.cod_autor and ot.cod_tema = a.cod_tema
    ) and exists(
        SELECT *
        FROM obra_autor
        WHERE a.cod_obra = obra_autor.cod_obra
    ) and (
        SELECT count(distinct obra_autor.cod_autor) = 1
        FROM obra_autor
        WHERE a.cod_obra = obra_autor.cod_obra
    )
GROUP BY cod_obra;