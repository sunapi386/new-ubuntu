# this is not a script that can be run, use it for references to setup a cardano stake pool, using (mostly) fish shell
# https://www.coincashew.com/coins/overview-ada/guide-how-to-build-a-haskell-stakepool-node

# 0 pre-reqs

sudo adduser cardano
# 1CoinMaster
sudo usermod -aG sudo cardano
sudo visudo
# cardano  ALL=(ALL) NOPASSWD:ALL
sudo chsh -s (which fish) cardano
sudo su - cardano


sudo apt-get update -y
sudo apt-get install automake build-essential pkg-config libffi-dev libgmp-dev libssl-dev libtinfo-dev libsystemd-dev zlib1g-dev make g++ tmux git jq wget libncursesw5 libtool autoconf -y

# on raspi




# install haskell
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

# should work now
source ~/.config/fish/config.fish
ghcup --version
ghcup install ghc 8.10.4
ghcup set ghc 8.10.4
ghcup install cabal 3.4.0.0
ghcup set cabal 3.4.0.0

# should show the expected version
ghc --version
cabal --version

# build libsodium
mkdir -p $HOME/cardano-src
cd $HOME/cardano-src
git clone https://github.com/input-output-hk/libsodium
cd libsodium
git checkout 66f017f1
./autogen.sh
./configure
make
sudo make install

# ----------------------------------------------------------------------
# Libraries have been installed in:
#    /usr/local/lib

# If you ever happen to want to link against installed libraries
# in a given directory, LIBDIR, you must either use libtool, and
# specify the full pathname of the library, or use the '-LLIBDIR'
# flag during linking and do at least one of the following:
#    - add LIBDIR to the 'LD_LIBRARY_PATH' environment variable
#      during execution
#    - add LIBDIR to the 'LD_RUN_PATH' environment variable
#      during linking
#    - use the '-Wl,-rpath -Wl,LIBDIR' linker flag
#    - have your system administrator add LIBDIR to '/etc/ld.so.conf'

# See any operating system documentation about shared libraries for
# more information, such as the ld(1) and ld.so(8) manual pages.

# 1 build cardano-node
cd $HOME/cardano-src
git clone https://github.com/input-output-hk/cardano-node.git
cd cardano-node
git fetch --all --recurse-submodules --tags
git checkout (curl -s https://api.github.com/repos/input-output-hk/cardano-node/releases/latest | jq -r .tag_name)
cabal configure --with-compiler=ghc-8.10.4
cabal build cardano-node cardano-cli

# move artifacts to $HOME/.local/bin directory
mkdir -p $HOME/.local/bin
# cp -p (./scripts/bin-path.sh cardano-node) $HOME/.local/bin/
# cp -p (./scripts/bin-path.sh cardano-cli) $HOME/.local/bin/

cp -p (./scripts/bin-path.sh cardano-node) /usr/local/bin/
cp -p (./scripts/bin-path.sh cardano-cli) /usr/local/bin/

# config
set FISH_CONFIG $HOME/.config/fish/config.fish
echo "set -gx PATH $HOME/.local/bin/ $PATH" >> $FISH_CONFIG
echo "set -gx CNODE_HOME $HOME/cnode" >> $FISH_CONFIG
echo "set -gx CNODE_CONFIG mainnet" >> $FISH_CONFIG
echo "set -gx CARDANO_NODE_SOCKET_PATH $CNODE_HOME/db/socket" >> $FISH_CONFIG
source $FISH_CONFIG

# Check the version that has been installed
cardano-cli --version
cardano-node --version


mkdir $CNODE_HOME
cd $CNODE_HOME
wget -N https://hydra.iohk.io/job/Cardano/cardano-node/cardano-deployment/latest-finished/download/1/$CNODE_CONFIG-config.json
wget -N https://hydra.iohk.io/job/Cardano/cardano-node/cardano-deployment/latest-finished/download/1/$CNODE_CONFIG-byron-genesis.json
wget -N https://hydra.iohk.io/job/Cardano/cardano-node/cardano-deployment/latest-finished/download/1/$CNODE_CONFIG-shelley-genesis.json
wget -N https://hydra.iohk.io/job/Cardano/cardano-node/cardano-deployment/latest-finished/download/1/$CNODE_CONFIG-alonzo-genesis.json
wget -N https://hydra.iohk.io/job/Cardano/cardano-node/cardano-deployment/latest-finished/download/1/$CNODE_CONFIG-topology.json

# in mainnet-config.json update TraceBlockFetchDecisions to true
sed -i $CNODE_CONFIG-config.json -e "s/TraceBlockFetchDecisions\": false/TraceBlockFetchDecisions\": true/g"

#  Tip for relay nodes: It's possible to reduce the number of missed slot
#  leader checks, memory and cpu usage by setting "TraceMempool" to "false"
#  in mainnet-config.jsonSide effects of TraceMempool = falsegLiveView will
#  show 0 for transactions processedIf your block producer is configured this
#  way, troubleshooting topology / firewall / transaction processing issues
#  may be harder to diagnose and identify. For block producer nodes, it is
#  considered best practice to keep TraceMempool as true.


### Edit the hosts file on producer and relay so they have alias for each other


### ON THE BLOCK PRODUCER NODE
echo '{
  "Producers": [
    {
      "addr": "relay1",
      "port": 6000,
      "valency": 1
    }
  ]
}' > $CNODE_HOME/$CNODE_CONFIG-topology.json
echo $CNODE_HOME/$CNODE_CONFIG-topology.json
echo --------------
cat $CNODE_HOME/$CNODE_CONFIG-topology.json

