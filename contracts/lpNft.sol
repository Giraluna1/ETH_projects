// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract lpNft is ERC721{

    address public banco;
    mapping(uint => uint) public balances;

    constructor(string memory _name, string memory _symbol)
        ERC721(_name, _symbol)
    {

    }

    modifier isBanco() {
        require(msg.sender == banco);
        _;
    }

    function mint(address _account, uint _tokenId) external isBanco {
        // Parametros de mint: address to, uint256 tokenId
        _mint(_account, _tokenId);
        
    }

    function deposit(uint _tokenId, uint _amount) external isBanco {
        require(_exists(_tokenId), "ERC721: token Not already exist");
        balances[_tokenId] += _amount;
    }

    function withdraw(address _nftOwner, uint _tokenId, uint _amount) external isBanco returns (uint) {
        require(_exists(_tokenId), "ERC721: token Not already exist");
        require(_ownerOf(_tokenId) == _nftOwner);

        uint _balance = balances[_tokenId];
        require(_amount <= _balance);
        balances[_tokenId] -= _amount;
        return _amount;
    }

}
