USE [PollingSystem]
GO
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