### ON THE RELAY NODE 1
echo '
{
  "Producers": [
    {
      "addr": "producer1",
      "port": 6000,
      "valency": 1
    },
    {
      "addr": "relays-new.cardano-mainnet.iohk.io",
      "port": 3001,
      "valency": 2
    }
  ]
}
' > $CNODE_HOME/$CNODE_CONFIG-topology.json

echo $CNODE_HOME/$CNODE_CONFIG-topology.json
echo --------------
cat $CNODE_HOME/$CNODE_CONFIG-topology.json


### ON THE AIR-GAP MACHINE todo: compile the ARM binary
set FISH_CONFIG $HOME/.config/fish/config.fish
echo "set -gx CNODE_HOME $HOME/cnode" >> $FISH_CONFIG
source $FISH_CONFIG
mkdir -p $CNODE_HOME

# 7. Create startup scripts
### Block Producer
echo "#!/usr/bin/env fish
set -l CNODE_HOME   $HOME/cnode
set -l CNODE_CONFIG mainnet
set -l PORT         6000
set -l HOSTADDR     0.0.0.0
set -l TOPOLOGY     $CNODE_HOME/$CNODE_CONFIG-topology.json
set -l DB_PATH      $CNODE_HOME/db
set -l SOCKET_PATH  $CNODE_HOME/db/socket
set -l CONFIG       $CNODE_HOME/$CNODE_CONFIG-config.json

echo CNODE_HOME=$CNODE_HOME
echo PORT=$PORT
echo HOSTADDR=$HOSTADDR
echo TOPOLOGY=$TOPOLOGY
echo DB_PATH=$DB_PATH
echo SOCKET_PATH=$SOCKET_PATH
echo CONFIG=$CONFIG

cardano-node run +RTS -N -A16m -qg -qb -RTS \
  --topology $TOPOLOGY \
  --database-path $DB_PATH \
  --socket-path $SOCKET_PATH \
  --host-addr $HOSTADDR \
  --port $PORT \
  --config $CONFIG
" >  $CNODE_HOME/startBlockProducingNode1.fish
chmod +x $CNODE_HOME/startBlockProducingNode1.fish

## Relay
echo "#!/usr/bin/env fish
set -l CNODE_HOME   $HOME/cnode
set -l CNODE_CONFIG mainnet
set -l PORT         6000
set -l HOSTADDR     0.0.0.0
set -l TOPOLOGY     $CNODE_HOME/$CNODE_CONFIG-topology.json
set -l DB_PATH      $CNODE_HOME/db
set -l SOCKET_PATH  $CNODE_HOME/db/socket
set -l CONFIG       $CNODE_HOME/$CNODE_CONFIG-config.json

