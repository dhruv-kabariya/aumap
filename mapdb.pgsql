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


INSERT INTO coordinate 
VALUES 
(0,0,0,TRUE),
(1,0,1,FALSE),
(2,1,0,TRUE),
(3,1,1,FALSE),
(4,2,0,TRUE);