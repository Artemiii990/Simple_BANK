// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

enum AccountStatus {
    Inactive,
    Active,
    Closed
}

struct Account {
    uint256 balance;
    AccountStatus status;
}