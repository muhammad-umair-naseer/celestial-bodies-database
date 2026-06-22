DROP DATABASE IF EXISTS universe;
CREATE DATABASE universe;
\connect universe

CREATE TABLE galaxy (
  galaxy_id SERIAL PRIMARY KEY,
  name VARCHAR(120) NOT NULL UNIQUE,
  galaxy_type VARCHAR(60) NOT NULL,
  mass NUMERIC NOT NULL,
  distance_from_origin INT NOT NULL,
  description TEXT,
  discovered_year INT NOT NULL
);

CREATE TABLE star (
  star_id SERIAL PRIMARY KEY,
  name VARCHAR(120) NOT NULL UNIQUE,
  galaxy_id INT NOT NULL REFERENCES galaxy(galaxy_id),
  spectral_type VARCHAR(20) NOT NULL,
  mass NUMERIC NOT NULL,
  radius INT NOT NULL,
  has_planets BOOLEAN NOT NULL DEFAULT TRUE,
  description TEXT
);

CREATE TABLE planet (
  planet_id SERIAL PRIMARY KEY,
  name VARCHAR(120) NOT NULL UNIQUE,
  star_id INT NOT NULL REFERENCES star(star_id),
  orbital_period NUMERIC NOT NULL,
  diameter INT NOT NULL,
  is_habitable BOOLEAN NOT NULL DEFAULT FALSE,
  has_rings BOOLEAN NOT NULL DEFAULT FALSE,
  planet_type VARCHAR(60) NOT NULL,
  description TEXT
);

CREATE TABLE moon (
  moon_id SERIAL PRIMARY KEY,
  name VARCHAR(120) NOT NULL UNIQUE,
  planet_id INT NOT NULL REFERENCES planet(planet_id),
  diameter INT NOT NULL,
  orbital_period NUMERIC NOT NULL,
  is_dwarf BOOLEAN NOT NULL DEFAULT FALSE,
  tidally_locked BOOLEAN NOT NULL DEFAULT FALSE,
  description TEXT
);

CREATE TABLE asteroid (
  asteroid_id SERIAL PRIMARY KEY,
  name VARCHAR(120) NOT NULL UNIQUE,
  orbiting_body VARCHAR(120) NOT NULL,
  diameter INT NOT NULL,
  discovered_year INT NOT NULL,
  is_potentially_hazardous BOOLEAN NOT NULL DEFAULT FALSE
);

INSERT INTO galaxy (name, galaxy_type, mass, distance_from_origin, description, discovered_year) VALUES
  ('Milky Way', 'Spiral', 1.5, 0, 'Our home galaxy.', 1924),
  ('Andromeda', 'Spiral', 1.2, 2537000, 'Closest large galaxy to the Milky Way.', 964),
  ('Triangulum', 'Spiral', 0.6, 3000000, 'A nearby spiral galaxy.', 1654),
  ('Whirlpool', 'Spiral', 1.6, 23000000, 'A famous interacting spiral galaxy.', 1773),
  ('Sombrero', 'Elliptical', 0.8, 29000000, 'A large bulge galaxy with a dust lane.', 1781),
  ('Pinwheel', 'Spiral', 1.0, 21000000, 'A face-on spiral galaxy.', 1781);

INSERT INTO star (name, galaxy_id, spectral_type, mass, radius, has_planets, description) VALUES
  ('Sol', 1, 'G2V', 1.0, 109, TRUE, 'The star at the center of our solar system.'),
  ('Alpha Centauri A', 1, 'G2V', 1.1, 120, TRUE, 'A Sun-like star in the Alpha Centauri system.'),
  ('Sirius A', 1, 'A1V', 2.1, 181, FALSE, 'The brightest star in Earth''s night sky.'),
  ('Proxima Centauri', 1, 'M5.5Ve', 0.12, 15, TRUE, 'The nearest known star to the Sun.'),
  ('Rigel', 1, 'B8Ia', 21.0, 79, FALSE, 'A blue supergiant in Orion.'),
  ('Betelgeuse', 1, 'M2Iab', 18.0, 887, FALSE, 'A red supergiant in Orion.'),
  ('Vega', 1, 'A0V', 2.1, 203, FALSE, 'A bright star in the Lyra constellation.');

