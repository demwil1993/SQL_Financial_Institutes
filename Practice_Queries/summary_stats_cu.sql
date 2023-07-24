/* summary statistics of principal column */
WITH RECURSIVE summary_stats_prin AS 
(
		SELECT
			ROUND(AVG(principal),2) AS average_principal,
			PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY principal) AS median_principal,
			MIN(principal) AS minimum_principal,
			MAX(principal) AS maximum_principal,
			(MAX(principal) - MIN(principal)) AS principal_range,
			ROUND(STDDEV_SAMP(principal),2) AS principal_standard_deviation,
			ROUND(VAR_SAMP(principal),2) AS principal_variance,
			PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY principal) AS Q1_principal,
			PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY principal) AS Q3_principal
		FROM loan_info_master
),
stats_by_row AS
(
	SELECT
		1 AS id,
		'avg_principal' AS statistic,
		average_principal AS value
	FROM summary_stats_prin
	UNION
	SELECT 
		2,
		'median_principal',
		median_principal
	FROM summary_stats_prin
	UNION
	SELECT
		3,
		'min_principal',
		minimum_principal
	FROM summary_stats_prin
	UNION
	SELECT
		4,
		'max_principal',
		maximum_principal
	FROM summary_stats_prin
	UNION
	SELECT
		5,
		'principal_range',
		principal_range
	FROM summary_stats_prin
	UNION
	SELECT
		6,
		'principal_std',
		principal_standard_deviation
	FROM summary_stats_prin
	UNION
	SELECT
		7,
		'principal_var',
		principal_variance
	FROM summary_stats_prin
	UNION
	SELECT
		8,
		'Q1_principal',
		Q1_principal
	FROM summary_stats_prin
	UNION
	SELECT
		9,
		'Q3_principal',
		Q3_principal
	FROM summary_stats_prin
	UNION
	SELECT
		10,
		'IQR',
		(Q3_principal - Q1_principal)
	FROM summary_stats_prin
	UNION
	SELECT
		11,
		'principal_skewness',
		ROUND(3 * (average_principal - median_principal)::NUMERIC / principal_standard_deviation, 2) AS principal_skewness
	FROM summary_stats_prin
)
SELECT *
FROM stats_by_row
ORDER BY id;


/* summary statistics of intrerest column */
WITH RECURSIVE summary_stats_interest AS 
(
		SELECT
			ROUND(AVG(interest_apr),2) AS average_apr,
			PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY interest_apr) AS median_apr,
			MIN(interest_apr) AS minimum_apr,
			MAX(interest_apr) AS maximum_apr,
			(MAX(interest_apr) - MIN(interest_apr)) AS apr_range,
			ROUND(STDDEV_SAMP(interest_apr),2) AS apr_standard_deviation,
			ROUND(VAR_SAMP(interest_apr),2) AS apr_variance,
			PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY interest_apr) AS Q1_apr,
			PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY interest_apr) AS Q3_apr
		FROM loan_info_master
),
stats_by_row AS
(
	SELECT
		1 AS id,
		'avg_apr' AS statistic,
		average_apr AS value
	FROM summary_stats_interest
	UNION
	SELECT 
		2,
		'median_apr',
		median_apr
	FROM summary_stats_interest
	UNION
	SELECT
		3,
		'min_apr',
		minimum_apr
	FROM summary_stats_interest
	UNION
	SELECT
		4,
		'max_apr',
		maximum_apr
	FROM summary_stats_interest
	UNION
	SELECT
		5,
		'apr_range',
		apr_range
	FROM summary_stats_interest
	UNION
	SELECT
		6,
		'apr_std',
		apr_standard_deviation
	FROM summary_stats_interest
	UNION
	SELECT
		7,
		'apr_var',
		apr_variance
	FROM summary_stats_interest
	UNION
	SELECT
		8,
		'Q1_apr',
		Q1_apr
	FROM summary_stats_interest
	UNION
	SELECT
		9,
		'Q3_apr',
		Q3_apr
	FROM summary_stats_interest
	UNION
	SELECT
		10,
		'IQR',
		(Q3_apr - Q1_apr)
	FROM summary_stats_interest
	UNION
	SELECT
		11,
		'principal_skewness',
		ROUND(3 * (average_apr - median_apr)::NUMERIC / apr_standard_deviation, 2) AS apr_skewness
	FROM summary_stats_interest
)
SELECT *
FROM stats_by_row
ORDER BY id;


/* summary statistics of term of loan column */
WITH RECURSIVE summary_stats_terms AS 
(
		SELECT
			ROUND(AVG(term_months),2) AS average_terms,
			PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY term_months) AS median_terms,
			MIN(term_months) AS minimum_terms,
			MAX(term_months) AS maximum_terms,
			(MAX(term_months) - MIN(term_months)) AS terms_range,
			ROUND(STDDEV_SAMP(term_months),2) AS terms_standard_deviation,
			ROUND(VAR_SAMP(term_months),2) AS terms_variance,
			PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY term_months) AS Q1_terms,
			PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY term_months) AS Q3_terms
		FROM loan_info_master
),
stats_by_row AS
(
	SELECT
		1 AS id,
		'avg_terms' AS statistic,
		average_terms AS value
	FROM summary_stats_terms
	UNION
	SELECT 
		2,
		'median_terms',
		median_terms
	FROM summary_stats_terms
	UNION
	SELECT
		3,
		'min_terms',
		minimum_terms
	FROM summary_stats_terms
	UNION
	SELECT
		4,
		'max_terms',
		maximum_terms
	FROM summary_stats_terms
	UNION
	SELECT
		5,
		'terms_range',
		terms_range
	FROM summary_stats_terms
	UNION
	SELECT
		6,
		'terms_std',
		terms_standard_deviation
	FROM summary_stats_terms
	UNION
	SELECT
		7,
		'terms_var',
		terms_variance
	FROM summary_stats_terms
	UNION
	SELECT
		8,
		'Q1_terms',
		Q1_terms
	FROM summary_stats_terms
	UNION
	SELECT
		9,
		'Q3_terms',
		Q3_terms
	FROM summary_stats_terms
	UNION
	SELECT
		10,
		'IQR',
		(Q3_terms - Q1_terms)
	FROM summary_stats_terms
	UNION
	SELECT
		11,
		'terms_skewness',
		ROUND(3 * (average_terms - median_terms)::NUMERIC / terms_standard_deviation, 2) AS terms_skewness
	FROM summary_stats_terms
)
SELECT *
FROM stats_by_row
ORDER BY id;


