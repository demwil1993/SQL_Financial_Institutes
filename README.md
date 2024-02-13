# SQL_Financial_Institutes
Fictional SQL database mimicking a credit union company 

# Database Schema Documentation

## Tables

### credit_score
- **ID**: VARCHAR(3) - Primary Key. Unique identifier for credit score.
- **score_range**: VARCHAR(8) - Range of credit scores.
- **credit_rating**: VARCHAR(20) - Rating based on credit score.
- **Constraints**:
  - `cs_pkey`: Primary Key constraint on ID.
  - `check_score_range`: Check constraint ensuring score_range is within specified ranges.
  - `check_credit_rating`: Check constraint ensuring credit_rating is within specified ratings.

### loan_types
- **loan_num**: VARCHAR(3) - Primary Key. Unique identifier for loan types.
- **loan_type**: VARCHAR(30) - Type of loan.
- **Constraints**:
  - `loan_pkey`: Primary Key constraint on loan_num.
  - `check_loan_type`: Check constraint ensuring loan_type is within specified types.

### account_types
- **account_num**: VARCHAR(3) - Primary Key. Unique identifier for account types.
- **account_type**: VARCHAR(40) - Type of account.
- **Constraints**:
  - `acc_pkey`: Primary Key constraint on account_num.
  - `check_acc_type`: Check constraint ensuring account_type is within specified types.

### customer
- **ID**: VARCHAR(4) - Primary Key. Unique identifier for customers.
- **first_name**: VARCHAR(25) - First name of customer.
- **last_name**: VARCHAR(40) - Last name of customer.
- **gender**: VARCHAR(50) - Gender of customer.
- **credit_ID**: VARCHAR(3) - Foreign Key referencing credit_score(ID).
- **email**: VARCHAR(80) - Email address of customer.
- **phoneNum**: VARCHAR(20) - Phone number of customer.
- **address**: VARCHAR(70) - Address of customer.
- **city**: VARCHAR(60) - City of customer.
- **state**: VARCHAR(50) - State of customer.
- **latitude**: DOUBLE PRECISION - Latitude coordinate of customer's location.
- **longitude**: DOUBLE PRECISION - Longitude coordinate of customer's location.
- **Constraints**:
  - `cus_pkey`: Primary Key constraint on ID.
  - `cus_fkey`: Foreign Key constraint referencing credit_score(ID).
  - `gender_list`: Check constraint ensuring gender is within specified options.

### union_branch
- **ID**: VARCHAR(4) - Primary Key. Unique identifier for union branches.
- **union_name**: VARCHAR(50) - Name of the union.
- **address**: VARCHAR(80) - Address of the union branch.
- **city**: VARCHAR(50) - City where the union branch is located.
- **state**: VARCHAR(50) - State where the union branch is located.
- **assests**: NUMERIC(14,2) - Total assets of the union branch.
- **Constraints**:
  - `union_pkey`: Primary Key constraint on ID.
  - `assests_check`: Check constraint ensuring assets are greater than 0.

### accounts
- **cust_ID**: VARCHAR(4) - Foreign Key referencing customer(ID).
- **union_ID**: VARCHAR(4) - Foreign Key referencing union_branch(ID).
- **account_num**: VARCHAR(3) - Foreign Key referencing account_types(account_num).
- **date_opened**: DATE - Date the account was opened.
- **date_closed**: DATE - Date the account was closed (nullable).
- **current_balance**: NUMERIC(8,2) - Current balance of the account.
- **Constraints**:
  - `has_acc_pkey`: Primary Key constraint on (cust_ID, union_ID, account_num).
  - `has_acc_fkey1`: Foreign Key constraint referencing customer(ID).
  - `has_acc_fkey2`: Foreign Key constraint referencing union_branch(ID).
  - `has_acc_fkey3`: Foreign Key constraint referencing account_types(account_num).

### loans
- **cust_ID**: VARCHAR(4) - Foreign Key referencing customer(ID).
- **union_ID**: VARCHAR(4) - Foreign Key referencing union_branch(ID).
- **loan_num**: VARCHAR(3) - Foreign Key referencing loan_types(loan_num).
- **start_date**: DATE - Date the loan was initiated.
- **maturity_date**: DATE - Date the loan matures.
- **principal**: NUMERIC(8,2) - Principal amount of the loan.
- **interest_apr**: NUMERIC(4,2) - Annual percentage rate of interest.
- **term_months**: INTEGER - Term of the loan in months.
- **Constraints**:
  - `has_loan_pkey`: Primary Key constraint on (cust_ID, union_ID, loan_num).
  - `has_loan_fkey1`: Foreign Key constraint referencing customer(ID).
  - `has_loan_fkey2`: Foreign Key constraint referencing union_branch(ID).
  - `has_loan_fkey3`: Foreign Key constraint referencing loan_types(loan_num).
  - `check_prin`: Check constraint ensuring principal is greater than 0.
  - `check_apr`: Check constraint ensuring interest_apr is greater than or equal to 0.
  - `check_terms`: Check constraint ensuring term_months is greater than 0.

