pragma solidity ^0.4.24;

//Abstract contracts
//Abstracts contracts are contracts that have partial function definitions. 
//You cannot create an instance of an abstract contract. 
//An abstract contract must be inherited by a child contract for utilizing its functions. 

contract AbstractContract {
 
 function GetValue() public view returns (uint);
 
 function SetValue(uint _value) public;

    function AddNumber(uint _value) public returns (uint) {
        return 10;
    }
}

contract test is AbstractContract{

    uint private simpleInteger;

    function GetValue() public view returns (uint) {
        return simpleInteger;
    }
 
    function SetValue(uint _value) public {
        simpleInteger = _value;
    }

    function AddNumber(uint _value) public returns (uint){
        return simpleInteger = _value;
    }
}