/* summary statistics of payments per month column */
WITH RECURSIVE summary_stats_payment AS 
(
		SELECT
			ROUND(AVG(monthly_payment),2) AS average_payment,
			PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY monthly_payment) AS median_payment,
			MIN(monthly_payment) AS minimum_payment,
			MAX(monthly_payment) AS maximum_payment,
			(MAX(monthly_payment) - MIN(monthly_payment)) AS payment_range,
			ROUND(STDDEV_SAMP(monthly_payment),2) AS payment_standard_deviation,
			ROUND(VAR_SAMP(monthly_payment),2) AS payment_variance,
			PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY monthly_payment) AS Q1_payment,
			PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY monthly_payment) AS Q3_payment
		FROM loan_info_master
),
stats_by_row AS
(
	SELECT
		1 AS id,
		'avg_payment' AS statistic,
		average_payment AS value
	FROM summary_stats_payment
	UNION
	SELECT 
		2,
		'median_payment',
		median_payment
	FROM summary_stats_payment
	UNION
	SELECT
		3,
		'min_payment',
		minimum_payment
	FROM summary_stats_payment
	UNION
	SELECT
		4,
		'max_payment',
		maximum_payment
	FROM summary_stats_payment
	UNION
	SELECT
		5,
		'payment_range',
		payment_range
	FROM summary_stats_payment
	UNION
	SELECT
		6,
		'payment_std',
		payment_standard_deviation
	FROM summary_stats_payment
	UNION
	SELECT
		7,
		'payment_var',
		payment_variance
	FROM summary_stats_payment
	UNION
	SELECT
		8,
		'Q1_payment',
		Q1_payment
	FROM summary_stats_payment
	UNION
	SELECT
		9,
		'Q3_payment',
		Q3_payment
	FROM summary_stats_payment
	UNION
	SELECT
		10,
		'IQR',
		(Q3_payment - Q1_payment)
	FROM summary_stats_payment
	UNION
	SELECT
		11,
		'payment_skewness',
		ROUND(3 * (average_payment - median_payment)::NUMERIC / payment_standard_deviation, 2) AS payment_skewness
	FROM summary_stats_payment
)
SELECT *
FROM stats_by_row
ORDER BY id;


/* summary stats for union_name column */
-- find the mode 
SELECT
	MODE() WITHIN GROUP (ORDER BY union_name) AS branch_mode
FROM loan_info_master;

-- cardinality
SELECT 
	COUNT(DISTINCT union_name) AS branch_card
FROM loan_info_master;

-- make a frequency table 
SELECT
	union_name,
	COUNT(union_name) AS branch_freq,
	ROUND(COUNT(union_name)::NUMERIC / SUM(COUNT(union_name)) OVER(), 2) AS rel_freq
FROM loan_info_master
GROUP BY union_name 
ORDER BY branch_freq DESC;

/* summary stats FOR loan_type column */
-- find the mode
SELECT
	MODE() WITHIN GROUP (ORDER BY loan_type) AS loan_mode
FROM loan_info_master;

-- cardinality
SELECT
	COUNT(DISTINCT loan_type) AS loan_card
FROM loan_info_master;

-- make a frequency table 
SELECT
	loan_type,
	COUNT(loan_type) AS loan_freq,
	ROUND(COUNT(loan_type)::NUMERIC / SUM(COUNT(loan_type)) OVER(), 2) AS rel_freq
FROM loan_info_master
GROUP BY loan_type  
ORDER BY loan_freq DESC;

/* let's check some correlations between the numerical columns  */
-- check correlation between principal and loan term
SELECT
	ROUND(CORR(principal, term_months)::NUMERIC,2) AS prin_months
FROM loan_info_master;

-- check correlation between principal and apr
SELECT
	ROUND(CORR(principal, interest_apr)::NUMERIC,2) AS prin_months
FROM loan_info_master;

-- check correlation between principal and monthly payment 
SELECT
	ROUND(CORR(principal, monthly_payment)::NUMERIC,2) AS prin_months
FROM loan_info_master;


-- find the averages of principal, apr, loan term, and payments grouped by loan_type
SELECT
	l.loan_type,
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY l.principal) AS med_prin,
	ROUND(AVG(l.principal), 2) AS avg_prin,
	ROUND(AVG(l.interest_apr), 2) AS avg_apr,
	ROUND(AVG(l.term_months), 2) AS avg_term,
	ROUND(AVG(l.monthly_payment), 2) AS avg_pay
FROM loan_info_master l
GROUP BY l.loan_type;

-- find the averages of principal, apr, loan term, and payments grouped by branch
SELECT
	l.union_name,
	ROUND(AVG(l.principal), 2) AS avg_prin,
	ROUND(AVG(l.interest_apr), 2) AS avg_apr,
	ROUND(AVG(l.term_months), 2) AS avg_term,
	ROUND(AVG(l.monthly_payment), 2) AS avg_pay
FROM loan_info_master l
GROUP BY l.union_name;