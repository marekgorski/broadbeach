# Demo
Inside the PITCH.md you'll find the demo steps, follow these to showcase the main points of the demo, which effectively are:
- Funding an individual directly
- Funding settings for passive funding

**all these are only on the local blockchain**


## Additions
The next set of items to add to the demo are:
* Ability to set passive funding options
* Ability to request initiative / zone funding


## Debugging


If the demo doesn't work as expected, you might have forgotten to **shut down the container** before running the start script,
in which case run the below:
```
docker stop eosio_notechain_container
```

You can then run the init_blockchain.sh script to initialise the local node of the blockchain as well as the wallets / contract / data.
