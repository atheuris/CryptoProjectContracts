// SPDX-License-Identifier: MIT
const TaxedToken = artifacts.require("TaxedToken");

module.exports = async function (deployer) {

  await deployer.deploy(TaxedToken);
};