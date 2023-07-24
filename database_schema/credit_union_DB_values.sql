COPY credit_score (id, score_range, credit_rating)
FROM 'C:\Users\aspar\Downloads\Bank_values_CVS\credit_score_values.csv'
DELIMITER ','
CSV HEADER;

COPY account_types (account_num, account_type)
FROM 'C:\Users\aspar\Downloads\Bank_values_CVS\account_values.csv'
DELIMITER ','
CSV HEADER;

COPY union_branch (id, union_name, address, city, state, assests)
FROM 'C:\Users\aspar\Downloads\Bank_values_CVS\credit_union_values.csv'
DELIMITER ','
CSV HEADER;

COPY loan_types (loan_num, loan_type)
FROM 'C:\Users\aspar\Downloads\Bank_values_CVS\loan_values.csv'
DELIMITER ','
CSV HEADER;

COPY customer (id, first_name, last_name, gender, credit_id, email, phonenum, address, city, state, latitude, longitude)
FROM 'C:\Users\aspar\Downloads\Bank_values_CVS\customer_values.csv'
DELIMITER ','
CSV HEADER;

COPY accounts (cust_id, union_id, account_num, date_opened, date_closed, current_balance)
FROM 'C:\Users\aspar\Downloads\Bank_values_CVS\has_account_values.csv'
DELIMITER ','
CSV HEADER;

COPY loans (cust_ID, union_ID, loan_num, start_date, maturity_date, principal, interest_apr, term_months)
FROM 'C:\Users\aspar\Downloads\Bank_values_CVS\has_loan_values.csv'
DELIMITER ','
CSV HEADER;