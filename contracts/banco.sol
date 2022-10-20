// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import "./lpNft.sol";

contract bancoLis {

    lpNft public db;
    uint _nftCounter;

    constructor(string memory _name, string memory _symbol){
        db = new lpNft(_name, _symbol);

    }

    function createAccount(address _newOwner) external returns(uint) {
        // creamos el id para asignarlo dentro de la coleccion de NFT
        uint _nftID = _nftCounter;
        db.mint(_newOwner, _nftCounter);
        _nftCounter++;
        return _nftID;
    }


    function deposit(uint _tokenId, uint _amount) external payable {
        db.deposit(_tokenId, _amount);

    }

    function withdraw(address _nftOwner, uint _tokenId, uint _amount) external {
        uint _balance = db.withdraw(_nftOwner, _tokenId, _amount);
        payable(_nftOwner).transfer(_balance);
    }


}