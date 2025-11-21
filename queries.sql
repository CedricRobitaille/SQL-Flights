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
  ON routes.origin_code = origin.iata_faa     -- Only list flights where origins = codes
JOIN airports AS destination
  ON routes.dest_code = destination.iata_faa  -- Only list flights where destination = codes

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
SELECT COUNT(*)   -- NEW
FROM routes
JOIN airports AS origin
  ON routes.origin_code = origin.iata_faa
JOIN airports AS destination
  ON routes.dest_code = destination.iata_faa
WHERE origin.city = 'New York'
  AND destination.city = 'Paris';

-- List out the airlines
SELECT DISTINCT airlines.name             -- NEW
FROM airlines                             -- NEW
JOIN routes                               -- EDITED
  ON airlines.id = routes.airline_id      -- EDITED
JOIN airports AS origin
  ON routes.origin_code = origin.iata_faa
JOIN airports AS destination
  ON routes.dest_code = destination.iata_faa
WHERE origin.city = 'New York'
  AND destination.city = 'Paris';

-- Count of total flights arriving at each airport that came from NYC
SELECT destination.city AS landing_city,
       COUNT(destination.name) AS total_flights
FROM routes
JOIN airports AS origin
  ON routes.origin_code = origin.iata_faa
JOIN airports AS destination
  on routes.dest_code = destination.iata_faa
WHERE origin.city = 'New York'
GROUP BY destination.city   -- Sort by dest City
ORDER BY total_flights DESC; -- Ordered by Flight Count