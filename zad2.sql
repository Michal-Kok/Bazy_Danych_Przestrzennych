CREATE DATABASE "Plan"
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1;

COMMENT ON DATABASE "Plan"
    IS 'plan budynkow do zadania z BDP';

-- dodawanie rozszerzenia po uprzednim zainstalowaniu ręcznie, oraz tworzenie tabel

CREATE EXTENSION postgis;

CREATE TABLE budynki(id INT, geometria GEOMETRY, nazwa VARCHAR(30));
CREATE TABLE drogi(id INT, geometria GEOMETRY, nazwa VARCHAR(30));
CREATE TABLE punkty_informacyjne(id INT, geometria GEOMETRY, nazwa VARCHAR(30));

-- wstawianie informacji do tabel

INSERT INTO drogi VALUES (1, ST_GeomFromText('LINESTRING(0 4.5, 12 4.5)', 0), 'RoadX');
INSERT INTO drogi VALUES (2, ST_GeomFromText('LINESTRING(7.5 0, 7.5 10.5)', 0), 'Roady');

INSERT INTO budynki VALUES (1, ST_GeomFromText('POLYGON((3 6, 5 6, 5 8, 3 8, 3 6))', 0), 'BuildingC');
INSERT INTO budynki VALUES (2, ST_GeomFromText('POLYGON((8 1.5, 10.5 1.5, 10.5 4, 8 4, 8 1.5))', 0), 'BuildingA');
INSERT INTO budynki VALUES (3, ST_GeomFromText('POLYGON((4 5, 6 5, 6 7, 4 7, 4 5))', 0), 'BuildingB');
INSERT INTO budynki VALUES (4, ST_GeomFromText('POLYGON((1 1, 2 1, 2 2, 1 2, 1 1))', 0), 'BuildingF');
INSERT INTO budynki VALUES (5, ST_GeomFromText('POLYGON((9 8, 10 8, 10 9, 9 9, 9 8))', 0), 'BuildingD');

INSERT INTO punkty_informacyjne VALUES (1, ST_GeomFromText('POINT(5.5 1.5)', 0), 'H');
INSERT INTO punkty_informacyjne VALUES (2, ST_GeomFromText('POINT(1 3.5)', 0), 'G');
INSERT INTO punkty_informacyjne VALUES (3, ST_GeomFromText('POINT(9.5 6)', 0), 'I');
INSERT INTO punkty_informacyjne VALUES (4, ST_GeomFromText('POINT(6.5 6)', 0), 'J');
INSERT INTO punkty_informacyjne VALUES (5, ST_GeomFromText('POINT(6 9.5)', 0), 'K');

-- wykonywanie poelcen

SELECT SUM(ST_Length(geometria)) AS dlugosc_drog FROM drogi;

SELECT ST_Area(geometria) AS pole_powierzchni, ST_Perimeter(geometria) AS obwod, ST_AsText(geometria) AS WKT 
FROM budynki
WHERE nazwa = 'BuildingA';

SELECT nazwa, ST_Area(geometria) AS pole_powierzchni FROM budynki
ORDER BY nazwa;

SELECT nazwa, ST_Perimeter(geometria) as obwod FROM budynki
ORDER BY ST_Area(geometria) LIMIT 2;

SELECT ST_Distance(budynek.geometria, punkt.geometria) FROM budynki budynek, punkty_informacyjne punkt
WHERE budynek.nazwa = 'BuildingB' AND punkt.nazwa = 'G';

SELECT ST_Area(ST_Difference((SELECT geometria FROM budynki WHERE nazwa = 'BuildingC'), ST_Buffer((SELECT geometria FROM budynki WHERE nazwa = 'BuildingB'),0.5))); 

-- ostatnie zadanie nie chciało mi działać
