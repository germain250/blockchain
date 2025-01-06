# Blockchain Voting App

This repository contains a blockchain-based voting application. The project is divided into three main branches:

1. **Frontend**: Implemented in Flutter (`flutter_app` branch).
2. **Backend**: Implemented in Node.js (`nodejs` branch).
3. **Smart Contracts**: Implemented in Solidity (`solidity` branch).

## Prerequisites

### General Requirements
Ensure you have the following installed on your machine:

- **Git**: For cloning the repository.
- **Node.js**: For the backend and Truffle framework.
- **npm** or **yarn**: For managing dependencies.
- **Flutter SDK**: For the frontend.
- **Truffle**: For compiling and deploying Solidity contracts.
- **Ganache**: For a local Ethereum blockchain instance.

## Getting Started

### Clone the Repository
```bash
$ git clone https://github.com/germain250/blockchain.git
$ cd blockchain
```

### Setting Up the Solidity Smart Contracts
Switch to the `solidity` branch and follow these steps:

1. **Install Truffle** (if not installed):
   ```bash
   $ npm install -g truffle
   ```

2. **Install Ganache**:
   ```bash
    npm install -g ganache
    ganache
   ```

3. **Navigate to the Solidity branch**:
   ```bash
   $ git checkout solidity
   ```

4. **Install dependencies**:
   ```bash
    npm install
   ```

5. **Compile the smart contracts**:
   ```bash
    truffle compile
   ```

6. **Migrate the contracts** to the Ganache blockchain:
   ```bash
    truffle migrate
   ```

7. **Test the contracts** (optional):
   ```bash
    truffle test
   ```

### Setting Up the Backend
Switch to the `nodejs` branch and follow these steps:

1. **Navigate to the Node.js branch**:
   ```bash
    git checkout nodejs
   ```

2. **Install dependencies**:
   ```bash
    npm install
   ```

3. **Create a `.env` file** and add the required environment variables (example):
   ```env
   GANACHE_URL=http://127.0.0.1:8545
   CONTRACT_ADDRESS=<your deployed contract address>
   ADMIN_PRIVATE_KEY=<your admin private key>
   ABI_PATH=./VotingABI.json

   ```

4. **Start the backend server**:
   ```bash
    npx nodemon app
   ```

### Setting Up the Frontend
Switch to the `flutter_app` branch and follow these steps:

1. **Install Flutter** (if not installed):
   - [Install Flutter](https://docs.flutter.dev/get-started/install).

2. **Navigate to the Flutter branch**:
   ```bash
    git checkout flutter_app
   ```

3. **Install dependencies**:
   ```bash
    flutter pub get
   ```

4. **Run the Flutter app**:
   ```bash
    flutter run
   ```

## Project Structure

### Solidity (`solidity` branch)
Contains the smart contracts for the voting system. These contracts manage the voting logic and interaction with the blockchain.

### Node.js (`nodejs` branch)
Serves as the backend, handling API requests and interacting with the deployed smart contracts.

### Flutter (`flutter_app` branch)
Provides the user interface for voters. Users can vote and view results directly through this app.

## Key Features

- **Secure Voting**: Utilizes blockchain for transparency and immutability.
- **Cross-Platform**: Frontend works seamlessly on Android and iOS.
- **Local Blockchain**: Use Ganache for testing and development.

## Contributing

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-name`).
3. Commit your changes (`git commit -m "Add feature"`).
4. Push to the branch (`git push origin feature-name`).
5. Open a Pull Request.

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contact
For any questions or collaboration, reach out to Germain Syncher at [germainconnected@gmail.com](mailto:germainconnected@gmail.com).
