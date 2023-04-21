// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.7;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Edroh is ERC721, Ownable {
    uint public mintPrice = 0.00005 ether;
    uint public totalSupply;
    uint public maxSupply;
    bool public isMintEnabled;
    
    mapping(address => uint) public mintedWallets;

    constructor() payable ERC721("Edroh NFT", "EDRH") {
        maxSupply = 50;
    }

    function toggleMinting() external onlyOwner {
        isMintEnabled = !isMintEnabled;
    }

    function setMaxSupply(uint _max) external onlyOwner {
        maxSupply = _max;
    }

    function mint() external payable {
        require(isMintEnabled, "Minting Not Enabled");
        require(mintedWallets[msg.sender] < 10, "you have minted too many");
        require(totalSupply < maxSupply, "All nfts are minted already");
        require(msg.value == mintPrice, "pay the minting fee");
        mintedWallets[msg.sender]++;
        totalSupply++;
        uint tokenId = totalSupply;
        _safeMint(msg.sender, tokenId);
    }
}