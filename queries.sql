-- GOAL
-- Find out how many flights go from NYC to Paris.

-- Level Up:
-- Search airlines that make the journey
-- QTY of all flights leaving NYC, and how many each destination receives


-- ROUTES
-- airline_code | airline_id | origin_code | origin_id | dest_code | dest_id | codeshare | stops | equipment
-- 2B           |        410 | AER         |      2965 | KZN       |    2990 |           |     0 | CR2


-- AIRPORTS
-- id | name   | city   | country          | iata_faa | icao | latitude  | longitude  | altitude | utc_offset | dst | tz
-- 1  | Goroka | Goroka | Papua New Guinea | GKA      | AYGA | -6.081689 | 145.391881 | 5282     | 10         | U   | Pacific/Port_Moresby


-- AIRLINES
-- id | name        | alias | iata  | icao | callsign | country | active
-- 1  | 135 Airways | NULL  |       |      |          | NULL    | Y

-- CONNECT ROUTES TO ROUTES TO AIRPORTS THROUGH THE DEST/ORGIN CODES
SELECT *
FROM routes
JOIN airports AS origin
  ON routes.origin_code = origin.iata_faa
JOIN airports AS destination
  ON routes.dest_code = destination.iata_faa

-- PARSE SO THAT ONLY NYC IS ORIGIN AND PARIS IS DEST
SELECT *
FROM routes
JOIN airports AS origin
  ON routes.origin_code = origin.iata_faa
JOIN airports AS destination
  ON routes.dest_code = destination.iata_faa
WHERE origin.city = 'New York'       -- NEW
  AND destination.city = 'Paris';    -- NEW

-- COUNT THE FLIGHTS
SELECT COUNT(*)     -- NEW
FROM routes
JOIN airports AS origin
  ON routes.origin_code = origin.iata_faa
JOIN airports AS destination
  ON routes.dest_code = destination.iata_faa
WHERE origin.city = 'New York'       -- NEW
  AND destination.city = 'Paris';    -- NEW

-- 