echo CNODE_HOME=$CNODE_HOME
echo PORT=$PORT
echo HOSTADDR=$HOSTADDR
echo TOPOLOGY=$TOPOLOGY
echo DB_PATH=$DB_PATH
echo SOCKET_PATH=$SOCKET_PATH
echo CONFIG=$CONFIG


cardano-node run +RTS -N -A16m -qg -qb -RTS \
  --topology $TOPOLOGY \
  --database-path $DB_PATH \
  --socket-path $SOCKET_PATH \
  --host-addr $HOSTADDR \
  --port $PORT \
  --config $CONFIG
" >  $CNODE_HOME/startRelayNode1.fish
chmod +x $CNODE_HOME/startRelayNode1.fish



# Service
echo "# The Cardano node service (part of systemd)
# file: /etc/systemd/system/cardano-node.service
[Unit]
Description     = Cardano node service
Wants           = network-online.target
After           = network-online.target
[Service]
User            = $USER
Type            = simple
WorkingDirectory= $CNODE_HOME

ExecStart       = $CNODE_HOME/startBlockProducingNode1.fish
# or
# ExecStart       = $CNODE_HOME/startRelayNode1.fish

KillSignal=SIGINT
RestartKillSignal=SIGINT
TimeoutStopSec=300
LimitNOFILE=32768
Restart=always
RestartSec=5
SyslogIdentifier=cardano-node
[Install]
WantedBy  = multi-user.target" > $CNODE_HOME/cardano-node.service
sudo mv $CNODE_HOME/cardano-node.service /etc/systemd/system/cardano-node.service
sudo systemctl daemon-reload
sudo systemctl enable cardano-node

# 8 start the nodes
sudo systemctl start cardano-node
systemctl status cardano-node

# journalctl -f



# Install gLiveView, a monitoring tool.
cd $CNODE_HOME
sudo apt install bc tcptraceroute -y
curl -s -o gLiveView.sh https://raw.githubusercontent.com/cardano-community/guild-operators/master/scripts/cnode-helper-scripts/gLiveView.sh
curl -s -o env https://raw.githubusercontent.com/cardano-community/guild-operators/master/scripts/cnode-helper-scripts/env
chmod 755 gLiveView.sh
./gLiveView.sh




########
#  9. Generate block-producer keys The block-producer node requires you to
#  create 3 keys as defined in the Shelley ledger specs:
# stake pool cold key (node.cert)
# stake pool hot key (kes.skey)
# stake pool VRF key (vrf.skey)
# First, make a KES key pair.

# producer
# in:
# out:  kes.vkey kes.skey
# Copy kes.vkey to your cold environment.

cd $CNODE_HOME
cardano-cli node key-gen-KES \
    --verification-key-file kes.vkey \
    --signing-key-file kes.skey


# air-gapped
mkdir $HOME/cold-keys
pushd $HOME/cold-keys
# in:
# out:  node.vkey node.skey node.counter
cardano-cli node key-gen \
    --cold-verification-key-file $HOME/cold-keys/node.vkey \
    --cold-signing-key-file $HOME/cold-keys/node.skey \
    --operational-certificate-issue-counter node.counter


# producer: Determine the number of slots per KES period from the genesis file.
function calc_kesPeriod
  set -l slotsPerKESPeriod (jq -r '.slotsPerKESPeriod' $CNODE_HOME/$CNODE_CONFIG-shelley-genesis.json)
  set -l slotNo (cardano-cli query tip --mainnet | jq -r '.slot')
  set -l kesPeriod (math -s0 $slotNo / $slotsPerKESPeriod)
  set -l startKesPeriod $kesPeriod
  echo startKesPeriod = $kesPeriod
end

