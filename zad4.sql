CREATE TABLE obiekty( nazwa VARCHAR PRIMARY KEY, geom geometry);

INSERT INTO obiekty VALUES('obiekt1',ST_GeomFromText('COMPOUNDCURVE(LINESTRING(0 1,1 1),CIRCULARSTRING(1 1,2 0,3 1), CIRCULARSTRING(3 1,4 2,5 1), LINESTRING(5 1,6 1))',0));

INSERT INTO obiekty VALUES('obiekt2',ST_GeomFromText('MULTICURVE(CIRCULARSTRING(11 2,13 2,11 2),COMPOUNDCURVE(LINESTRING(10 6,14 6),CIRCULARSTRING(14 6,16 4,14 2),CIRCULARSTRING(14 2,12 0, 10 2), LINESTRING(10 2,10 6)))',0));

INSERT INTO obiekty VALUES('obiekt3', ST_MakePolygon('LINESTRING(7 15,12 13, 10 17,7 15)'));

INSERT INTO obiekty VALUES('obiekt4',ST_GeomFromText('LINESTRING(20 20,25 25,27 24,25 22,26 21,22 19,20.5 19.5)',0)));

INSERT INTO obiekty VALUES('obiekt5',ST_GeomFromText('MULTIPOINT(30 30 59,38 32 234)',0)));

INSERT INTO obiekty VALUES('obiekt6', ST_COLLECT('LINESTRING(1 1, 3 2)', 'POINT(4 2)'));


--zad 1

SELECT ST_AREA(ST_BUFFER(ST_ShortestLine(o3.geom, o4.geom),5))
FROM obiekty ob3, obiekty ob4
WHERE o3.nazwa='obiekt3' AND ob4.nazwa='obiekt4'

-- zad2

SELECT ST_AsText(ST_MakePolygon(ST_AddPoint(geom, ST_StartPoint(geom))))
FROM obiekty WHERE nazwa='obiekt4';

-- zad3

INSERT INTO obiekty VALUES ('obiekt7', ST_Collect((SELECT geom FROM obiekty WHERE nazwa='obiekt3'),(SELECT geom FROM obiekty WHERE nazwa='obiekt4')))
SELECT * FROM obiekty WHERE nazwa='obiekt7';

-- zad4

SELECT SUM(ST_AREA(ST_BUFFER(geom,5))) AS Pole Powierzchni FROM obiekty WHERE ST_HASARC(geom)=false ;