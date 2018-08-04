echo "=== bootstrap the broadbeach blockchain ==="

# create wallets
echo "" > passwords.txt 
docker exec -it eosio_notechain_container /opt/eosio/bin/cleos -u http://127.0.0.1:8888 --wallet-url http://127.0.0.1:8888 wallet create -n broadbeach.wallet >> passwords.txt
docker exec -it eosio_notechain_container /opt/eosio/bin/cleos -u http://127.0.0.1:8888 --wallet-url http://127.0.0.1:8888 wallet create -n eosio.token.wallet >> passwords.txt
docker exec -it eosio_notechain_container /opt/eosio/bin/cleos -u http://127.0.0.1:8888 --wallet-url http://127.0.0.1:8888 wallet create -n default >> passwords.txt

# import private key
# privkey: 5KAYpjquftq9XWBYcJWE4TJH4opqAHnHR9M5mNQMgf9Lq6igbMQ
# pubkey: EOS5r8tzA4LwrEVa5HLeb1vwc5FqMkQWRzfZpce6FWqDWS6kusuMo
docker exec -it eosio_notechain_container /opt/eosio/bin/cleos -u http://127.0.0.1:8888 --wallet-url http://127.0.0.1:8888 wallet import -n broadbeach.wallet --private-key  5KAYpjquftq9XWBYcJWE4TJH4opqAHnHR9M5mNQMgf9Lq6igbMQ

# privkey: 5KHbmEKFbavWVhhMR8wRPdyJ7eqTaCNaZoqur24HSeGfvubzADG
# pubkey: EOS6wf4gLzzNvskvQJ6X5eeseCaxmksYpyb4rxM56xKxDT9pY9uuM
docker exec -it eosio_notechain_container /opt/eosio/bin/cleos -u http://127.0.0.1:8888 --wallet-url http://127.0.0.1:8888 wallet import -n eosio.token.wallet --private-key 5KHbmEKFbavWVhhMR8wRPdyJ7eqTaCNaZoqur24HSeGfvubzADG

# privkey: 5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3 (eosio key)
# pubkey: EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV
docker exec -it eosio_notechain_container /opt/eosio/bin/cleos -u http://127.0.0.1:8888 --wallet-url http://127.0.0.1:8888 wallet import -n default --private-key 5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3

# create accounts
docker exec -it eosio_notechain_container /opt/eosio/bin/cleos -u http://127.0.0.1:8888 --wallet-url http://127.0.0.1:8888 create account eosio eosio.token EOS6wf4gLzzNvskvQJ6X5eeseCaxmksYpyb4rxM56xKxDT9pY9uuM
docker exec -it eosio_notechain_container /opt/eosio/bin/cleos -u http://127.0.0.1:8888 --wallet-url http://127.0.0.1:8888 create account eosio broadbeach EOS5r8tzA4LwrEVa5HLeb1vwc5FqMkQWRzfZpce6FWqDWS6kusuMo

# publish contract eosio.token to account eosio.token 
docker exec -it eosio_notechain_container /opt/eosio/bin/cleos -u http://127.0.0.1:8888 --wallet-url http://127.0.0.1:8888 set contract eosio.token /contracts/eosio.token -p eosio.token

# create the tokens with permission of eosio.token
docker exec -it eosio_notechain_container /opt/eosio/bin/cleos -u http://127.0.0.1:8888 --wallet-url http://127.0.0.1:8888 push action eosio.token create '{"issuer":"eosio", "maximum_supply":"10000.0000 EOS"}' -p eosio.token@active

# issue all the tokens to broadbeach account
docker exec -it eosio_notechain_container /opt/eosio/bin/cleos -u http://127.0.0.1:8888 --wallet-url http://127.0.0.1:8888 push action eosio.token issue '[ "broadbeach", "10000.0000 EOS", "10,000 tokens issued to broadbeach" ]' -p eosio

# send tokens from broadbeach to supporter adam
docker exec -it eosio_notechain_container /opt/eosio/bin/cleos -u http://127.0.0.1:8888 --wallet-url http://127.0.0.1:8888 push action eosio.token transfer '["broadbeach", "adam", "100.0000 EOS", "testing"]' -p broadbeach

# send tokens from broadbeach to supporter bob
docker exec -it eosio_notechain_container /opt/eosio/bin/cleos -u http://127.0.0.1:8888 --wallet-url http://127.0.0.1:8888 push action eosio.token transfer '["broadbeach", "bob", "100.0000 EOS", "testing"]' -p broadbeach

