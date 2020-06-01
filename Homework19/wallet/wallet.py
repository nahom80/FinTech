import subprocess
import json
import os
from constants import BTC, BTCTEST, ETH
from pprint import pprint
from getpass import getpass
from pathlib import Path
from eth_account import Account
from bit import PrivateKeyTestnet
from bit.network import NetworkAPI
from web3 import Account,Web3, middleware
from web3.middleware import geth_poa_middleware
w3 = Web3(Web3.HTTPProvider(os.getenv('WEB3_PROVIDER', 'http://localhost:8545')))
w3.middleware_onion.inject(geth_poa_middleware, layer=0)

MNEMONIC = os.getenv("MNEMONIC")


def deriveWallets(coinType, numWallets, mnemonic):
    phpAndParams = f'php hd-wallet-derive-master\hd-wallet-derive.php --mnemonic="{mnemonic}" --numderive="{numWallets}" --coin="{coinType}" --format=json -g' 
    proc1 = subprocess.Popen(phpAndParams, shell=True,stdout=subprocess.PIPE)
    (output, err) = proc1.communicate()
    keyDicts = json.loads(output)
    return keyDicts

def create_eth_tx(account, recipient, amount):
    gasEstimate = w3.eth.estimateGas(
        {"from": account.address, "to": recipient, "value": amount}
    )
    return {
        "to": recipient,
        "from": account.address,
        "value": amount,
        "gas": gasEstimate,
        "gasPrice": w3.eth.gasPrice,
        "nonce": w3.eth.getTransactionCount(account.address)        
    }

def create_btc_tx(account, to, amount):
    return PrivateKeyTestnet.prepare_transaction(account.address, [(to, amount, BTC)])


def create_trx(account, to, amount,coin):
    if coin == ETH:
        return create_eth_tx(account,to,amount)
    elif coin == BTCTEST:
        return create_btc_tx(account, to, amount)


def send_tx_one(account, recipient, amount):
    tx = create_raw_tx(account, recipient, amount)
    signed_tx = account.sign_transaction(tx)
    result = w3.eth.sendRawTransaction(signed_tx.rawTransaction)
    print(result.hex())
    return result.hex()
	
	def priv_key_to_account(coin, priv_key):
    if coin == ETH:
        return Account.privateKeyToAccount(priv_key)
    if coin == BTCTEST:
        return PrivateKeyTestnet(priv_key)