# air-gapped
# in:   kes.vkey node.skey node.counter
# out:  node.cert
# Copy node.cert to your hot environment.
cardano-cli node issue-op-cert \
    --kes-verification-key-file kes.vkey \
    --cold-signing-key-file $HOME/cold-keys/node.skey \
    --operational-certificate-issue-counter $HOME/cold-keys/node.counter \
    --kes-period $startKesPeriod \
    --out-file node.cert

# producer
# in:
# out:  vrf.vkey vrf.skey
# copy vrf.vkey to your cold environment.
cardano-cli node key-gen-VRF \
    --verification-key-file vrf.vkey \
    --signing-key-file vrf.skey

chmod 400 vrf.skey

# update systemd script

#!/usr/bin/env fish
# this is used by systemd to start the cardano-node service
set -l CNODE_HOME   $HOME/cnode
set -l CNODE_CONFIG mainnet
set -l PORT         6000
set -l HOSTADDR     0.0.0.0
set -l TOPOLOGY     $CNODE_HOME/mainnet-topology.json
set -l DB_PATH      $CNODE_HOME/db
set -l SOCKET_PATH  $CNODE_HOME/db/socket
set -l CONFIG       $CNODE_HOME/mainnet-config.json
set -l KES          $CNODE_HOME/kes.skey
set -l VRF          $CNODE_HOME/vrf.skey
set -l CERT         $CNODE_HOME/node.cert

echo CNODE_HOME=$CNODE_HOME
echo PORT=$PORT
echo HOSTADDR=$HOSTADDR
echo TOPOLOGY=$TOPOLOGY
echo DB_PATH=$DB_PATH
echo SOCKET_PATH=$SOCKET_PATH
echo CONFIG=$CONFIG
echo KES=$KES
echo VRF=$VRF
echo CERT=$CERT

cardano-node run +RTS -N -A16m -qg -qb -RTS \
--topology $TOPOLOGY \
--database-path $DB_PATH \
--socket-path $SOCKET_PATH \
--host-addr $HOSTADDR \
--port $PORT \
--config $CONFIG \
--shelley-kes-key $KES \
--shelley-vrf-key $VRF \
--shelley-operational-certificate $CERT


sudo systemctl restart cardano-node


# 10 setup payment and stake keys

# producer
cd $CNODE_HOME
cardano-cli query protocol-parameters \
    --mainnet \
    --out-file params.json


# create your payment and stake key pair
# payment and stake keys must be generated and
# used to build transactions in an cold environment.

# The only steps performed online in a hot environment are those steps that
# require live data. Namely the follow type of steps:
# - querying the current slot
# - querying the balance of an address
# - submitting a transaction

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# mnemonic method
###
### On block producer node,
###
cd $HOME/air-gap
wget https://hydra.iohk.io/build/3662127/download/1/cardano-wallet-shelley-2020.7.28-linux64.tar.gz
echo "f75e5b2b4cc5f373d6b1c1235818bcab696d86232cb2c5905b2d91b4805bae84 *cardano-wallet-shelley-2020.7.28-linux64.tar.gz" | shasum -a 256 --check
###
### On air-gapped offline machine,
###
tar -xvf cardano-wallet-shelley-2020.7.28-linux64.tar.gz
rm cardano-wallet-shelley-2020.7.28-linux64.tar.gz
# Create extractPoolStakingKeys.sh
chmod +x extractPoolStakingKeys.sh
# bash
# export PATH="(pwd)/cardano-wallet-shelley-2020.7.28:$PATH"
# ./extractPoolStakingKeys.sh extractedPoolKeys/ <15|24-word length mnemonic>
# Your new staking keys are in the folder extractedPoolKeys/
cd extractedPoolKeys/
mkdir ../extractedPoolKeysPub
cp stake.vkey stake.skey stake.addr payment.vkey payment.skey base.addr ../extractedPoolKeysPub
cd ../extractedPoolKeysPub
#Rename to base.addr file to payment.addr
mv base.addr payment.addr

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# CLI method

# air-gapped
###
### On air-gapped offline machine,
###
cd $CNODE_HOME
# out:  payments.vkey payments.skey
cardano-cli address key-gen \
    --verification-key-file payment.vkey \
    --signing-key-file payment.skey
