CREATE DATABASE PollingSystem;
-- CREATE THE DATABASE
USE PollingSystem;
CREATE TABLE Candidate (
    CandidateID int PRIMARY KEY,
    CandidateName varchar(255) NOT NULL,
    Party varchar(255) NOT NULL,
);
CREATE TABLE Voter (
    VoterID int PRIMARY KEY, 
    username varchar(255) NOT NULL, 
    password varchar(255) NOT NULL,
    votedFor int,
    FOREIGN KEY (votedFor) REFERENCES Candidate(CandidateID)
    );
CREATE TABLE TotalVotes (
    VoteID int PRIMARY KEY,
	VoterID int,
	CandidateID int,
    FOREIGN KEY (VoterID) REFERENCES Voter(VoterID),
    FOREIGN KEY (CandidateID) REFERENCES Candidate(CandidateID)
);
CREATE TABLE Admin (
    AdminID int PRIMARY KEY, 
    username varchar(255) NOT NULL, 
    password varchar(255) NOT NULL,
    VoterID int,
    FOREIGN KEY (VoterID) REFERENCES Voter(VoterID)
    );
CREATE TABLE PollingOfficer (
    OfficerID int PRIMARY KEY, 
    username varchar(255) NOT NULL, 
    password varchar(255) NOT NULL,
    VoterID int,
    CandidateID int,
    VoteID int,
    FOREIGN KEY (VoterID) REFERENCES Voter(VoterID),
    FOREIGN KEY (CandidateID) REFERENCES Candidate(CandidateID),
    FOREIGN KEY (VoteID) REFERENCES TotalVotes(VoteID)
    );
CREATE TABLE VotingBooth (
    boothID int PRIMARY KEY,
    location varchar(255) NOT NULL,
    AdminID int,
    FOREIGN KEY (AdminID) REFERENCES Admin(AdminID)
    );
CREATE TABLE VotingSession (
    SessionID int PRIMARY KEY,
    startTime datetime NOT NULL,
    endTime datetime NOT NULL,
    OfficerID int,
    boothID int,
    FOREIGN KEY (OfficerID) REFERENCES PollingOfficer(OfficerID),
    FOREIGN KEY (boothID) REFERENCES VotingBooth(boothID)
    );

-- Inserting data into tables
INSERT INTO Candidate (CandidateID, CandidateName, Party) 
    VALUES (1, 'John', 'Blue'),
    (2, 'Jim', 'Red'),
    (3, 'Jerry', 'Yellow');

INSERT INTO Voter (VoterID, username, password, votedFor) 
    VALUES (1, 'Voter1', '1', 1),
    (2, 'Voter2', '2', 2),
    (3, 'Voter3', '3', 3),
    (4, 'Voter4', '4', 1),
    (5, 'Voter5', '5', 2),
    (6, 'Voter6', '6', 3),
    (7, 'Voter7', '7', 3),
    (8, 'Voter8', '8', 2),
    (9, 'Voter9', '9', 3),
    (10, 'Voter10', '10', 1),
    (11, 'Voter11', '11', 2),
    (12, 'Voter12', '12', 3);

INSERT INTO TotalVotes (VoteID, VoterID, CandidateID) 
    VALUES (1, 1, 1),
    (2, 2, 2),
    (3, 3, 3),
    (4, 4, 1),
    (5, 5, 2),
    (6, 6, 3),
    (7, 7, 3),
    (8, 8, 2),
    (9, 9, 3),
    (10, 10, 1),
    (11, 11, 2),
    (12, 12, 3);

INSERT INTO Admin (AdminID, username, password, VoterID) 
    VALUES (1, 'Admin1', '1', 1),
    (2, 'Admin2', '2', 2);

INSERT INTO PollingOfficer (OfficerID, username, password, VoterID, CandidateID, VoteID) 
    VALUES (1, 'Officer1', '1', 3, 1, 1);

INSERT INTO VotingBooth (boothID, location, AdminID) 
    VALUES (1, 'Hailfax', 1);

INSERT INTO VotingSession (SessionID, startTime, endTime, OfficerID, boothID) 
    VALUES (1, '2022-04-06 08:00:00', '2022-04-06 20:00:00', 1, 1);

