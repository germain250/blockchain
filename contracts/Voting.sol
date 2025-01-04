// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    struct Candidate {
        uint id;
        string name;
        string image;
        string manifesto;
        uint voteCount;
    }

    struct Voter {
        bool hasVoted;
        uint voteTo;
    }

    mapping(uint => Candidate) public candidates;
    mapping(address => Voter) private voters;

    uint public candidateCount;

    event CandidateRegistered(uint id, string name, string image, string manifesto);
    event VoteCasted(address voter, uint candidateId);

    function registerCandidate(
        string memory _name,
        string memory _image,
        string memory _manifesto
    ) public {
        candidateCount++;
        candidates[candidateCount] = Candidate(candidateCount, _name, _image, _manifesto, 0);
        emit CandidateRegistered(candidateCount, _name, _image, _manifesto);
    }

    function vote(uint _candidateId) public {
        require(!voters[msg.sender].hasVoted, "You have already voted.");
        require(_candidateId > 0 && _candidateId <= candidateCount, "Invalid candidate ID.");
        candidates[_candidateId].voteCount++;
        voters[msg.sender] = Voter(true, _candidateId);
        emit VoteCasted(msg.sender, _candidateId);
    }

    function getCandidate(uint _id) public view returns (
        uint id,
        string memory name,
        string memory image,
        string memory manifesto,
        uint voteCount
    ) {
        require(_id > 0 && _id <= candidateCount, "Invalid candidate ID.");
        Candidate memory candidate = candidates[_id];
        return (
            candidate.id,
            candidate.name,
            candidate.image,
            candidate.manifesto,
            candidate.voteCount
        );
    }

    function getCandidatesCount() public view returns (uint) {
        return candidateCount;
    }

    function getAllCandidates() public view returns (
        uint[] memory ids,
        string[] memory names,
        string[] memory images,
        string[] memory manifestos,
        uint[] memory voteCounts
    ) {
        uint[] memory idsArray = new uint[](candidateCount);
        string[] memory namesArray = new string[](candidateCount);
        string[] memory imagesArray = new string[](candidateCount);
        string[] memory manifestosArray = new string[](candidateCount);
        uint[] memory voteCountsArray = new uint[](candidateCount);

        for (uint i = 1; i <= candidateCount; i++) {
            Candidate memory candidate = candidates[i];
            idsArray[i - 1] = candidate.id;
            namesArray[i - 1] = candidate.name;
            imagesArray[i - 1] = candidate.image;
            manifestosArray[i - 1] = candidate.manifesto;
            voteCountsArray[i - 1] = candidate.voteCount;
        }

        return (idsArray, namesArray, imagesArray, manifestosArray, voteCountsArray);
    }

    function getVoter(address _voter) public view returns (bool hasVoted, uint voteTo) {
        Voter memory voter = voters[_voter];
        return (voter.hasVoted, voter.voteTo);
    }
}