# out: stake.skey & stake.vkey
cardano-cli stake-address key-gen \
    --verification-key-file stake.vkey \
    --signing-key-file stake.skey
# out: stake.addr
cardano-cli stake-address build \
    --stake-verification-key-file stake.vkey \
    --out-file stake.addr \
    --mainnet
# out: payment.addr
cardano-cli address build \
    --payment-verification-key-file payment.vkey \
    --stake-verification-key-file stake.vkey \
    --out-file payment.addr \
    --mainnet

mv payment.skey payment.vkey stake.vkey stake.skey stake.addr payment.addr ../air-gap
# Copy payment.addr to your hot environment
cp ../air-gap/payment.addr $CNODE_HOME


# Fund your account payment address balance. Send money in and out.
# E.g.
# 4 ADA => addr1q8vczftecp45segsjvy2pk3fz3zc6s02np3d4ukyc7wp3dp6mhxrefruqptr93usqs0eqqlluueulx5ee8zd9xyq95mq4qqs5q
# => 2 ADA
# 1 => 1 self
cardano-cli query utxo \
    --address (cat payment.addr) \
    --mainnet

# 11 register stake address

# air-gapped
# in:   stake.vkey
# out:  stake.cert
# copy stake.cert to hot
cardano-cli stake-address registration-certificate \
    --stake-verification-key-file stake.vkey \
    --out-file stake.cert

# You need to find the tip of the blockchain to set the invalid-hereafter parameter properly.
set currentSlot (cardano-cli query tip --mainnet | jq -r '.slot')

##############################################v#######################v#######################v
# find your balance and utxos
cardano-cli query utxo \
    --address (cat payment.addr) \
    --mainnet > fullUtxo.out
tail -n +3 fullUtxo.out | sort -k3 -nr > balance.out
cat balance.out
set tx_in ""
set total_balance 0
while read utxo;
    set in_addr (echo $utxo | awk '{ print $1 }')
    set idx (echo $utxo | awk '{ print $2 }')
    set utxo_balance (echo $utxo | awk '{ print $3 }')
    set total_balance (math $total_balance + $utxo_balance)
    echo TxHash: $in_addr#$idx ADA: $utxo_balance
    set tx_in "$tx_in --tx-in $in_addr#$idx"
end < balance.out
set txcnt (cat balance.out | wc -l)
echo Total ADA balance: $total_balance
echo Number of UTXOs: $txcnt
echo tx_in: $tx_in

# e.g.
# c506d01234e190dcb610fbdfdd064dd31d7d118569e36a2e4085985d9a5253fa     0        1000000 lovelace + TxOutDatumNone
# in_addr,  idx,  utxo_balance


# find stake deposit value
set stakeAddressDeposit (cat $CNODE_HOME/params.json | jq -r '.stakeAddressDeposit')
echo stakeAddressDeposit : $stakeAddressDeposit

# costs 2 ADA to register a stake address

# build-raw transaction on producer
cardano-cli transaction build-raw \
    $tx_in \  # there's some string parsing issue w fish here
    --tx-out (cat payment.addr)+0 \
    --invalid-hereafter (math $currentSlot + 10000) \
    --fee 0 \
    --out-file tx.tmp \
    --certificate stake.cert

set fee (cardano-cli transaction calculate-min-fee \
    --tx-body-file tx.tmp \
    --tx-in-count $txcnt \
    --tx-out-count 1 \
    --mainnet \
    --witness-count 2 \
    --byron-witness-count 0 \
    --protocol-params-file params.json | awk '{ print $1 }')
echo fee: $fee

# Ensure your balance is greater than cost of fee + stakeAddressDeposit or this will not work.
# calc change output
set txOut (math $total_balance-$stakeAddressDeposit-$fee)
echo Change Output: $txOut

