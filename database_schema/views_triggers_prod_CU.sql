-- create view with customer information
CREATE VIEW customer_master AS
	SELECT 
		c.id,
		c.first_name,
		c.last_name,
		c.gender,
		c.email,
		c.phonenum,
		c.city,
		c.state,
		c.latitude,
		c.longitude,
		cs.credit_rating,
		cs.score_range 
	FROM customer c
	LEFT JOIN credit_score cs ON cs.id = c.credit_id;

-- create view to give loan information
CREATE VIEW loan_info_master AS
	SELECT
		u.union_name,
		l.loan_type,
		ls.principal,
		ls.interest_apr,
		ls.term_months,
		ls.start_date,
		ls.maturity_date,
		ROUND(ls.principal * ((ls.interest_apr / 100 / 12 * ((1 + ls.interest_apr / 100 / 12)^ls.term_months)) / ((1 + ls.interest_apr/100/12)^ls.term_months - 1)),2)  AS monthly_payment
	FROM loan_types l
	INNER JOIN loans ls ON ls.loan_num = l.loan_num
	INNER JOIN union_branch u ON u.id = ls.union_id;

-- create view to give account information
CREATE VIEW account_info_master AS
	SELECT
		u.union_name,
		a.account_type,
		s.current_balance 
	FROM account_types a
	INNER JOIN accounts s ON s.account_num = a.account_num
	INNER JOIN union_branch u ON u.id = s.union_id;

/* create trigger to track credit union branch name changes */
CREATE OR REPLACE FUNCTION log_branch_info_changes()
	RETURNS TRIGGER
	LANGUAGE PLPGSQL
	AS
$$
BEGIN 
	IF NEW.union_name <> OLD.union_name THEN
		INSERT INTO union_info_audit (union_id, union_name, changed_on)
		VALUES (OLD.id, OLD.union_name, NOW());
	ELSIF NEW.address <> OLD.address THEN
		INSERT INTO union_info_audit (union_id, address, changed_on)
		VALUES (OLD.id, OLD.address, NOW());
	ELSIF NEW.city <> OLD.city THEN
		INSERT INTO union_info_audit (union_id, city, state, changed_on)
		VALUES (OLD.id, OLD.city, NOW());
	ELSIF NEW.state <> OLD.state THEN
		INSERT INTO union_info_audit (union_id, state, changed_on)
		VALUES (OLD.id, OLD.state, NOW());
	ELSIF NEW.assests <> OLD.assests THEN
		INSERT INTO union_info_audit (union_id, assests, changed_on)
		VALUES (OLD.id, OLD.city, NOW());
	END IF;

	RETURN NEW;
END;
$$

-- main union branch trigger
CREATE TRIGGER branch_info_changes
	BEFORE UPDATE 
	ON union_branch
	FOR EACH ROW 
	EXECUTE PROCEDURE log_branch_info_changes();
	
/* create trigger to track changes in customer information */
CREATE OR REPLACE FUNCTION log_customer_info_changes()
	RETURNS TRIGGER
	LANGUAGE PLPGSQL
	AS
$$
BEGIN
	IF NEW.first_name <> OLD.first_name THEN
		INSERT INTO customer_info_audit (cust_id, first_name, changed_on)
		VALUES (OLD.id, OLD.first_name, NOW());
	ELSIF NEW.last_name <> OLD.last_name THEN
		INSERT INTO customer_info_audit (cust_id, last_name, changed_on)
		VALUES (OLD.id, OLD.last_name, NOW());
	ELSIF NEW.gender <> OLD.gender THEN
		INSERT INTO customer_info_audit (cust_id, credit_ID, changed_on)
		VALUES (OLD.id, OLD.credit_ID, NOW());
	ELSIF NEW.email <> OLD.email THEN
		INSERT INTO customer_info_audit (cust_id, email, changed_on)
		VALUES (OLD.id, OLD.email, NOW());
	ELSIF NEW.phoneNum <> OLD.phoneNum THEN
		INSERT INTO customer_info_audit (cust_id, phoneNum, changed_on)
		VALUES (OLD.id, OLD.phoneNum, NOW());
	ELSIF NEW.address <> OLD.address THEN 
		INSERT INTO customer_info_audit (cust_id, address, changed_on)
		VALUES (OLD.id, OLD.phoneNum, NOW());
	ELSIF NEW.city <> OLD.city THEN 
		INSERT INTO customer_info_audit (cust_id, city, changed_on)
		VALUES (OLD.id, OLD.city, NOW());
	ELSIF NEW.state <> OLD.state THEN 
		INSERT INTO customer_info_audit (cust_id, state, changed_on)
		VALUES (OLD.id, OLD.state, NOW());
	ELSIF NEW.latitude <> OLD.latitude THEN 
		INSERT INTO customer_info_audit (cust_id, latitude, changed_on)
		VALUES (OLD.id, OLD.latitude, NOW());
	ELSIF NEW.longitude <> OLD.longitude THEN 
		INSERT INTO customer_info_audit (cust_id, longitude, changed_on)
		VALUES (OLD.id, OLD.longitude, NOW());
	
	END IF;

	RETURN NEW; 
END;
$$

-- main customer trigger
CREATE TRIGGER customer_info_changes
	BEFORE UPDATE
	ON customer
	FOR EACH ROW 
	EXECUTE PROCEDURE log_customer_info_changes();
	
-- procedure to change assets value of a union_branch
CREATE OR REPLACE PROCEDURE assests_change (
		branch_id	VARCHAR(4),
		value	NUMERIC(14,2)
)
LANGUAGE plpgsql
AS $$
BEGIN
	UPDATE union_branch 
	SET assests = assests + value
	WHERE id = branch_id;

	COMMIT;
END; $$

-- procedure to change balance of an account
CREATE OR REPLACE PROCEDURE balance_change (
		cus_id	VARCHAR(4),
		branch_id VARCHAR(4),
		acc_num VARCHAR(3),
		value	NUMERIC(8,2)
)
LANGUAGE plpgsql
AS $$
BEGIN
	UPDATE accounts  
	SET current_balance = current_balance + value
	WHERE cust_id = cus_id AND union_id = branch_id AND account_num = acc_num ;

	COMMIT;
END; $$

-- procedure to tranfer money from one account to another
CREATE OR REPLACE PROCEDURE transfer(
	depositer VARCHAR(4),
	recipient VARCHAR(4),
	amount NUMERIC (8,2)
)
LANGUAGE plpgsql
AS $$
BEGIN
	-- subtract the amount from the depositer's account
	UPDATE accounts 
	SET current_balance = current_balance - amount
	WHERE cust_id = depositer;

	-- Add the amount from the depositer to repcient's account
	UPDATE accounts 
	SET current_balance = current_balance + amount
	WHERE cust_id = recipient;

	COMMIT;
END;$$