DROP TABLE IF EXISTS GSBeats;

CREATE TABLE GSBeats (
   WinnerGS TEXT,
   LoserGS TEXT
);

INSERT INTO GSBeats
VALUES
   ('Mercury', 'Sun'),
   ('Sun', 'Moon'),
   ('Moon', 'Venus'),
   ('Venus', 'Mercury'),
   ('Mars', 'Jupiter'),
   ('Jupiter', 'Saturn'),
   ('Saturn', 'Uranus'),
   ('Uranus', 'Pluto'),
   ('Pluto', 'Neptune'),
   ('Neptune', 'Mars');