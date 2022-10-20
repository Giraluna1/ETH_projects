// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

// Cuenta de ahorros 
// dos funciones una variable, la variable guarda cuanta cantidad de 
// las funciones son para enviar y para recibir



contract cuenta {
    uint public balance;
    address public owner;

    constructor(){
        owner = msg.sender;
    }

    modifier isOwner(){
        require(owner == msg.sender);
        _; // el underscore remplaza la funcion anterior a la que la llamo
    }

    function deposit() external payable{
        balance += msg.value;
    }

    function withdraw(uint _val) external isOwner {
        // chequear que si haya el dinero que quieres extraer
        // requiere funciona como un if que hace checks

        // validar que quien extrae o metiendo sea el dueno para eso
        // llamamos a isOwner antes de venir a ejecutarse
        
        // si requier es false, revierte toda la transaccion
        require(_val <= balance);
        balance -= _val;

        // payable es una palabra reservada que tiene la instruccion
        // de recibir dinero
        payable(owner).transfer(_val);

    }
}

contract bancolombia {
    mapping(address => uint) public balances;


    function deposit(address _account) external payable {
        balances[_account] += msg.value;

    }

    function withdraw(uint _val) external {
        uint _balance = balances[msg.sender];
        require(_val <= _balance);
        balances[msg.sender] -= _val;

        payable(msg.sender).transfer(_val);
    }

}