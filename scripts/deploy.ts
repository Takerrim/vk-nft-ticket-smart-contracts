import { formatEther, parseEther } from "ethers/lib/utils";
import { ethers } from "hardhat";

async function main() {
  const VkNftTicket = await ethers.getContractFactory('VkNftTicket');
  const vkNftTicket = await VkNftTicket.deploy();

  await vkNftTicket.deployed();

  console.log(`VkNftTicket is deployed to ${vkNftTicket.address}`);
  console.log('vkNftTicketContract balance:', formatEther(await vkNftTicket.getContractBalance()))

  // const tx = await vkNftTicket.grantAdminRole()
  // const receipt = await tx.wait();
  // console.log('Admin role granted:', receipt)

  // const mintTicketTx = await vkNftTicket.mint(JSON.stringify({
  //   title: 'ha ha',
  //   type: 'ticket',
  //   properties: {
  //     image: {
  //       type: 'string',
  //       url: 'this is url of image'
  //     }
  //   }
  // }), parseEther('0.1'), { gasLimit: 2000000 });
  // await mintTicketTx.wait()
  // const buyTicketTx = await vkNftTicket.buy(0, {
  //   value: parseEther('0.2')
  // })

  // await buyTicketTx.wait()

  // const tokenURI = await vkNftTicket.getTokenURI(0)
  // // const vkNftTicketContract = await ethers.getContractAt('VkNftTicket', vkNftTicket.address)
  // console.log('vkNftTicketContract balance:', formatEther(await vkNftTicket.getContractBalance()))
  // console.log('tokenURI:', tokenURI)
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
