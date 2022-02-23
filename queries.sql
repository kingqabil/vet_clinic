/*Queries that provide answers to the questions from all projects.*/

--Phase 1 create animals table
-- Find all animals whose name ends in "mon".
SELECT * from animals WHERE name LIKE '%mon';

-- List the name of all animals born between 2016 and 2019.
SELECT * FROM animals WHERE date_of_birth BETWEEN '01-01-2016' AND '12-31-2019';

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT * FROM animals WHERE neutered=TRUE AND escape_attempts < 3;

-- List date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth, name FROM animals WHERE name='Agumon' OR name='Pikachu';

-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

-- Find all animals that are neutered.
SELECT * FROM animals WHERE neutered = TRUE;

-- Find all animals not named Gabumon.
SELECT * FROM animals WHERE name!='Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

--Phase 2 update animals table

--Inside a transaction update the animals table by setting the species column to unspecified. Verify that change was made.
--Then roll back the change and verify that species columns went back to the state before transaction

BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;

-- Transactions to all animals with names ending with mon

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';

--Update the animals table by setting the species column to pokemon for all animals that don't have species already set.

UPDATE animals SET species = 'pokemon' WHERE species is NULL;
-- Commit the transaction
COMMIT TRANSACTION;
SELECT * FROM animals;

--delete all records from animals and rollback

BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

--Inside transaction 0.1

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2020-01-01';
SAVEPOINT DOBorn;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO DOBorn;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT WORK;
SELECT * FROM animals;

--Queries to Answer the questions in the requirements:

-- How many animals are there?
SELECT COUNT(*) FROM animals;
-- How many animals have never tried to escape?
SELECT COUNT(escape_attempts)
FROM animals
WHERE escape_attempts = 0;
-- What is the average weight of animals?
SELECT AVG(weight_kg)
FROM animals;
-- Who escapes the most, neutered or not neutered animals?
SELECT
neutered,MAX(escape_attempts)
FROM animals
GROUP BY neutered
-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg),MAX(weight_kg) FROM animals GROUP BY species;
-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts)
FROM animals GROUP BY species
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31';