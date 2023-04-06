USE [PollingSystem]
GO
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
DELETE FROM TotalVotes
WHERE VoterID = 2;
DELETE FROM Admin
WHERE VoterID = 2;
DELETE FROM Voter
WHERE VoterID = 2;
/*Commit Question 3*/
COMMIT TRAN

/*4. Delete existing records*/
BEGIN TRANSACTION;
DELETE FROM VotingSession;
DELETE FROM VotingBooth;
DELETE FROM PollingOfficer;
DELETE FROM Admin;
DELETE FROM TotalVotes;
DELETE FROM Voter;
DELETE FROM Candidate;
/*Commit Question 4*/
COMMIT TRANSACTION;