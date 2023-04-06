CREATE DATABASE PollingSystem;
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