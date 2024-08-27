USE bank_database;

-- Creating `user` table first, as it is referenced by other tables
CREATE TABLE user (
  user_id INT NOT NULL AUTO_INCREMENT,
  user_name VARCHAR(50),
  password VARCHAR(255),
  email VARCHAR(100),
  full_name VARCHAR(100),
  date_of_birth DATE,
  role ENUM('manager', 'employee', 'customer'),
  PRIMARY KEY (user_id)
);


-- Creating `manager` table to resolve foreign key dependencies in `branch`
CREATE TABLE manager (
  manager_id INT NOT NULL AUTO_INCREMENT,
  user_id INT,
  branch_id INT,
  PRIMARY KEY (manager_id),
  FOREIGN KEY (user_id) REFERENCES user(user_id)
  -- FOREIGN KEY (branch_id) REFERENCES branch(branch_id)
);

-- Creating `branch` table, as it is referenced by other tables
CREATE TABLE branch (
  branch_id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(100),
  location VARCHAR(255),
  manager_id INT,
  PRIMARY KEY (branch_id),
  FOREIGN KEY (manager_id) REFERENCES manager(manager_id)
);

-- Creating `customer` table after `user` is created
CREATE TABLE customer (
  customer_id INT NOT NULL AUTO_INCREMENT,
  user_id INT,
  customer_type ENUM('individual', 'organization'),
  contact_number VARCHAR(10),
  address VARCHAR(255),
  PRIMARY KEY (customer_id),
  FOREIGN KEY (user_id) REFERENCES user(user_id)
);

-- Creating `account` table after `customer` and `branch` are created
CREATE TABLE account (
  account_id INT NOT NULL AUTO_INCREMENT,
  account_type ENUM('savings', 'checking'),
  account_number CHAR(15), -- changed to CHAR(15) for fixed length
  customer_id INT,
  branch_id INT,
  balance DECIMAL(15,2),
  status ENUM('active', 'inactive'),
  PRIMARY KEY (account_id),
  FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
  FOREIGN KEY (branch_id) REFERENCES branch(branch_id)
);

-- Creating `savings_plan` table
CREATE TABLE savings_plan (
  savings_plan_id INT NOT NULL AUTO_INCREMENT,
  type ENUM('child', 'teen', 'adult', 'senior'),
  Interest_rate DECIMAL(4,2),
  minimum_balance DECIMAL(15,2),
  age_limit INT,
  PRIMARY KEY (savings_plan_id)
);

-- Creating `fd_plan` table
CREATE TABLE fd_plan (
  fd_plan_id INT NOT NULL AUTO_INCREMENT,
  duration INT,
  Interest_rate DECIMAL(4,2),
  PRIMARY KEY (fd_plan_id)
);

-- Creating `savings_account` table
CREATE TABLE savings_account (
  savings_account_id INT NOT NULL AUTO_INCREMENT,
  account_id INT,
  savings_plan_id INT,
  PRIMARY KEY (savings_account_id),
  FOREIGN KEY (account_id) REFERENCES account(account_id),
  FOREIGN KEY (savings_plan_id) REFERENCES savings_plan(savings_plan_id)
);

-- Creating `fixed_deposit` table
CREATE TABLE fixed_deposit (
  fd_id INT NOT NULL AUTO_INCREMENT,
  savings_account_id INT,
  amount DECIMAL(15,2),
  fd_plan_id INT,
  start_date DATE,
  end_date DATE,
  PRIMARY KEY (fd_id),
  FOREIGN KEY (savings_account_id) REFERENCES savings_account(savings_account_id),
  FOREIGN KEY (fd_plan_id) REFERENCES fd_plan(fd_plan_id)
);

-- Creating `transaction` table
CREATE TABLE transaction (
  transaction_id INT NOT NULL AUTO_INCREMENT,
  account_id INT,
  transaction_type ENUM('deposit', 'withdrawal', 'transfer'),
  amount DECIMAL(15,2),
  date DATETIME,
  description VARCHAR(255),
  PRIMARY KEY (transaction_id),
  FOREIGN KEY (account_id) REFERENCES account(account_id)
);

