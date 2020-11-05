CREATE EXTENSION postgis;

-- zadanie 4.

CREATE TABLE tableB AS 
SELECT ST_Intersection(popp.geom, ST_Buffer(majrivers.geom, 100000.0)) AS budynki100 FROM popp , majrivers
WHERE popp.f_codedesc='Building';

-- zadanie 5

CREATE TABLE airportsNew AS
SELECT name, geom, elev FROM airports;
SELECT * FROM airportsNew;

-- podpunkt: najbardziej na zachód, najbardziej na wschód

SELECT name, ST_AsText(geom), ST_X(geom) AS naj_zachod FROM airportsNew
ORDER BY naj_zachod LIMIT 1;
SELECT name, ST_AsText(geom), ST_X(geom) AS naj_wschod FROM airportsNew
ORDER BY naj_wschod DESC LIMIT 1;

-- podpunkt: dodaj lotnisko...

INSERT INTO airportsNew VALUES ('airportB',(SELECT ST_Centroid (ST_Union((SELECT geom FROM airportsNew WHERE st_y(geom) IN (SELECT MIN(st_y(geom)) FROM airportsNew)),(SELECT geom FROM airportsNew WHERE st_y(geom) IN (SELECT MAX(st_y(geom)) FROM airportsNew))))), 0.0);

-- zadanie 6

SELECT ST_AREA(ST_BUFFER((ST_SHORTESTLINE((SELECT lakes.geom FROM lakes WHERE lakes.names='Iliamna Lake'),
(SELECT airports.geom FROM airports WHERE airports.name='AMBLER'))),1000)) as pole_powoerzchni FROM  airports, lakes;