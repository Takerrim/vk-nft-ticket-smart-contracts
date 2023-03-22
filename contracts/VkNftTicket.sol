// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract VkNftTicket is ERC721URIStorage, AccessControl {
    using Counters for Counters.Counter;
    Counters.Counter _tokenId;

    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");

    mapping (uint256 => uint256) private _tokenIdToPrice;

    constructor() ERC721("Vk Nft Ticket", "VNT") {}

    function grantAdminRole() public {
        _grantRole(ADMIN_ROLE, msg.sender);
    }

    function mint(string memory tokenURI, uint256 price) onlyRole(ADMIN_ROLE) public {
        uint256 tokenId = _tokenId.current();
        _mint(address(this), tokenId);
        _setTokenURI(tokenId, tokenURI);
        _tokenIdToPrice[tokenId] = price;
        _tokenId.increment();
    }

    function buy(uint256 tokenId) public payable {
        require(msg.value >= _tokenIdToPrice[tokenId], 'Price is less than price of the token');
        _transfer(address(this), msg.sender, tokenId);
        _tokenIdToPrice[tokenId] = msg.value;
        payable(address(this)).transfer(msg.value);
    }

    function getTokenURI(uint256 tokenId) public view returns(string memory) {
        return tokenURI(tokenId);
    }

    function getContractBalance() public view returns(uint256) {
        return address(this).balance;
    }

    function getTicketPrice(uint256 tokenId) view public returns (uint256) {
        return _tokenIdToPrice[tokenId];
    }

    function totalSupply() public view returns(uint256) {
        return _tokenId.current();
    }

    receive() external payable {}

    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721, AccessControl) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}
