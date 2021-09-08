-- CREATE TABLE coordinate(
--     id INTEGER PRIMARY KEY,
--     lat INTEGER ,
--     long INTEGER,
--     walbable BOOLEAN

-- );

-- CREATE TABLE street(
--     id INTEGER PRIMARY KEY,
--     startP INTEGER REFERENCES coordinate (id),
--     endP INTEGER REFERENCES coordinate (id)
-- );



CREATE OR REPLACE FUNCTION addtrapped()
RETURNS TRIGGER AS
$$
DECLARE
total integer;
BEGIN 


IF (SELECT walbable FROM coordinate WHERE id= NEW.startp) THEN
    RAISE NOTICE ' Walkable';
ELSE
    RAISE NOTICE 'NOt Walkable';
END IF;

RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';



CREATE TRIGGER ckech_walkable
BEFORE INSERT OR UPDATE
ON street
EXECUTE PROCEDURE addtrapped();


INSERT INTO street VALUES (0,0,1);