# Build your transaction which will register your stake address.
cardano-cli transaction build-raw \
    $tx_in \
     # --tx-in d340ada8ee462243d9418feb3b2e3c55a08f4f1ab5e769de082cbde8f1d93517#0 --tx-in c506d01234e190dcb610fbdfdd064dd31d7d118569e36a2e4085985d9a5253fa#0 \
    --tx-out (cat payment.addr)+$txOut \
    --invalid-hereafter (math $currentSlot + 10000) \
    --fee $fee \
    --certificate-file stake.cert \
    --out-file tx.raw

# copy tx.raw to cold env to sign w payment and stake secret keys
# out: tx.signed
cardano-cli transaction sign \
    --tx-body-file tx.raw \
    --signing-key-file payment.skey \
    --signing-key-file stake.skey \
    --mainnet \
    --out-file tx.signed

# submit signed transaction
cardano-cli transaction submit \
    --tx-file tx.signed \
    --mainnet

# 12 Register your stake pool
# description cannot exceed 255 characters in length.
# ticker must be between 3-5 characters in length. Characters must be A-Z and 0-9 only.
echo '
{
"name": "The Example Pool",
"description": "Blah.",
"ticker": "ABCDE",
"homepage": "https://example.com"
}
' > poolMetaData.json

# Calculate the hash of your metadata file. It's saved to poolMetaDataHash.txt
cardano-cli stake-pool metadata-hash --pool-metadata-file poolMetaData.json > poolMetaDataHash.txt

# Copy poolMetaDataHash.txt to your air-gapped offline machine, cold environment.

