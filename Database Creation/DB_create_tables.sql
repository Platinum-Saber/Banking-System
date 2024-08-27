use bank_database;
CREATE TABLE `fd_plan` (
  `fd_plan_id` int,
  `duration` int,
  `Interest_rate` decimal(4,2),
  PRIMARY KEY (`fd_plan_id`)
);

CREATE TABLE `savings_plan` (
  `savings_plan_id` int,
  `type` enum('child', 'teen', 'adult', 'senior'),
  `Interest_rate` decimal(4,2),
  `minimum_balance` decimal(15,2),
  `age_limit` int,
  PRIMARY KEY (`savings_plan_id`)
);

CREATE TABLE `savings_account` (
  `savings_account_id` int,
  `account_id` int,
  `savings_plan_id` int,
  PRIMARY KEY (`savings_account_id`),
  FOREIGN KEY (`savings_plan_id`) REFERENCES `savings_plan`(`savings_plan_id`)
);

CREATE TABLE `fixed_deposit` (
  `savings_account_id` int,
  `fd_id` int,
  `amount` decimal(15,2),
  `fd_plan_id` int,
  `start_date` date,
  `end_date` date,
  PRIMARY KEY (`fd_id`),
  FOREIGN KEY (`savings_account_id`) REFERENCES `savings_account`(`savings_account_id`),
  FOREIGN KEY (`fd_plan_id`) REFERENCES `fd_plan`(`fd_plan_id`)
);

CREATE TABLE `branch` (
  `branch_id` int,
  `name` varchar(100),
  `location` varchar(255),
  `manager_id` int,
  PRIMARY KEY (`branch_id`)
);

CREATE TABLE `employee` (
  `employee_id` int,
  `user_id` int,
  `branch_id` int,
  PRIMARY KEY (`employee_id`),
  FOREIGN KEY (`branch_id`) REFERENCES `branch`(`branch_id`)
);

CREATE TABLE `penalty_types` (
  `penalty_type_id` int,
  `penalty_amount` decimal(10,2),
  `penalty_type` varchar(50),
  PRIMARY KEY (`penalty_type_id`)
);

CREATE TABLE `customer` (
  `customer_id` int,
  `user_id` int,
  `customer_type` enum('individual', 'organization'),
  `contact_number` varchar(10),
  `address` varchar(255),
  PRIMARY KEY (`customer_id`)
);

CREATE TABLE `customer_log` (
  `log_id` int,
  `customer_id` int,
  `contact_number` varchar(10),
  `address` varchar(255),
  `updated_date` date,
  PRIMARY KEY (`log_id`),
  FOREIGN KEY (`customer_id`) REFERENCES `customer`(`customer_id`)
);

CREATE TABLE `account` (
  `account_id` int,
  `account_type` enum('savings', 'checking'),
  `account_number` varchar(20),
  `customer_id` int,
  `branch_id` int,
  `balance` double(15,2),
  `status` enum('active,enactive'),
  PRIMARY KEY (`account_id`),
  FOREIGN KEY (`customer_id`) REFERENCES `customer`(`customer_id`),
  FOREIGN KEY (`branch_id`) REFERENCES `branch`(`branch_id`)
);

CREATE TABLE `transaction` (
  `transaction_id` int,
  `account_id` int,
  `transaction_type` enum('deposit', 'withdrawal', 'transfer'),
  `amount` decimal(15,2),
  `date` datetime,
  `description` varchar(255),
  PRIMARY KEY (`transaction_id`),
  FOREIGN KEY (`account_id`) REFERENCES `account`(`account_id`)
);

CREATE TABLE `loan` (
  `loan_id` int,
  `account_id` int,
  `loan_type` enum('personal', 'business'),
  `amount` decimal(15,2),
  `interest_rate` decimal(4,2),
  `start_date` date,
  `end_date` date,
  `status` enum('approved', 'pending', 'rejected'),
  PRIMARY KEY (`loan_id`),
  FOREIGN KEY (`account_id`) REFERENCES `account`(`account_id`)
);

CREATE TABLE `penalty` (
  `penalty_id` int,
  `penalty_type_id` int,
  PRIMARY KEY (`penalty_id`),
  FOREIGN KEY (`penalty_type_id`) REFERENCES `penalty_types`(`penalty_type_id`)
);

CREATE TABLE `deposit` (
  `transaction_id` int,
  `branch_id` int,
  PRIMARY KEY (`transaction_id`)
);

CREATE TABLE `user` (
  `user_id` int,
  `user_name` varchar(50),
  `password` varchar(255),
  `email` varchar(100),
  `full_name` varchar(100),
  `date_of_birth` date,
  `role` enum('manager', 'employee', 'customer'),
  PRIMARY KEY (`user_id`)
);

CREATE TABLE `loan_installment` (
  `installment_id` int,
  `loan_id` int,
  `amount` decimal(15,2),
  `duration` int default(30),
  PRIMARY KEY (`installment_id`)
);

CREATE TABLE `manager` (
  `manager_id` int,
  `user_id` int,
  `branch_id` int,
  PRIMARY KEY (`manager_id`)
);

CREATE TABLE `withdrawal` (
  `transaction_id` int,
  `branch_id` int,
  PRIMARY KEY (`transaction_id`)
);

CREATE TABLE `checking_account` (
  `checking_account_id` int,
  `account_id` int,
  PRIMARY KEY (`checking_account_id`)
);

CREATE TABLE `transfer` (
  `transaction_id` int,
  `beneficiary_account_id` int,
  PRIMARY KEY (`transaction_id`)
);

CREATE TABLE `loan_payment` (
  `payment_id` int,
  `instalment_id` int,
  `amount` decimal(15,2),
  `due_date` date,
  `payed_date` date,
  `status` enum('paid', 'unpaid'),
  `penalty_id` int,
  PRIMARY KEY (`payment_id`),
  FOREIGN KEY (`instalment_id`) REFERENCES `loan_installment`(`installment_id`)
);

