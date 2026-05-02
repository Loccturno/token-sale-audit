# TokenSale Contract — Audit Report

## Contract Overview
A token sale contract allowing users to buy tokens with ETH, 
request refunds, and allowing the owner to withdraw funds.

---

## Findings

### [CRITICAL-01] Missing Access Control on withdrawAll()
**Severity:** Critical  
**Description:** Anyone can withdraw funds.
**Impact:** Critical  
**Fix:** Add require(msg.sender == owner, "Not owner");

### [CRITICAL-02] Missing Payment Validation in buyTokens()
**Severity:** Critical  
**Description:** You can buy any amount(no msg.value check).
**Impact:**  Attacker can acquire all tokens without paying any ETH.
**Fix:** Require(msg.value == amount * tokenPrice, "Incorrect ETH sent"); 

### [CRITICAL-03] Reentrancy in refund()
**Severity:** Critical  
**Description:** First you send the tokens and then update the state.(reentrancy).
**Impact:** You can drain the protocol.
**Fix:** First update the state, then send funds.

### [HIGH-01] Missing Access Control on setPrice()
**Severity:** High  
**Description:** Anyone can change the price.
**Impact:** Price manipulation bu anyone.
**Fix:** Add require(msg.sender == owner, "Not owner");

---

## Summary
| ID | Severity | Title |
|----|----------|-------|
| CRITICAL-01 | Critical | withdrawAll no access control |
| CRITICAL-02 | Critical | buyTokens no payment check |
| CRITICAL-03 | Critical | Reentrancy in refund |
| HIGH-01 | High | setPrice no access control |
