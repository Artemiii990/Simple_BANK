// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {Bank} from "../src/Bank.sol";
import "../src/Types.sol";
import "../src/Errors.sol";

contract BankTest is Test {
    Bank public bank;

    function testActiveAcaunt() public{
        bank = new Bank();
        bank.acrivate();
        assertEq(uint(bank.getStatus()), uint(AccountStatus.Active));
    }

    function testDepositFailed() public {
        bank = new Bank();

        vm.expectRevert(
            abi.encodeWithSelector(
                AccountNotActive.selector,
                AccountStatus.Inactive
            )
        );

        bank.deposit(10);
    }
    
    function testDeposit() public {
        bank = new Bank();
        bank.acrivate();

        bank.deposit(10);
        assertEq(bank.getBalance(), 10);
    }

    function testWithdrawFaild() public{
        bank = new Bank();

        vm.expectRevert(
            abi.encodeWithSelector(
                AccountNotActive.selector,
                AccountStatus.Inactive
            )
        );

        bank.withdraw(10);
    }

    function testWithdrawManyBalans() public{
        bank = new Bank();
        bank.acrivate();

        vm.expectRevert(InsufficientBalance.selector);

        bank.withdraw(10);
    }
    
    function testWithdrawDeposit() public{
        bank = new Bank();
        bank.acrivate();

        bank.deposit(100);        
        bank.withdraw(10);
        
        assertEq(bank.getBalance(), 90);
    }
}
