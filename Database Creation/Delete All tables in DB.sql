DROP TABLE IF EXISTS loan_payment;
DROP TABLE IF EXISTS loan_installment;
DROP TABLE IF EXISTS loan;
DROP TABLE IF EXISTS transfer;
DROP TABLE IF EXISTS withdrawal;
DROP TABLE IF EXISTS deposit;
DROP TABLE IF EXISTS penalty;
DROP TABLE IF EXISTS fixed_deposit;
DROP TABLE IF EXISTS savings_account;
DROP TABLE IF EXISTS account;

-- Drop tables that are referenced by other tables
DROP TABLE IF EXISTS customer_log;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS manager;
DROP TABLE IF EXISTS branch;

-- Drop remaining tables
DROP TABLE IF EXISTS penalty_types;
DROP TABLE IF EXISTS savings_plan;
DROP TABLE IF EXISTS fd_plan;
DROP TABLE IF EXISTS user;

DROP TABLE IF EXISTS checking_account;
DROP TABLE IF EXISTS transaction;

