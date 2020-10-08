-- create soldier table
CREATE TABLE soldiers(
soldierID INT NOT NULL,
first_name VARCHAR(20) NOT NULL,
surname VARCHAR(50) NOT NULL,
age INT,
soldier_rank VARCHAR (45),
aboard VARCHAR(30) NOT NULL,
allegiance VARCHAR(100) NOT NULL,
is_pilot VARCHAR(5) NOT NULL,
soldier_status VARCHAR (10) NOT NULL,
PRIMARY KEY (soldierID)
);
-- create mobile suit table
CREATE TABLE mobile_suits(
msID INT NOT NULL,
ms_name VARCHAR(50) NOT NULL,
pilotID INT NOT NULL,
baseID INT NOT NULL,
PRIMARY KEY (msID)
);
-- create ship table
CREATE TABLE ships(
shipID INT NOT NULL,
ship_name VARCHAR(30) NOT NULL,
allegiance VARCHAR (100) NOT NULL,
captainID INT,
PRIMARY KEY (shipID)
);
-- create battles table
CREATE TABLE battles(
battleID INT NOT NULL AUTO_INCREMENT,
battle_name VARCHAR(100) NOT NULL,
army_1 VARCHAR(100) NOT NULL,
army_2 VARCHAR(100) NOT NULL,
winner VARCHAR(100) NOT NULL,
outcome VARCHAR(2000) NULL,
PRIMARY KEY(battleID)
);
-- create mobile suit to battle table
CREATE TABLE mobile_suit_battle(
msID INT NOT NULL,
battleID INT NOT NULL,
PRIMARY KEY(msID, battleID)
);
-- create ship to battle table
CREATE TABLE ship_battle(
shipID INT NOT NULL,
battleID INT NOT NULL,
PRIMARY KEY(shipID, battleID)
);
-- insert data
-- insert into soldiers
INSERT INTO soldiers (soldierID, first_name, surname, age, soldier_rank, aboard, allegiance, is_pilot, soldier_status)
VALUES (1, 'Amuro', 'Ray', 16, 'Ensign','White Base', 'Earth Federation Forces', 'Yes', 'Alive');
INSERT INTO soldiers (soldierID, first_name, surname, age, soldier_rank, aboard, allegiance, is_pilot, soldier_status)
VALUES (2, 'Char', 'Aznable', 20, 'Lieutenant Commander','Zanzibar Ingolstadt', 'Principality of Zeon', 'Yes', 'Alive');
INSERT INTO soldiers (soldierID, first_name, surname, age, soldier_rank, aboard, allegiance, is_pilot, soldier_status)
VALUES (3, 'Fraw', 'Bow', 15, 'Superior Private','White Base', 'Earth Federation Forces', 'No', 'Alive');
INSERT INTO soldiers (soldierID, first_name, surname, age, soldier_rank, aboard, allegiance, is_pilot, soldier_status)
VALUES (4, 'Sayla', 'Mass', 17, 'Petty Officer','White Base', 'Earth Federation Forces', 'Yes', 'Alive');
INSERT INTO soldiers (soldierID, first_name, surname, age, soldier_rank, aboard, allegiance, is_pilot, soldier_status)
VALUES (5, 'Garma', 'Zabi', 20, 'Lieutenant General','Gaw', 'Principality of Zeon', 'Yes', 'Dead');
INSERT INTO soldiers (soldierID, first_name, surname, age, soldier_rank, aboard, allegiance, is_pilot, soldier_status)
VALUES (6, 'Bright', 'Noa', 19, 'Lieutenant Junior Grade','White Base', 'Earth Federation Forces', 'Yes', 'Alive');
INSERT INTO soldiers (soldierID, first_name, surname, age, soldier_rank, aboard, allegiance, is_pilot, soldier_status)
VALUES (7, 'Kycilia', 'Zabi', 27, 'Rear Admiral','BB-38 Gwazine', 'Principality of Zeon', 'Yes', 'Dead');
INSERT INTO soldiers (soldierID, first_name, surname, age, soldier_rank, aboard, allegiance, is_pilot, soldier_status)
VALUES (8, 'Degwin', 'Zabi', 62, 'Sovereign Ruler','Great Degwin', 'Principality of Zeon', 'No', 'Dead');
-- insert into ships
INSERT INTO ships (shipID, ship_name, allegiance, captainID)
VALUES (1, 'White Base', 'Earth Federation Forces', 6);
INSERT INTO ships (shipID, ship_name, allegiance, captainID)
VALUES (2, 'Zanzibar Ingolstadt', 'Principality of Zeon', 2);
INSERT INTO ships (shipID, ship_name, allegiance, captainID)
VALUES (3, 'Gaw', 'Principality of Zeon', 5);
INSERT INTO ships (shipID, ship_name, allegiance, captainID)
VALUES (4, 'BB-38 Gwazine', 'Principality of Zeon', 7);
INSERT INTO ships (shipID, ship_name, allegiance, captainID)
VALUES (5, 'Great Degwin', 'Principality of Zeon', 8);
-- insert into mobile_suits
INSERT INTO mobile_suits (msID, ms_name, pilotID, base)
VALUES (1, 'RX-78-2 Gundam', 1, "White Base");
INSERT INTO mobile_suits (msID, ms_name, pilotID, base)
VALUES (2, 'MSN-02 Zeong', 2, "Zanzibar Ingolstadt");
INSERT INTO mobile_suits (msID, ms_name, pilotID, base)
VALUES (3, 'G-Fighter', 4, "White Base");
INSERT INTO mobile_suits (msID, ms_name, pilotID, base)
VALUES (4, 'MS-06FS Zaku II', 5, "Gaw");
INSERT INTO mobile_suits (msID, ms_name, pilotID, base)
VALUES (5, 'MAX-03 Adzam', 7, "BB-38 Gwazine");
-- insert into battles
INSERT INTO battles (battleID, battle_name, army_1, army_2, battle_status, outcome)
VALUES (1, 'Battle of Odessa', "Earth Federation Forces", "Principality of Zeon", "Complete", "Victory for the Earth Federation Forces. Zeon mining facilities captured. Zeon forces removed from Europe and Asia.");
INSERT INTO battles (battleID, battle_name, army_1, army_2, battle_status, outcome)
VALUES (2, 'Battle of Jaburo', "Earth Federation Forces", "Principality of Zeon", "Complete", "Victory for the Earth Federation Forces despite heavy losses. Zeon forces retreated to space.");
INSERT INTO battles (battleID, battle_name, army_1, army_2, battle_status, outcome)
VALUES (3, 'Operation Rubicon', "Earth Federation Forces", "Principality of Zeon", "Complete", "Cyclops Team failed to destroy RX-78NT-1 Gundam. RX-78NT-1 Gundam suffered damage and requires repairs. Zeon violated the Antarctic Treaty by attacking a colony.");
INSERT INTO battles (battleID, battle_name, army_1, army_2, battle_status, outcome)
VALUES (4, 'Operation Star One', "Earth Federation Forces", "Principality of Zeon", "Complete", "Victory for Earth Federation Forces. Death of Degwin Zabi, Gihren Zabi and Kycilia Zabi, ending the Zabi's rule of Zeon.");
INSERT INTO battles (battleID, battle_name, army_1, army_2, battle_status)
VALUES (5, 'Battle of A Baoa Qu', "Earth Federation Forces", "Principality of Zeon", "Ongoing");
INSERT INTO battles (battleID, battle_name, army_1, army_2, battle_status, outcome)
VALUES (6, 'One Week Battle', "Earth Federation Forces", "Principality of Zeon", "Complete", "Victory for Principality of Zeon. Side 1, Side 2 and Side 4 conquered by Zeon and civilians killed by poison gas. Side 2 colony dropped on Earth causing death and destruction.");
INSERT INTO battles (battleID, battle_name, army_1, army_2, battle_status, outcome)
VALUES (7, 'The Battle of Loum', "Earth Federation Forces", "Principality of Zeon", "Complete", "Victory for Principality of Zeon. Complete destruction of Side 5 by Zeon. Earth Federation Forces prevented colony drop of Side 5 and save some civilians.");
-- insert into mobile_suit_battle
INSERT INTO mobile_suit_battle (msID, battleID)
VALUES (1, 1);
INSERT INTO mobile_suit_battle (msID, battleID)
VALUES (1, 2);
INSERT INTO mobile_suit_battle (msID, battleID)
VALUES (2, 4);
INSERT INTO mobile_suit_battle (msID, battleID)
VALUES (1, 5);
INSERT INTO mobile_suit_battle (msID, battleID)
VALUES (2, 5);
INSERT INTO mobile_suit_battle (msID, battleID)
VALUES (3, 5);
-- insert into ship_battle
INSERT INTO ship_battle (shipID, battleID)
VALUES (1, 1);
INSERT INTO ship_battle (shipID, battleID)
VALUES (1, 2);
INSERT INTO ship_battle (shipID, battleID)
VALUES (1, 5);
INSERT INTO ship_battle (shipID, battleID)
VALUES (2, 5);
INSERT INTO ship_battle (shipID, battleID)
VALUES (4, 5);
INSERT INTO ship_battle (shipID, battleID)
VALUES (4, 7);
-- create foreign keys
-- msID in suit-battle table is foreign key of msID in suit table
ALTER TABLE mobile_suit_battle
ADD FOREIGN KEY (msID) REFERENCES mobile_suits(msID);
-- battleID in suit-battle table is foreign key of battleID in battles
ALTER TABLE mobile_suit_battle
ADD FOREIGN KEY (battleID) REFERENCES battles(battleID);
-- shipID in ship-battle table is foreign key of ship ID in ship table
ALTER TABLE ship_battle
ADD FOREIGN KEY (shipID) REFERENCES ships(shipID);
-- battleID in ship-battle table is foreign key of battleID in battles
ALTER TABLE ship_battle
ADD FOREIGN KEY (battleID) REFERENCES battles(battleID);
-- pilotID in suit table is foreign key of soldierID in soldier table
ALTER TABLE mobile_suits
ADD FOREIGN KEY (pilotID) REFERENCES soldiers(soldierID);
-- base in suit table is foreign key of ship_name in ship table
ALTER TABLE mobile_suits
ADD FOREIGN KEY (base) REFERENCES ships(ship_name);
-- aboard in soldier table is foreign key of ship_name in ship table
ALTER TABLE soldiers
ADD FOREIGN KEY (aboard) REFERENCES ships(ship_name);
-- captainID in ship table is foreign key of soldierID in soldier table
ALTER TABLE ships
ADD FOREIGN KEY (captainID) REFERENCES soldiers(soldierID);

