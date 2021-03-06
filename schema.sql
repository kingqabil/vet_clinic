/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name varchar(100),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL,
    PRIMARY KEY (id)
);

ALTER TABLE animals ADD species varchar(100); /*ALTER command is for changing the structure(It help us to adding a forgotten column, for our case it's species column)*/

--Create a table named owners
CREATE TABLE owners(
   id INT GENERATED ALWAYS AS IDENTITY,
   full_name VARCHAR(255),
   age INT,
   PRIMARY KEY(id)
);

--Create a table named species
CREATE TABLE species(
   id INT GENERATED ALWAYS AS IDENTITY,
   name VARCHAR(255),
   PRIMARY KEY(id)
   );

--Modify animals table:

--Remove column species
ALTER TABLE animals DROP COLUMN species;

--Add column species_id which is a foreign key referencing species table
ALTER TABLE animals ADD COLUMN species_id INT,
ADD CONSTRAINT fk_species FOREIGN KEY(species_id) REFERENCES species(id);

--Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE animals ADD COLUMN owner_id INT,
ADD CONSTRAINT fk_owners FOREIGN KEY(owner_id) REFERENCES owners(id);

/* add "JOIN TABLE" for visits */

--Create a table named vets
CREATE TABLE vets(
   id INT GENERATED ALWAYS AS IDENTITY,
   name VARCHAR(255),
   age INT,
   date_of_graduation DATE,
   PRIMARY KEY(id)
   );
--There is a many-to-many relationship between the tables species and vets: a vet can specialize in multiple species, and a species can have multiple vets specialized in it.
-- Create a "join table" called specializations to handle this relationship.
CREATE TABLE specializations (
    species_id INT,
    vets_id INT,
    CONSTRAINT fk_species FOREIGN KEY(species_id) REFERENCES species(id),
    CONSTRAINT fk_vets FOREIGN KEY(vets_id) REFERENCES vets(id)
);
--There is a many-to-many relationship between the tables animals and vets: an animal can visit multiple vets and one vet can be visited by multiple animals.
-- Create a "join table" called visits to handle this relationship, it should also keep track of the date of the visit.
CREATE TABLE visits (
    animals_id INT,
    vets_id INT,
    date_of_visit DATE,
    CONSTRAINT fk_animals FOREIGN KEY(animals_id) REFERENCES animals(id),
    CONSTRAINT fk_vets FOREIGN KEY(vets_id) REFERENCES vets(id)
);

ALTER TABLE owners ADD COLUMN email VARCHAR(120);

CREATE INDEX idx_animal_id ON visits(animal_id);
CREATE INDEX idx_vet_id ON visits(vet_id);
CREATE INDEX owners_email_asc ON owners(email ASC);