CREATE TABLE credit_score(
	ID		VARCHAR(3) NOT NULL,
	score_range	VARCHAR(8) NOT NULL,
	credit_rating	VARCHAR(20) NOT NULL,
	CONSTRAINT cs_pkey PRIMARY KEY (ID),
	CONSTRAINT check_score_range CHECK (score_range IN ('300-579','580-669','670-739','740-799','800-850')),
	CONSTRAINT check_credit_rating CHECK (credit_rating IN ('Poor', 'Fair', 'Good', 'Very Good', 'Exceptional'))
);

CREATE TABLE loan_types (
	loan_num		VARCHAR(3) NOT NULL,
	loan_type	VARCHAR(30) NOT NULL,
	CONSTRAINT loan_pkey PRIMARY KEY (loan_num),
	CONSTRAINT check_loan_type CHECK (loan_type IN ('Auto','Mortgage','Personal','Student','Motorcycle, Boat & RV'))
);

CREATE TABLE account_types (
	account_num		VARCHAR(3) NOT NULL,
	account_type	VARCHAR(40) NOT NULL,
	CONSTRAINT acc_pkey PRIMARY KEY (account_num),
	CONSTRAINT check_acc_type CHECK (account_type IN ('Checkings','Savings','Money Market','Certificate of Deposit',
													  'Individual Retirement Account (IRA)','Education Savings Account (ESA)'))
);

CREATE TABLE customer (
	ID		VARCHAR(4) NOT NULL,
	first_name	VARCHAR(25) NOT NULL,
	last_name	VARCHAR(40) NOT NULL,
	gender		VARCHAR(50) NOT NULL,
	credit_ID	VARCHAR(3) NOT NULL,
	email		VARCHAR(80),
	phoneNum	VARCHAR(20),
	address		VARCHAR(70),
	city		VARCHAR(60) NOT NULL,
	state		VARCHAR(50) NOT NULL,
	latitude	DOUBLE PRECISION NOT NULL,
	longitude	DOUBLE PRECISION NOT NULL,
	CONSTRAINT cus_pkey	PRIMARY KEY (ID),
	CONSTRAINT cus_fkey FOREIGN KEY (credit_ID) REFERENCES credit_score(ID)
		ON DELETE CASCADE,
	CONSTRAINT gender_list CHECK (gender IN ('Female', 'Male', 'Non-binary', 'I Do Not Wish to Answer'))
);

CREATE TABLE union_branch (
	ID		VARCHAR(4) NOT NULL,
	union_name	VARCHAR(50) NOT NULL,
	address		VARCHAR(80) NOT NULL,
	city		VARCHAR(50) NOT NULL,
	state		VARCHAR(50) NOT NULL,
	assests		NUMERIC(14,2) NOT NULL,
	CONSTRAINT union_pkey PRIMARY KEY (ID),
	CONSTRAINT assests_check CHECK (assests > 0.00)
);

CREATE TABLE accounts (
	cust_ID		VARCHAR(4) NOT NULL,
	union_ID	VARCHAR(4) NOT NULL,
	account_num	VARCHAR(3) NOT NULL,
	date_opened	DATE NOT NULL DEFAULT CURRENT_DATE,
	date_closed	DATE,
	current_balance		NUMERIC(8,2),
	CONSTRAINT has_acc_pkey PRIMARY KEY (cust_ID, union_ID, account_num),
	CONSTRAINT has_acc_fkey1 FOREIGN KEY (cust_ID) REFERENCES customer(ID)
		ON DELETE CASCADE,
	CONSTRAINT has_acc_fkey2 FOREIGN KEY (union_ID) REFERENCES union_branch (ID)
		ON DELETE CASCADE,
	CONSTRAINT has_acc_fkey3 FOREIGN KEY (account_num) REFERENCES account_types (account_num)
		ON DELETE CASCADE
);

CREATE TABLE loans (
	cust_ID		VARCHAR(4) NOT NULL,
	union_ID	VARCHAR(4) NOT NULL,
	loan_num	VARCHAR(3) NOT NULL,
	start_date	DATE NOT NULL DEFAULT CURRENT_DATE,
	maturity_date	DATE NOT NULL DEFAULT CURRENT_DATE,
	principal	NUMERIC(8,2) NOT NULL,
	interest_apr	NUMERIC(4,2) NOT NULL,
	term_months		INTEGER NOT NULL,
	CONSTRAINT has_loan_pkey PRIMARY KEY (cust_ID, union_ID, loan_num),
	CONSTRAINT has_loan_fkey1 FOREIGN KEY (cust_ID) REFERENCES customer(ID)
		ON DELETE CASCADE,
	CONSTRAINT has_loan_fkey2 FOREIGN KEY (union_ID) REFERENCES union_branch (ID)
		ON DELETE CASCADE,
	CONSTRAINT has_loan_fkey3 FOREIGN KEY (loan_num) REFERENCES loan_types (loan_num)
		ON DELETE CASCADE,
	CONSTRAINT check_prin CHECK (principal > 0.00),
	CONSTRAINT check_apr CHECK (interest_apr >= 0.00),
	CONSTRAINT check_terms CHECK (term_months > 0)
);

CREATE TABLE union_info_audit (
	id INT GENERATED ALWAYS AS IDENTITY,
	union_id	VARCHAR(4),
	union_name	VARCHAR(50),
	address		VARCHAR(80),
	city		VARCHAR(50),
	state		VARCHAR(50),
	assests		NUMERIC(14,2),
	changed_on	TIMESTAMP(6) NOT NULL
);

CREATE TABLE customer_info_audit (
	id INT GENERATED ALWAYS AS IDENTITY,
	cust_id		VARCHAR(4),
	first_name	VARCHAR(25),
	last_name	VARCHAR(40),
	gender		VARCHAR(50),
	credit_ID	VARCHAR(3),
	email		VARCHAR(80),
	phoneNum	VARCHAR(20),
	address		VARCHAR(70),
	city		VARCHAR(60),
	state		VARCHAR(50),
	latitude	DOUBLE PRECISION,
	longitude	DOUBLE PRECISION,
	changed_on	TIMESTAMP(6) NOT NULL
);