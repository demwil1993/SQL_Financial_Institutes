/* Record the directory path of csv files, Use full file path with FROM clause */

COPY credit_score (id, score_range, credit_rating)
FROM 'credit_score_values.csv'
DELIMITER ','
CSV HEADER;

COPY account_types (account_num, account_type)
FROM 'account_values.csv'
DELIMITER ','
CSV HEADER;

COPY union_branch (id, union_name, address, city, state, assests)
FROM 'credit_union_values.csv'
DELIMITER ','
CSV HEADER;

COPY loan_types (loan_num, loan_type)
FROM 'loan_values.csv'
DELIMITER ','
CSV HEADER;

COPY customer (id, first_name, last_name, gender, credit_id, email, phonenum, address, city, state, latitude, longitude)
FROM 'customer_values.csv'
DELIMITER ','
CSV HEADER;

COPY accounts (cust_id, union_id, account_num, date_opened, date_closed, current_balance)
FROM 'has_account_values.csv'
DELIMITER ','
CSV HEADER;

COPY loans (cust_ID, union_ID, loan_num, start_date, maturity_date, principal, interest_apr, term_months)
FROM 'has_loan_values.csv'
DELIMITER ','
CSV HEADER;
