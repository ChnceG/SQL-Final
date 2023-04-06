USE [PollingSystem]
GO
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