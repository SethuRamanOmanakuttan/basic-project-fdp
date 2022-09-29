var fs = require('fs')
var config = require('../config.json')
var contractABI = require('../product_abi.json')
const Web3 = require('web3')

//connecting to a node
const web3 = new Web3(new Web3.providers.HttpProvider(config.CHAINSTACK_URL))

// providing contract details
const productContract = new web3.eth.Contract(contractABI, config.CONTRACT_ADDRESS);


//function to add a product
async function addProduct(_name,_mfd,_exp,_id){
	transaction = productContract.methods.addProduct(_name,_mfd,_exp,_id)
	return await send(transaction)

}

//function to update product the detail
async function updateLocation(_id,_location){
	transaction = productContract.methods.updateLocation(_id,_location)
	return await send(transaction)
}

//function to delete a product
async function deleteProduct(_id){
		transaction = productContract.methods.deleteProduct(_id)
		return await send(transaction)
}

//function to view product detail
async function viewProductDetail(_id){
	return await productContract.methods.viewProductDetail(_id).call()

}


//function to sign and send a transaction
async function send(transaction) {
    const account = config.ACCOUNT_ADDRESS
    var gasPrice = await web3.eth.getGasPrice()

    const options = {
        to      : transaction._parent._address,
        data    : transaction.encodeABI(),
        gas     : await transaction.estimateGas({from: account}),
        gasPrice: gasPrice
    };
    const signed  = await web3.eth.accounts.signTransaction(options, config.PRIVATE_KEY);
    const receipt = await web3.eth.sendSignedTransaction(signed.rawTransaction);
    return receipt;
}

module.exports = {
	addProduct,
	updateLocation,
	deleteProduct,
	viewProductDetail
}