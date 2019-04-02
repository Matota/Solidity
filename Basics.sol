//solidity compiler version
pragma solidity ^0.4.20;

contract BasicContract {
    string private student;
    uint private marks;
    
    //bytes1 - bytes32: fixed size.
    // bytes or string: dynamically sized.
    
    //set details
    function setStudentDetails(string memory studentName, uint studentMarks) public {
        student = studentName;
        marks = studentMarks;
    }
    
    //get details
    function getStudentDetails() public view returns (string memory, uint) {
        return (student, marks);
    }
    

    // dictionary that maps addresses to balances
    // always be careful about overflow attacks with numbers
    mapping (address => uint) private balances;
    
    // Events - publicize actions to external listeners
    event LogDepositMade(address accountAddress, uint amount);
    
    function deposit() public payable returns (uint) {
        // Use 'require' to test user inputs, 'assert' for internal invariants
        // Here we are making sure that there isn't an overflow issue
        require((balances[msg.sender] + msg.value) >= balances[msg.sender]);

        balances[msg.sender] += msg.value;
        // no "this." or "self." required with state variable
        // all values set to data type's initial value by default

        LogDepositMade(msg.sender, msg.value); // fire event

        return balances[msg.sender];
    }
}

//polymorphism
//can be done with (ChildContract is ParentContract)
contract TeacherContract {
    uint internal totalMarks;

    function SetMarks(uint marks) public {
        totalMarks = marks;
    }
    
    function GetTotalMarks() public view returns (uint) {
        return 100;
    }
}

contract StudentContract is TeacherContract {
 
 function GetTotalMarks() public view returns (uint) {
     return totalMarks;
 }
 
}

