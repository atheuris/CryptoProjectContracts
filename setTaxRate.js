const TaxedToken = artifacts.require("TaxedToken");

module.exports = async function(callback) {
    try {
        const tokenInstance = await TaxedToken.deployed();
        const newTaxRate = 10; // Set the new tax rate to 10%
        
        const accounts = await web3.eth.getAccounts();
        const deployerAccount = accounts[0]; // This is the deployer's wallet

        await tokenInstance.setTaxRate(newTaxRate, {from: deployerAccount});
        console.log("Tax rate updated successfully!");

        callback();
    } catch (error) {
        console.error("Error: ", error);
        callback(error);
    }
};