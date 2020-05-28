pragma solidity ^0.5.0;


contract AssociateProfitSplitter {
    
	// @TODO: Create three payable addresses representing `employee_one`, `employee_two` and `employee_three`.
	address payable employee_one;
    address payable employee_two;
    address payable employee_three;
	

    constructor(address payable _one, address payable _two, address payable _three) public {
//     if ( _one !=address(0) ) { employee_one = _one; }
//        else { employee_one = 0xb340da6BEC1eBDEE435B3b4Ed052CF2261e03ae1; }      // QUASI CONSTRUCTOR OVERLOAD - compiles but cant accept empty addy
        
//        if ( _two !=address(0) ) { employee_two = _two; }
//        else { employee_two = 0x525d09627e665ecAf05DDF3010026B5486095a36; }
        
//        if ( _three !=address(0) ) { employee_three = _three; }
//        else { employee_three = 0x7a2f4A360b4728e31c252bC43099EEE7A38328D6; }
    
            address payable employee_one;
            address payable employee_two;
            address payable employee_three;
        }
    
    

    function balance() public view returns(uint) {
        return address(this).balance;
    }

    function deposit() public payable {
        // @TODO: Split `msg.value` into three
        uint amount = msg.value / 3;

        // @TODO: Transfer the amount to each employee
		employee_one.transfer(amount);
        employee_two.transfer(amount);
        employee_three.transfer(amount);

        // @TODO: take care of a potential remainder by sending back to HR (`msg.sender`)
        msg.sender.transfer(msg.value - (amount * 3));
    }

    function() external payable {
        // @TODO: Enforce that the `deposit` function is called in the fallback function!
        deposit();
    }
}