# https://example.com/poolMetaData.json
cardano-cli stake-pool metadata-hash --pool-metadata-file <(curl -s -L https://example.com/poolMetaData.json)

# find min pool cost
set minPoolCost (cat $CNODE_HOME/params.json | jq -r .minPoolCost)
echo minPoolCost: $minPoolCost

# create registration certificate for pool
# air-gapped
# pledging 100 ADA
# 0% pool margin
# 340 ADA / epoch fixed fee
# Copy pool.cert to your hot environment.
cardano-cli stake-pool registration-certificate \
    --cold-verification-key-file $HOME/secret/cold-keys/node.vkey \
    --vrf-verification-key-file $HOME/secret/air-gap/vrf.vkey \
    --pool-pledge 100000000 \
    --pool-cost 340000000 \
    --pool-margin 0.00 \
    --pool-reward-account-verification-key-file $HOME/secret/extractedPoolKeysPub_mnemonic_1/stake.vkey \
    --pool-owner-stake-verification-key-file $HOME/secret/extractedPoolKeysPub_mnemonic_1/stake.vkey \
    --mainnet \
    --single-host-pool-relay relay1.example.com \
    --pool-relay-port 6000 \
    --metadata-url example.com/poolMetaData.json \
    --metadata-hash (cat $HOME/poolMetaDataHash.txt) \
    --out-file $HOME/pool.cert

# Pledge stake to your stake pool.
cardano-cli stake-address delegation-certificate \
    --stake-verification-key-file $HOME/secret/extractedPoolKeysPub_mnemonic_1/stake.vkey \
    --cold-verification-key-file $HOME/secret/cold-keys/node.vkey \
    --out-file $HOME/deleg.cert

# find the deposit fee for a pool
set stakePoolDeposit (cat $CNODE_HOME/params.json | jq -r '.stakePoolDeposit')
echo stakePoolDeposit: $stakePoolDeposit

# build raw transaction
cardano-cli transaction build-raw \
    --tx-in 2cc3f8e7d54ef9427aee3195795c14bd78fa1e550ee34eae9093106345cf2d9f#0 --tx-in 374bdf329fc70f48e89e6793fabe4311c61dd28c6361bb502af373bbc362e240#0 \
    --tx-out (cat payment.addr)+(math $total_balance - $stakePoolDeposit)  \
    --invalid-hereafter (math $currentSlot + 10000) \
    --fee 0 \
    --certificate-file pool.cert \
    --certificate-file deleg.cert \
    --out-file tx.tmp


# calc min fee
set fee (cardano-cli transaction calculate-min-fee \
    --tx-body-file tx.tmp \
    --tx-in-count $txcnt \
    --tx-out-count 1 \
    --mainnet \
    --witness-count 3 \
    --byron-witness-count 0 \
    --protocol-params-file params.json | awk '{ print $1 }')
echo fee: $fee

# calc change output
set txOut (math $total_balance - $stakePoolDeposit - $fee)
echo $txOut

# build transaction
cardano-cli transaction build-raw \
    # $tx_in \
    --tx-in 2cc3f8e7d54ef9427aee3195795c14bd78fa1e550ee34eae9093106345cf2d9f#0 --tx-in 374bdf329fc70f48e89e6793fabe4311c61dd28c6361bb502af373bbc362e240#0 \
    --tx-out (cat payment.addr)+$txOut \
    --invalid-hereafter (math $currentSlot + 10000) \
    --fee $fee \
    --certificate-file pool.cert \
    --certificate-file deleg.cert \
    --out-file tx.raw

# sign transaction on air-gapped machine
cardano-cli transaction sign \
    --tx-body-file tx.raw \
    --signing-key-file ~/secret/extractedPoolKeysPub_mnemonic_1/payment.skey \
    --signing-key-file ~/secret/cold-keys/node.skey \
    --signing-key-file ~/secret/extractedPoolKeysPub_mnemonic_1/stake.skey \
    --mainnet \
    --out-file tx.signed

# Send the transaction.
cardano-cli transaction submit \
    --tx-file tx.signed \
    --mainnet

# 13 Locate your Stake pool ID and verify everything is working
# Your stake pool ID can be computed with:
# air-gapped
cardano-cli stake-pool id --cold-verification-key-file $HOME/cold-keys/node.vkey --output-format hex > stakepoolid.txt
cat stakepoolid.txt
# copy stakepoolid.txt to hot

# verify stakepool id is in blockchain
cardano-cli query stake-snapshot --stake-pool-id (cat stakepoolid.txt) --mainnet
# 07c3280a92a3010a1713e3cb22bfa82624a33061ad20c7b359e7252d
# A non-empty string return means you're registered!
# {
#     "poolStakeGo": 0,
#     "activeStakeGo": 23849267970809683,
#     "activeStakeMark": 23854747611964258,
#     "poolStakeMark": 0,
#     "activeStakeSet": 23856125875170714,
#     "poolStakeSet": 0
# }

#  14. Configure your topology files

# Shelley has been launched without peer-to-peer (p2p) node discovery so that
# means we will need to manually add trusted nodes in order to configure our
# topology. This is a critical step as skipping this step will result in your
# minted blocks being orphaned by the rest of the network.

###
### On relaynode1

#!/usr/bin/env fish

set USERNAME cardano
set CNODE_PORT 6000 # must match your relay node port as set in the startup command
set CNODE_HOSTNAME "relay1.example.com"  # optional. must resolve to the IP you are requesting from
set CNODE_BIN "/usr/local/bin"
set CNODE_HOME /home/cardano/cnode
set CNODE_LOG_DIR "$CNODE_HOME/logs"
set NODE_CONFIG mainnet
set GENESIS_JSON "$CNODE_HOME/$NODE_CONFIG-shelley-genesis.json"
set NETWORKID (jq -r .networkId $GENESIS_JSON)
set CNODE_VALENCY 1   # optional for multi-IP hostnames
set NWMAGIC (jq -r .networkMagic $GENESIS_JSON)


echo USERNAME=$USERNAME
echo CNODE_PORT=$CNODE_PORT
echo CNODE_HOSTNAME=$CNODE_HOSTNAME
echo CNODE_BIN=$CNODE_BIN
echo CNODE_HOME=$CNODE_HOME
echo CNODE_LOG_DIR=$CNODE_LOG_DIR
echo NODE_CONFIG=$NODE_CONFIG
echo GENESIS_JSON=$GENESIS_JSON
echo NETWORKID=$NETWORKID
echo CNODE_VALENCY=$CNODE_VALENCY
echo NWMAGIC=$NWMAGIC

if [ "$NETWORKID" = "Mainnet" ]
  set HASH_IDENTIFIER "--mainnet"
else
  set HASH_IDENTIFIER "--testnet-magic $NWMAGIC"
end
if [ "$NWMAGIC" = "764824073" ]
  set NETWORK_IDENTIFIER "--mainnet"
else
  set NETWORK_IDENTIFIER "--testnet-magic $NWMAGIC"
end
echo HASH_IDENTIFIER=$HASH_IDENTIFIER
echo NETWORK_IDENTIFIER=$NETWORK_IDENTIFIER


set PATH $CNODE_BIN $PATH
set CARDANO_NODE_SOCKET_PATH $CNODE_HOME/db/socket
echo PATH=$PATH
echo CARDANO_NODE_SOCKET_PATH=$CARDANO_NODE_SOCKET_PATH


set blockNo (cardano-cli query tip $NETWORK_IDENTIFIER | jq -r .block )
echo blockNo=$blockNo

# Note:
# if you run your node in IPv4/IPv6 dual stack network configuration and want announced the
# IPv4 address only please add the -4 parameter to the curl command below  (curl -4 -s ...)
if [ "$CNODE_HOSTNAME" != "HP-EliteBook-850-G5" ]
  set T_HOSTNAME "&hostname=$CNODE_HOSTNAME"
else
  set T_HOSTNAME ''
end
echo T_HOSTNAME=$T_HOSTNAME

if [ ! -d $CNODE_LOG_DIR ]; then
  mkdir -p $CNODE_LOG_DIR;
end

curl -4 -s "https://api.clio.one/htopology/v1/?port=$CNODE_PORT&blockNo=$blockNo&valency=$CNODE_VALENCY&magic=$NWMAGIC$T_HOSTNAME" | tee -a $CNODE_LOG_DIR/topologyUpdater_lastresult.json | jq .

# {
#   "resultcode": "201",
#   "datetime": "2021-11-24 04:37:10",
#   "clientIp": "1.2.242.190",
#   "iptype": 4,
#   "msg": "nice to meet you"
# }

# Every time the script runs and updates your IP, a log is created in $CNODE_HOME/logs



### add permission and run
### On relaynode1
###
cd $CNODE_HOME
chmod +x topologyUpdater.sh
./topologyUpdater.sh

### On relaynode1Add a crontab job to automatically run topologyUpdater.sh
#   every hour on the 33rd minute. You can change the 33 value to your own
#   preference.
###
echo "33 * * * * $CNODE_HOME/topologyUpdater.fish" > $CNODE_HOME/crontab-fragment.txt
crontab -l | cat - $CNODE_HOME/crontab-fragment.txt > $CNODE_HOME/crontab.txt; and crontab $CNODE_HOME/crontab.txt
rm $CNODE_HOME/crontab-fragment.txt

# Complete this section after four hours when your relay node IP is properly registered.
### On relaynode1
echo
#!/usr/bin/env fish
set BLOCKPRODUCING_IP relay1.example.com
set BLOCKPRODUCING_PORT 6000
set CNODE_CONFIG mainnet
cp $CNODE_HOME/$CNODE_CONFIG-topology.json $CNODE_HOME/$CNODE_CONFIG-topology.json.bak
echo curl -s "https://api.clio.one/htopology/v1/fetch/?max=20&customPeers=$BLOCKPRODUCING_IP:$BLOCKPRODUCING_PORT:1|relays-new.cardano-mainnet.iohk.io:3001:2"
curl -s  "https://api.clio.one/htopology/v1/fetch/?max=20&customPeers=$BLOCKPRODUCING_IP:$BLOCKPRODUCING_PORT:1|relays-new.cardano-mainnet.iohk.io:3001:2"  | jq .
# curl -s -o $CNODE_HOME/$CNODE_CONFIG-topology.json "https://api.clio.one/htopology/v1/fetch/?max=20&customPeers=$BLOCKPRODUCING_IP:$BLOCKPRODUCING_PORT:1|relays-new.cardano-mainnet.iohk.io:3001:2"
' >  $CNODE_HOME/relay-topology_pull.sh
