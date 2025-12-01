// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleVoting {
    struct Candidate {
        uint256 id;
        string name;
        uint256 voteCount;
    }

    mapping(uint256 => Candidate) public candidates;
    mapping(address => bool) public hasVoted;
    uint256 public candidatesCount;
    uint256 public totalVotes;
    address public admin;

    constructor() {
        admin = msg.sender;
    }

    function addCandidate(string memory _name) public {
        require(msg.sender == admin, "Only admin can add a candidate");
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function vote(uint256 _candidateID) public {
        require(!hasVoted[msg.sender], "User has already voted");
        require(_candidateID > 0 && _candidateID <= candidatesCount, "Invalid candidate ID");
        hasVoted[msg.sender] = true;
        candidates[_candidateID].voteCount++;
        totalVotes++;
    }

    function getAllCandidates() public view returns (Candidate[] memory) {
        Candidate[] memory allCandidates = new Candidate[](candidatesCount);
        for (uint256 i = 1; i <= candidatesCount; i++) {
            allCandidates[i - 1] = candidates[i];
        }
        return allCandidates;
    }

    function checkIfVoted(address _voter) public view returns (bool) {
        return hasVoted[_voter];
    }
}