INSERT INTO planet (name, star_id, orbital_period, diameter, is_habitable, has_rings, planet_type, description) VALUES
  ('Mercury', 1, 88, 4879, FALSE, FALSE, 'Terrestrial', 'Small rocky planet closest to the Sun.'),
  ('Venus', 1, 225, 12104, FALSE, FALSE, 'Terrestrial', 'Earth''s sister planet with a dense atmosphere.'),
  ('Earth', 1, 365.25, 12742, TRUE, FALSE, 'Terrestrial', 'Our home planet.'),
  ('Mars', 1, 687, 6779, FALSE, FALSE, 'Terrestrial', 'The red planet.'),
  ('Jupiter', 1, 4333, 139820, FALSE, TRUE, 'Gas giant', 'The largest planet in the Solar System.'),
  ('Saturn', 1, 10759, 116460, FALSE, TRUE, 'Gas giant', 'Known for its extensive ring system.'),
  ('Uranus', 1, 30687, 50724, FALSE, TRUE, 'Ice giant', 'A tilted ice giant with faint rings.'),
  ('Neptune', 1, 60190, 49244, FALSE, TRUE, 'Ice giant', 'The farthest classical planet from the Sun.'),
  ('Proxima b', 4, 11.2, 11492, FALSE, FALSE, 'Exoplanet', 'A rocky exoplanet around Proxima Centauri.'),
  ('Kepler-22b', 2, 289.9, 24000, FALSE, FALSE, 'Exoplanet', 'A super-Earth in the habitable zone.'),
  ('HD 189733 b', 2, 2.2, 138000, FALSE, FALSE, 'Gas giant', 'A hot Jupiter with a deep blue color.'),
  ('TRAPPIST-1e', 3, 6.1, 11400, TRUE, FALSE, 'Terrestrial', 'One of several Earth-size planets in the TRAPPIST-1 system.'),
  ('Barnard''s Star b', 4, 233, 12000, FALSE, FALSE, 'Super-Earth', 'A candidate exoplanet orbiting Barnard''s Star.'),
  ('Kepler-16b', 2, 228.8, 127000, FALSE, FALSE, 'Circumbinary', 'A planet orbiting two stars.'),
  ('Wolf 1061c', 4, 17.9, 12500, FALSE, FALSE, 'Super-Earth', 'A rocky planet in the habitable zone.'),
  ('55 Cancri e', 2, 0.74, 12104, FALSE, FALSE, 'Super-Earth', 'A very hot planet very close to its star.'),
  ('HD 40307 g', 2, 197, 14400, FALSE, FALSE, 'Super-Earth', 'A candidate in the habitable zone.'),
  ('Kepler-442b', 2, 112.3, 13500, TRUE, FALSE, 'Super-Earth', 'A likely rocky planet in the habitable zone.'),
  ('Gliese 667 Cc', 4, 28.1, 12900, FALSE, FALSE, 'Super-Earth', 'A planet orbiting a red dwarf star.'),
  ('Tau Ceti e', 2, 163.4, 12800, FALSE, FALSE, 'Super-Earth', 'A temperate planet orbiting Tau Ceti.'),
  ('HD 209458 b', 2, 3.5, 120000, FALSE, FALSE, 'Gas giant', 'A well-studied transiting hot Jupiter.'),
  ('GJ 1214 b', 4, 1.58, 17800, FALSE, FALSE, 'Sub-Neptune', 'A warm sub-Neptune with a thick atmosphere.');

INSERT INTO moon (name, planet_id, diameter, orbital_period, is_dwarf, tidally_locked, description) VALUES
  ('Moon', 3, 3474, 27.3, FALSE, TRUE, 'Earth''s only natural satellite.'),
  ('Phobos', 4, 22, 0.32, FALSE, TRUE, 'One of Mars'' moons.'),
  ('Deimos', 4, 12, 1.26, FALSE, TRUE, 'Mars'' smaller moon.'),
  ('Io', 5, 3643, 1.77, FALSE, TRUE, 'A volcanic moon of Jupiter.'),
  ('Europa', 5, 3122, 3.55, FALSE, TRUE, 'An icy moon of Jupiter.'),
  ('Ganymede', 5, 5268, 7.15, FALSE, TRUE, 'The largest moon in the Solar System.'),
  ('Callisto', 5, 4821, 16.69, FALSE, TRUE, 'A heavily cratered moon of Jupiter.'),
  ('Titan', 6, 5150, 15.95, FALSE, TRUE, 'Saturn''s largest moon.'),
  ('Enceladus', 6, 504, 1.37, FALSE, TRUE, 'A small icy moon of Saturn.'),
  ('Mimas', 6, 396, 0.94, FALSE, TRUE, 'A cratered moon of Saturn.'),
  ('Triton', 8, 2706, -5.88, FALSE, TRUE, 'Neptune''s largest moon, orbiting retrograde.'),
  ('Oberon', 6, 1523, 13.46, FALSE, TRUE, 'A moon of Uranus.'),
  ('Titania', 6, 1577, 8.71, FALSE, TRUE, 'A moon of Uranus.'),
  ('Rhea', 6, 1528, 4.52, FALSE, TRUE, 'A moon of Saturn.'),
  ('Iapetus', 6, 1469, 79.33, FALSE, TRUE, 'A distant moon of Saturn.'),
  ('Dione', 6, 1123, 2.74, FALSE, TRUE, 'A moon of Saturn.'),
  ('Tethys', 6, 1062, 1.89, FALSE, TRUE, 'A moon of Saturn.'),
  ('Enceladus II', 6, 505, 2.0, FALSE, TRUE, 'A hypothetical moon used for dataset richness.'),
  ('Hyperion', 6, 270, 21.28, FALSE, TRUE, 'A chaotic moon of Saturn.'),
  ('Charon', 3, 1212, 6.39, FALSE, TRUE, 'Pluto''s largest moon in the Solar System''s dwarf planet system.'),
  ('Nix', 3, 49, 24.9, TRUE, TRUE, 'A small moon orbiting Pluto.'),
  ('Hydra', 3, 61, 38.2, TRUE, TRUE, 'A small moon orbiting Pluto.'),
  ('Kerberos', 3, 19, 32.1, TRUE, TRUE, 'A tiny moon orbiting Pluto.'),
  ('Styx', 3, 16, 20.2, TRUE, TRUE, 'A small moon orbiting Pluto.');

INSERT INTO asteroid (name, orbiting_body, diameter, discovered_year, is_potentially_hazardous) VALUES
  ('Ceres', 'Sun', 946, 1801, FALSE),
  ('Vesta', 'Sun', 525, 1807, FALSE),
  ('Pallas', 'Sun', 512, 1802, FALSE),
  ('Eros', 'Sun', 16, 1898, TRUE),
  ('Halley''s Comet', 'Sun', 11, 1758, TRUE);
