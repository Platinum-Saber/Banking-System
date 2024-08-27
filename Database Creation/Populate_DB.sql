use bank_database;

INSERT INTO fd_plan (fd_plan_id, duration, Interest_rate) VALUES
(1, 365, 5.00),
(2, 730, 5.50),
(3, 1095, 6.00);

INSERT INTO savings_plan (savings_plan_id, type, Interest_rate, minimum_balance, age_limit) VALUES
(1, 'child', 3.50, 1000.00, 18),
(2, 'teen', 4.00, 2000.00, 25),
(3, 'adult', 4.50, 3000.00, 60),
(4, 'senior', 5.00, 2000.00, NULL);

INSERT INTO branch (branch_id, name, location, manager_id) VALUES
(1, 'Central Branch', '123 Main St, Cityville', 1),
(2, 'North Branch', '456 North St, Cityville', 2),
(3, 'South Branch', '789 South St, Cityville', 3);

INSERT INTO user (user_id, user_name, password, email, full_name, date_of_birth, role) VALUES
(1, 'john_doe', 'password123', 'john.doe@example.com', 'John Doe', '1980-01-01', 'customer'),
(2, 'jane_smith', 'password456', 'jane.smith@example.com', 'Jane Smith', '1990-02-01', 'manager'),
(3, 'mark_jones', 'password789', 'mark.jones@example.com', 'Mark Jones', '1985-03-01', 'employee');

INSERT INTO customer (customer_id, user_id, customer_type, contact_number, address) VALUES
(1, 1, 'individual', '1234567890', '789 South St, Cityville'),
(2, 3, 'organization', '0987654321', '456 North St, Cityville');

INSERT INTO account (account_id, account_type, account_number, customer_id, branch_id, balance, status) VALUES
(1, 'savings', 123456789012345, 1, 1, 5000.00, 'active'),
(2, 'checking', '098765432198765', 2, 2, 10000.00, 'active');

INSERT INTO savings_account (savings_account_id, account_id, savings_plan_id) VALUES
(1, 1, 3),
(2, 2, 2);

INSERT INTO fixed_deposit (savings_account_id, fd_id, amount, fd_plan_id, start_date, end_date) VALUES
(1, 1, 10000.00, 1, '2024-01-01', '2025-01-01'),
(2, 2, 20000.00, 2, '2024-01-01', '2026-01-01');

INSERT INTO employee (employee_id, user_id, branch_id) VALUES
(1, 3, 1);

INSERT INTO penalty_types (penalty_type_id, penalty_amount, penalty_type) VALUES
(1, 100.00, 'Late Payment'),
(2, 50.00, 'Minimum Balance');

INSERT INTO customer_log (log_id, customer_id, contact_number, address, updated_date) VALUES
(1, 1, '1234567890', '789 South St, Cityville', '2024-01-01');

INSERT INTO `transaction` (transaction_id, account_id, transaction_type, amount, date, description) VALUES
(1, 1, 'deposit', 1000.00, '2024-02-01 10:00:00', 'Initial Deposit'),
(2, 2, 'withdrawal', 500.00, '2024-02-02 11:00:00', 'ATM Withdrawal');

INSERT INTO loan (loan_id, account_id, loan_type, amount, interest_rate, start_date, end_date, status) VALUES
(1, 1, 'personal', 5000.00, 7.50, '2024-01-01', '2025-01-01', 'approved');

INSERT INTO penalty (penalty_id, penalty_type_id) VALUES
(1, 1);

INSERT INTO loan_installment (installment_id, loan_id, amount, duration) VALUES
(1, 1, 500.00, 30);

INSERT INTO loan_payment (payment_id, instalment_id, amount, due_date, payed_date, status, penalty_id) VALUES
(1, 1, 500.00, '2024-02-01', '2024-02-01', 'paid', 1);

INSERT INTO checking_account (checking_account_id, account_id) VALUES
(1, 2);

INSERT INTO transfer (transaction_id, beneficiary_account_id) VALUES
(1, 2);

INSERT INTO manager (manager_id, user_id, branch_id) VALUES
(1, 2, 1);

INSERT INTO deposit (transaction_id, branch_id) VALUES
(1, 1);

INSERT INTO withdrawal (transaction_id, branch_id) VALUES
(2, 2);