-- Creating `employee` table
CREATE TABLE employee (
  employee_id INT NOT NULL AUTO_INCREMENT,
  user_id INT,
  branch_id INT,
  PRIMARY KEY (employee_id),
  FOREIGN KEY (user_id) REFERENCES user(user_id),
  FOREIGN KEY (branch_id) REFERENCES branch(branch_id)
);

-- Creating `penalty_types` table
CREATE TABLE penalty_types (
  penalty_type_id INT NOT NULL AUTO_INCREMENT,
  penalty_amount DECIMAL(10,2),
  penalty_type VARCHAR(50),
  PRIMARY KEY (penalty_type_id)
);

-- Creating `customer_log` table
CREATE TABLE customer_log (
  log_id INT NOT NULL AUTO_INCREMENT,
  customer_id INT,
  contact_number VARCHAR(10),
  address VARCHAR(255),
  updated_date DATE,
  PRIMARY KEY (log_id),
  FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

-- Creating `loan` table
CREATE TABLE loan (
  loan_id INT NOT NULL AUTO_INCREMENT,
  account_id INT,
  loan_type ENUM('personal', 'business'),
  amount DECIMAL(15,2),
  interest_rate DECIMAL(4,2),
  start_date DATE,
  end_date DATE,
  status ENUM('approved', 'pending', 'rejected'),
  PRIMARY KEY (loan_id),
  FOREIGN KEY (account_id) REFERENCES account(account_id)
);

-- Creating `penalty` table
CREATE TABLE penalty (
  penalty_id INT NOT NULL AUTO_INCREMENT,
  penalty_type_id INT,
  PRIMARY KEY (penalty_id),
  FOREIGN KEY (penalty_type_id) REFERENCES penalty_types(penalty_type_id)
);

-- Creating `deposit` table
CREATE TABLE deposit (
  transaction_id INT NOT NULL AUTO_INCREMENT,
  branch_id INT,
  PRIMARY KEY (transaction_id),
  FOREIGN KEY (transaction_id) REFERENCES transaction(transaction_id)
);

-- Creating `loan_installment` table
CREATE TABLE loan_installment (
  installment_id INT NOT NULL AUTO_INCREMENT,
  loan_id INT,
  amount DECIMAL(15,2),
  duration INT DEFAULT 30,
  PRIMARY KEY (installment_id),
  FOREIGN KEY (loan_id) REFERENCES loan(loan_id)
);

-- Creating `withdrawal` table
CREATE TABLE withdrawal (
  transaction_id INT NOT NULL AUTO_INCREMENT,
  branch_id INT,
  PRIMARY KEY (transaction_id),
  FOREIGN KEY (transaction_id) REFERENCES transaction(transaction_id)
);

-- Creating `checking_account` table
CREATE TABLE checking_account (
  checking_account_id INT NOT NULL AUTO_INCREMENT,
  account_id INT,
  PRIMARY KEY (checking_account_id),
  FOREIGN KEY (account_id) REFERENCES account(account_id)
);

-- Creating `transfer` table
CREATE TABLE transfer (
  transaction_id INT NOT NULL AUTO_INCREMENT,
  beneficiary_account_id INT,
  PRIMARY KEY (transaction_id),
  FOREIGN KEY (transaction_id) REFERENCES transaction(transaction_id)
);

-- Creating `loan_payment` table
CREATE TABLE loan_payment (
  payment_id INT NOT NULL AUTO_INCREMENT,
  instalment_id INT,
  amount DECIMAL(15,2),
  due_date DATE,
  payed_date DATE,
  status ENUM('paid', 'unpaid'),
  penalty_id INT,
  PRIMARY KEY (payment_id),
  FOREIGN KEY (instalment_id) REFERENCES loan_installment(installment_id),
  FOREIGN KEY (penalty_id) REFERENCES penalty(penalty_id)
);

ALTER TABLE manager
ADD FOREIGN KEY (branch_id) REFERENCES branch(branch_id);