CREATE VIEW white_base_members AS
SELECT first_name, surname, soldier_rank
FROM soldiers
WHERE aboard = "White Base";

CREATE VIEW ms_in_a_baoa_qu 
AS SELECT DISTINCT mb.msID, ms_name
FROM mobile_suit_battle mb, mobile_suits s, battles b
WHERE mb.msID=s.msID
AND mb.battleID=b.battleID;

ALTER TABLE soldiers 
ADD CONSTRAINT `check_status` CHECK (soldier_status = 'Alive' OR soldier_status = 'Dead');

ALTER TABLE soldiers
ADD CONSTRAINT `check_allegiance` CHECK (allegiance = 'Earth Federation Forces' OR allegiance = 'Principality of Zeon');

ALTER TABLE soldiers
ADD CONSTRAINT `check_pilot` CHECK (is_pilot = 'Yes' OR is_pilot = 'No');

ALTER TABLE ships
ADD CONSTRAINT `check_ship_allegiance` CHECK (allegiance = 'Earth Federation Forces' OR allegiance = 'Principality of Zeon');

ALTER TABLE battles 
ADD CONSTRAINT `check_battle_status` CHECK (battle_status = 'Ongoing' OR battle_status = 'Complete');

ALTER TABLE soldiers
ADD CONSTRAINT `check_rank` 
CHECK (soldier_rank = 'Petty Officer Third Class' OR soldier_rank = 'Petty Officer Second Class' 
OR soldier_rank = 'Petty Officer First Class' OR soldier_rank = 'Chief Petty Officer' 
OR soldier_rank = 'Master Chief Petty Officer'
OR soldier_rank = 'Warrant Officer' OR soldier_rank = 'Ensign' OR soldier_rank = 'Lieutenant Junior Grade'
OR soldier_rank = 'Lieutenant' OR soldier_rank = 'Lieutenant Commander' OR soldier_rank = 'Commander' 
OR soldier_rank = 'Captain' OR soldier_rank = 'Commodore' OR soldier_rank = 'Rear Admiral'
OR soldier_rank = 'Vice Admiral' OR soldier_rank = 'Admiral' OR soldier_rank = 'Private Second Class'
OR soldier_rank = 'Private First Class' OR soldier_rank = 'Superior Private' OR soldier_rank = 'Corporal'
OR soldier_rank = 'Sergeant' OR soldier_rank = 'Sergeant Major' OR soldier_rank = 'Second Lieutenant'
OR soldier_rank = 'First Lieutenant' OR soldier_rank = 'Major' OR soldier_rank = 'Lieutenant Colonel'
OR soldier_rank = 'Colonel' OR soldier_rank = 'Major General' OR soldier_rank = 'Lieutenant General'
OR soldier_rank = 'General' OR soldier_rank = 'Seaman Third Class' OR soldier_rank = 'Seaman Second Class'
OR soldier_rank = 'Seaman First Class' OR soldier_rank = 'Airman Basic' OR soldier_rank = 'Airman'
OR soldier_rank = 'Airman First Class' OR soldier_rank = 'Staff Sergeant' OR soldier_rank = 'Technical Sergeant'
OR soldier_rank = 'Master Sergeant' OR soldier_rank = 'Senior Master Sergeant');
-- create trigger
DELIMITER $$
CREATE TRIGGER battle_result
BEFORE UPDATE ON battles
FOR EACH ROW 
BEGIN
IF NEW.outcome IS NOT NULL THEN
SET NEW.battle_status = 'Complete';
END IF;
END$$

DELIMITER ;
-- create roles
CREATE ROLE Generals;
CREATE ROLE Captains;
GRANT INSERT, SELECT ON mobile_suits TO Captains, Generals;
GRANT INSERT, SELECT ON ships TO Generals;
GRANT INSERT, SELECT ON battles TO Generals;
GRANT SELECT ON battles TO Captains;

