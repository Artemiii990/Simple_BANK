// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import "./Types.sol";
import "./Errors.sol";
import "./Events.sol";

contract Bank {
    Account private account;
    
    function acrivate() public {
        account.status = AccountStatus.Active;
    }

    function deposit(uint256 amount) public {
        if(account.status != AccountStatus.Active){
            revert AccountNotActive(account.status);
        }

        uint256 oldBalance = account.balance;
        account.balance += amount;

        emit Deposit(oldBalance, account.balance);
    }
    
    function withdraw(uint256 amount) public {
        if(account.status != AccountStatus.Active){
            revert AccountNotActive(account.status);
        }
        
        if(account.balance < amount){
            revert InsufficientBalance();
        }

        uint256 oldBalance = account.balance;
        account.balance -= amount;

        emit Withdraw(oldBalance, account.balance);
    }
    
    function getBalance() public view returns (uint256) {
        return account.balance;
    }

    function getStatus() public view returns (AccountStatus) {
        return account.status;
    }
}
