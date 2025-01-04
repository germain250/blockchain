require('dotenv').config();
const express = require('express');
const { ethers } = require('ethers');
const { abi } = require(process.env.ABI_PATH);

const app = express();
const port = 3000;

// Initialize provider and wallet
const provider = new ethers.JsonRpcProvider(process.env.GANACHE_URL);
const adminWallet = new ethers.Wallet(process.env.ADMIN_PRIVATE_KEY, provider);
const contract = new ethers.Contract(process.env.CONTRACT_ADDRESS, abi, adminWallet);

// Middleware
app.use(express.json());

// Helper to serialize BigInt
const serializeBigInt = (bigIntValue) => bigIntValue.toString();

// Register Candidate (Admin Only)
app.post('/register-candidate', async (req, res) => {
    try {
        const { name, image, manifesto } = req.body;
        const adminAddress = await adminWallet.getAddress();
        const expectedAdminAddress = '0xaf4D746D42F80c3380Dc1119874006D73A629015';

        if (adminAddress !== expectedAdminAddress) {
            return res.status(403).json({ message: "Only admin can register candidates." });
        }

        const tx = await contract.registerCandidate(name, image, manifesto);
        await tx.wait();

        res.json({ message: `Candidate ${name} registered successfully`, txHash: tx.hash });
    } catch (error) {
        console.error("Error registering candidate:", error);
        res.status(500).json({ message: "Error registering candidate" });
    }
});

// Get Voter Info
app.get('/voter/:address', async (req, res) => {
    try {
        const voterAddress = req.params.address;
        const voter = await contract.getVoter(voterAddress);

        res.json({
            hasVoted: voter.hasVoted,
            voteTo: serializeBigInt(voter.voteTo),
        });
    } catch (error) {
        console.error("Error retrieving voter information:", error);
        res.status(500).json({ message: "Error retrieving voter information" });
    }
});

// Cast Vote
app.post('/vote', async (req, res) => {
    try {
        const { candidateId, privateKey } = req.body;

        if (!privateKey) {
            return res.status(400).json({ message: "Private key is required to cast a vote." });
        }

        // Create wallet from voter's private key
        const voterWallet = new ethers.Wallet(privateKey, provider);
        const voterAddress = await voterWallet.getAddress();

        // Check if the user has already voted
        const voter = await contract.getVoter(voterAddress);
        if (voter.hasVoted) {
            return res.status(400).json({ message: "You have already voted." });
        }

        // Connect the voter wallet to the contract
        const contractWithSigner = contract.connect(voterWallet);
        const tx = await contractWithSigner.vote(candidateId);
        await tx.wait();

        res.json({
            message: `Vote successfully cast for candidate ${candidateId}`,
            txHash: tx.hash,
        });
    } catch (error) {
        console.error("Error casting vote:", error);
        res.status(500).json({ message: "Error casting vote" });
    }
});

// Get Candidate by ID
app.get('/candidate/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const candidate = await contract.getCandidate(id);

        res.json({
            id: serializeBigInt(candidate.id),
            name: candidate.name,
            image: candidate.image,
            manifesto: candidate.manifesto,
            voteCount: serializeBigInt(candidate.voteCount),
        });
    } catch (error) {
        console.error("Error retrieving candidate details:", error);
        res.status(500).json({ message: "Error retrieving candidate details" });
    }
});

// Get All Candidates
app.get('/candidates', async (req, res) => {
    try {
        const candidates = await contract.getAllCandidates();

        const formattedCandidates = candidates[0].map((_, index) => ({
            id: candidates[0][index].toString(),
            name: candidates[1][index],
            image: candidates[2][index],
            manifesto: candidates[3][index],
            voteCount: candidates[4][index].toString(),
        }));

        res.json(formattedCandidates);
    } catch (error) {
        console.error("Error retrieving candidates:", error);
        res.status(500).json({ message: "Error retrieving candidates" });
    }
});

// Start Server
app.listen(port, () => {
    console.log(`Server running at http://localhost:${port}`);
});