### union_info_audit
- **id**: INT - Auto-incremented primary key for audit entries.
- **union_id**: VARCHAR(4) - ID of the union branch being audited.
- **union_name**: VARCHAR(50) - Name of the union branch being audited.
- **address**: VARCHAR(80) - Address of the union branch being audited.
- **city**: VARCHAR(50) - City where the union branch being audited is located.
- **state**: VARCHAR(50) - State where the union branch being audited is located.
- **assests**: NUMERIC(14,2) - Total assets of the union branch being audited.
- **changed_on**: TIMESTAMP(6) - Timestamp of when the audit entry was made.

### customer_info_audit
- **id**: INT - Auto-incremented primary key for audit entries.
- **cust_id**: VARCHAR(4) - ID of the customer being audited.
- **first_name**: VARCHAR(25) - First name of the customer being audited.
- **last_name**: VARCHAR(40) - Last name of the customer being audited.
- **gender**: VARCHAR(50) - Gender of the customer being audited.
- **credit_ID**: VARCHAR(3) - ID of the credit score record associated with the customer being audited.
- **email**: VARCHAR(80) - Email address of the customer being audited.
- **phoneNum**: VARCHAR(20) - Phone number of the customer being audited.
- **address**: VARCHAR(70) - Address of the customer being audited.
- **city**: VARCHAR(60) - City where the customer being audited resides.
- **state**: VARCHAR(50) - State where the customer being audited resides.
- **latitude**: DOUBLE PRECISION - Latitude coordinate of the customer being audited.
- **longitude**: DOUBLE PRECISION - Longitude coordinate of the customer being audited.
- **changed_on**: TIMESTAMP(6) - Timestamp of when the audit entry was made.

# Database Objects Documentation

## Views

### customer_master
- Provides information about customers along with their credit score details.
- **Columns**:
  - `id`: Customer ID.
  - `first_name`: First name of the customer.
  - `last_name`: Last name of the customer.
  - `gender`: Gender of the customer.
  - `email`: Email address of the customer.
  - `phonenum`: Phone number of the customer.
  - `city`: City where the customer resides.
  - `state`: State where the customer resides.
  - `latitude`: Latitude coordinate of the customer's location.
  - `longitude`: Longitude coordinate of the customer's location.
  - `credit_rating`: Credit rating of the customer.
  - `score_range`: Credit score range of the customer.

### loan_info_master
- Provides information about loans along with the associated union branch.
- **Columns**:
  - `union_name`: Name of the union branch associated with the loan.
  - `loan_type`: Type of loan.
  - `principal`: Principal amount of the loan.
  - `interest_apr`: Annual percentage rate of interest.
  - `term_months`: Term of the loan in months.
  - `start_date`: Date the loan was initiated.
  - `maturity_date`: Date the loan matures.
  - `monthly_payment`: Calculated monthly payment for the loan.

### account_info_master
- Provides information about accounts along with the associated union branch.
- **Columns**:
  - `union_name`: Name of the union branch associated with the account.
  - `account_type`: Type of account.
  - `current_balance`: Current balance of the account.

## Triggers

### branch_info_changes
- Trigger to track changes in union branch information.
- Fires before an update operation on the `union_branch` table.
- Records changes in the `union_info_audit` table.

### customer_info_changes
- Trigger to track changes in customer information.
- Fires before an update operation on the `customer` table.
- Records changes in the `customer_info_audit` table.

## Functions

### log_branch_info_changes
- Function to handle logging of changes in union branch information.

### log_customer_info_changes
- Function to handle logging of changes in customer information.

## Procedures

### assests_change
- Procedure to change the assets value of a union branch.
- Takes `branch_id` and `value` as parameters.

### balance_change
- Procedure to change the balance of an account.
- Takes `cus_id`, `branch_id`, `acc_num`, and `value` as parameters.

### transfer
- Procedure to transfer money from one account to another.
- Takes `depositer`, `recipient`, and `amount` as parameters.