-- SCRIPT FOR QUESTIONS
BEGIN TRAN
/*Update Candidate Information*/
UPDATE Candidate
SET CandidateName = 'Johnny', Party = 'Purple'
WHERE CandidateID = 1;
/*Commit Question 1*/
COMMIT TRAN

/*2. Update Login Credentials*/
BEGIN TRAN
UPDATE Voter 
SET username = 'Voter', password = '123' 
WHERE VoterID = 1;
/*Commit Question 2*/
COMMIT TRAN

/*3. Delete Voter*/
BEGIN TRAN
DELETE FROM Voter
WHERE VoterID = 2;
/*Commit Question 3*/
COMMIT TRAN

/*4. Delete existing records*/
BEGIN TRANSACTION;
DELETE FROM Candidate;
DELETE FROM Voter;
DELETE FROM TotalVotes;
DELETE FROM Admin;
DELETE FROM PollingOfficer;
DELETE FROM VotingBooth;
DELETE FROM VotingSession;
/*Commit Question 4*/
COMMIT TRANSACTION;

-- SCRIPT 2 FOR QUESTIONS (VIEWS)
DROP VIEW IF EXISTS Top2Candidates
DROP VIEW IF EXISTS BiggestLoser
DROP VIEW IF EXISTS Between5and15
DROP VIEW IF EXISTS PollingResults
DROP VIEW IF EXISTS WinningCandidate

BEGIN TRAN
GO
-- Query 1
CREATE VIEW Top2Candidates AS
SELECT TOP 2 tv.CandidateID, c.CandidateName, Count(tv.CandidateID) AS 'Top 2 Voters'
FROM TotalVotes tv
INNER JOIN Candidate c ON tv.CandidateID = c.CandidateID
GROUP BY tv.CandidateID, c.CandidateName
ORDER BY 'Top 2 Voters' DESC
GO
COMMIT TRAN

BEGIN TRAN
GO
-- Query 2
CREATE VIEW BiggestLoser AS
SELECT TOP 1 tv.CandidateID, c.CandidateName AS 'Biggest Loser', Count(tv.CandidateID) AS 'Vote Count'
FROM TotalVotes tv
INNER JOIN Candidate c ON tv.CandidateID = c.CandidateID
GROUP BY tv.CandidateID, c.CandidateName
ORDER BY 'Vote Count' ASC
GO
COMMIT TRAN

BEGIN TRAN
GO
-- Query 3
CREATE VIEW Between5and15 AS
SELECT tv.CandidateID, c.CandidateName AS 'Name', Count(tv.CandidateID) AS 'Vote Count'
FROM TotalVotes tv
INNER JOIN Candidate c ON tv.CandidateID = c.CandidateID
GROUP BY tv.CandidateID, c.CandidateName
HAVING Count(tv.CandidateID) >= 5 AND Count(tv.CandidateID) <= 15 
GO
COMMIT TRAN

BEGIN TRAN
GO
-- Query 4
CREATE VIEW PollingResults AS
SELECT tv.CandidateID, c.CandidateName AS 'Name', Count(tv.CandidateID) AS 'Vote Count'
FROM TotalVotes tv
INNER JOIN Candidate c ON tv.CandidateID = c.CandidateID
GROUP BY tv.CandidateID, c.CandidateName
GO
COMMIT TRAN

BEGIN TRAN
GO
-- Query 5
CREATE VIEW WinningCandidate AS
SELECT TOP 1 tv.CandidateID, c.CandidateName AS 'WINNING CANDIDATE', Count(tv.CandidateID) AS 'Vote Count'
FROM TotalVotes tv
INNER JOIN Candidate c ON tv.CandidateID = c.CandidateID
GROUP BY tv.CandidateID, c.CandidateName
ORDER BY 'Vote Count' DESC;
GO
COMMIT TRAN

-- Print Views
SELECT * FROM Top2Candidates
SELECT * FROM BiggestLoser
SELECT * FROM Between5and15
SELECT * FROM PollingResults
SELECT * FROM WinningCandidate
