# Prerequisite/Installation

## Forge

```sh
curl -L https://foundry.paradigm.xyz | bash
```

then close terminal, reopen a new one and run : 

```sh
foundryup
```

then close terminal, reopen a new one and run : 

```sh
forge init
```

To init/setup a forge project


## Anvil

Anvil is like _Ganache_ : a local blockchain client.

To run _Anvil_, just run the following command : 

```sh
anvil
```

At the end on what anvil displays, we can see : 

```
Listening on 127.0.0.1:8545
```

We will need to do settings on your local network in Metamask

## Metamask

### Network

Configure a new network with values :

 - New RPC URL : _http://127.0.0.1:8545_
 - ChainID : Metmask is smart enough to suggest you the right ChainID

### Import account

After running the local blockchain Anvil, copy the private key #1 displayed by Anvil 
and import it in Metamask

# Compile a SC with Forge

In the _simple-storage_ directory, run the following command : 

```sh
forge compile
```

It will create the _out_ directory with the ABI of the SC

# Help on Forge commands

```sh
forge --help
```

For a help on specific command : 

```sh
forge <my_command> --help
```


# Deploy a SC with command line

```sh
forge create <My_Smarcontract> --interactive
```

It will ask you the private key.
This private key will be the deployer (=owner) of the SC.
So you can provide the private key #1 (the same you import in Metamask for instance).
After that, we can see for instance : 

```
[⠊] Compiling...
No files changed, compilation skipped
Enter private key: 
Deployer: 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
Deployed to: 0x5FbDB2315678afecb367f032d93F642f64180aa3
Transaction hash: 0x92996e5b54c61aa31edf704c3bbb75c040b32ac3c175c6a0279c456ca5fb7258
```

If we don't want the interactive mode, we can run the following command : 

```sh
forge create <My_Smarcontract> --rpc-url http://127.0.0.1:8545 --private-key <my_private_key>
```

where 127.0.0.1:8545 is the IP and port listened by Anvil.

But, it's NOT RECOMMENDED in production !!! Because we type the PK in clear text !!

Tip : To clear my bash history 

```sh
history -c
```

# Deploy a SC by scripting

## Create a script

Ex : _DeploySimpleStorage.s.sol_

The _.s_ before _.sol_ is a forge convention so it's mandatory to name scripts like this

## Deploy

```sh
forge script script/DeploySimpleStorage.s.sol --rpc-url http://127.0.0.1:8545 --broadcast --private-key <my_PK>
```

After that, we can see : 

```
[⠊] Compiling...
[⠊] Compiling 13 files with 0.8.20
[⠢] Solc 0.8.20 finished in 959.09ms
Compiler run successful!
Script ran successfully.

== Return ==
0: contract SimpleStorage 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512

EIP-3855 is not supported in one or more of the RPCs used.
Unsupported Chain IDs: 31337.
Contracts deployed with a Solidity version equal or higher than 0.8.20 might not work properly.
For more information, please see https://eips.ethereum.org/EIPS/eip-3855

## Setting up (1) EVMs.

==========================

Chain 31337

Estimated gas price: 5 gwei

Estimated total gas used for script: 117716

Estimated amount required: 0.00058858 ETH

==========================

###
Finding wallets for all the necessary addresses...
##
Sending transactions [0 - 0].
⠁ [00:00:00] [######################################################################################################################################################################] 1/1 txes (0.0s)
Transactions saved to: /home/gilles/DEV/Web3/SupDeVinci_Solidity_Foundry/simple-storage/broadcast/DeploySimpleStorage.s.sol/31337/run-latest.json

Sensitive values saved to: /home/gilles/DEV/Web3/SupDeVinci_Solidity_Foundry/simple-storage/cache/DeploySimpleStorage.s.sol/31337/run-latest.json

##
Waiting for receipts.
⠉ [00:00:00] [##################################################################################################################################################################] 1/1 receipts (0.0s)
##### anvil-hardhat
✅ Hash: 0x370702785e126c01405eaadc42d6bff53945ced560e173960adc2c033501e732
Contract Address: 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512
Block: 2
Paid: 0.000351007725220585 ETH (90565 gas * 3.875754709 gwei)


Transactions saved to: /home/gilles/DEV/Web3/SupDeVinci_Solidity_Foundry/simple-storage/broadcast/DeploySimpleStorage.s.sol/31337/run-latest.json

Sensitive values saved to: /home/gilles/DEV/Web3/SupDeVinci_Solidity_Foundry/simple-storage/cache/DeploySimpleStorage.s.sol/31337/run-latest.json



==========================

ONCHAIN EXECUTION COMPLETE & SUCCESSFUL.
Total Paid: 0.000351007725220585 ETH (90565 gas * avg 3.875754709 gwei)

Transactions saved to: /home/gilles/DEV/Web3/SupDeVinci_Solidity_Foundry/simple-storage/broadcast/DeploySimpleStorage.s.sol/31337/run-latest.json

Sensitive values saved to: /home/gilles/DEV/Web3/SupDeVinci_Solidity_Foundry/simple-storage/cache/DeploySimpleStorage.s.sol/31337/run-latest.json

```

## Deploy Results

The results of deploymùent can be visible in the _broadcast_ directory that has been generated.
Have a look on the _run-latest.json_ file and the _transaction[0].transaction_ entry.
The _data_ keyis the OPCode of the Tx.

## Deployment security

Run a deployment with the method above is OK in a _devlopment_ environment but not recommended in a _production_ environment.
To do it in a _production_ environment, we can use a _.env_ file.

Run : 

```sh
source .env
```

in order to persist key/value pairs of the .env file in the system.

then you can run : 

```sh
forge script script/DeploySimpleStorage.s.sol --rpc-url $RPC_URL --broadcast --private-key $PRIVATE_KEY
```

### Summarize

Do not use _.env_ file in a _production_ environment.
It's OK in _development_ environment.
Use _interactive_ mode in a _production_ environment instead.
Foundry intends to add a feature to encrypt the private key in a keypass file.
So you will need only a password to encrypt it.

One alternative to use a secure way to deploy your smart contract without exposing your PK 
is to use a tool like _thirdweb_

For instance, run : 

```sh
npx thirdweb deploy
```

An deploy it in Sepolia TestNet with Metamask by using the signed provided URL.

Explore what you can do with this fantastic tool : Thirdweb !

## Manipulate Smart Contract

Once the Smart contract is deployed (via thirdweb or another way),
we can call its function with _cast_ tool provide by _foundry_

For instance, to store a value by the _store_ function of the smart contract, run : 

```sh
cast send 0xfd87e6c145c608cf8443010d8596c51c26164505 "store(uint256)" 123 --rpc-url $RPC_URL --private-key $PRIVATE_KEY
```

where _0xfd87e6c145c608cf8443010d8596c51c26164505_ is the address of the smart contract.

Secondly, we can retrieve the value with the _retrieve_ function with that : 

```sh
cast call 0xfd87e6c145c608cf8443010d8596c51c26164505 "retrieve" 123 --rpc-url $RPC_URL --private-key $PRIVATE_KEY
```


# Deploy a SC with a RPC (Alchemy)

1) Signin/Signup in Alchemy (https://alchemy.com)
2) Create an App in Alchemy by choosing the rignt network (Sepolia)
3) Update your _.env_ file with the RPC URL of Alchemy and the private Key of one of your account in Metamask that have somme SepoliaETH
4) Reload env variables with the command _source .env_










