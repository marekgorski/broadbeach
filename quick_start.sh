#!/usr/bin/env bash

# # make sure everything is clean and well setup
./first_time_setup.sh

# # start blockchain and put in background
./start_eosio_docker.sh --nolog

# # bootstrap the broadbeach chain
./bootstrap_broadbeach.sh

# start frontend react app
./start_frontend.sh
