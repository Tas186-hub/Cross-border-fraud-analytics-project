
-- PROJECT: Cross-Border Fraud Analytics & Ruleset Investigation
-- CORE STACK: Cloud Data Warehouse (Standard SQL)The project will be organized by answering each
   question separately and then adding the analysis used to find the answers. 
   I'll break down the approach I took to answer each question in another document.
   Queries associated with each question, as well as any additional queries used,
   will be added in a separate document. THIS DOCUMENT ONLY CONTAINS QUERIES USED.

-- SECTION 1: INVESTIGATIVE QUERIES

-- QUESTION 1: What % of users were blocked in each corridor?

-- Total fraud in USD-COP:
select ub.u_id, ub.tx_id, UB.status
from `global_remit.risk_analytics.user_blocks` as UB
inner join `global_remit.risk_analytics.transactions` as T
on T.tx_id = UB.tx_id 
where UB.status = 'FRAUD'
  AND send_currency = 'USD' AND receive_currency = 'COP';

-- Total fraud in CAD-COP:
select ub.u_id, ub.tx_id, UB.status
from `global_remit.risk_analytics.user_blocks` as UB
inner join `global_remit.risk_analytics.transactions` as T
on T.tx_id = UB.tx_id 
where UB.status = 'FRAUD'
  AND send_currency = 'CAD' AND receive_currency = 'COP';

-- Total fraud in EUR-COP:
select ub.u_id, ub.tx_id, UB.status
from `global_remit.risk_analytics.user_blocks` as UB
inner join `global_remit.risk_analytics.transactions` as T
on T.tx_id = UB.tx_id 
where UB.status = 'FRAUD'
  AND send_currency = 'EUR' AND receive_currency = 'COP';

-- Total fraud in GBP-COP:
select ub.u_id, ub.tx_id, UB.status
from `global_remit.risk_analytics.user_blocks` as UB
inner join `global_remit.risk_analytics.transactions` as T
on T.tx_id = UB.tx_id 
where UB.status = 'FRAUD'
  AND send_currency = 'GBP' AND receive_currency = 'COP';

-- Total fraud in USD-BDT:
select ub.u_id, ub.tx_id, UB.status
from `global_remit.risk_analytics.user_blocks` as UB
inner join `global_remit.risk_analytics.transactions` as T
on T.tx_id = UB.tx_id 
where UB.status = 'FRAUD'
  AND send_currency = 'USD' AND receive_currency = 'BDT';

-- Total fraud in GBP-BDT:
select ub.u_id, ub.tx_id, UB.status
from `global_remit.risk_analytics.user_blocks` as UB
inner join `global_remit.risk_analytics.transactions` as T
on T.tx_id = UB.tx_id 
where UB.status = 'FRAUD'
  AND send_currency = 'GBP' AND receive_currency = 'BDT';

-- Total fraud in CAD-BDT:
select ub.u_id, ub.tx_id, UB.status
from `global_remit.risk_analytics.user_blocks` as UB
inner join `global_remit.risk_analytics.transactions` as T
on T.tx_id = UB.tx_id 
where UB.status = 'FRAUD'
  AND send_currency = 'CAD' AND receive_currency = 'BDT';

-- Total fraud in EUR-BDT:
select ub.u_id, ub.tx_id, UB.status
from `global_remit.risk_analytics.user_blocks` as UB
inner join `global_remit.risk_analytics.transactions` as T
on T.tx_id = UB.tx_id 
where UB.status = 'FRAUD'
  AND send_currency = 'EUR' AND receive_currency = 'BDT';

-- Total fraud in USD-TZS:
select ub.u_id, ub.tx_id, UB.status
from `global_remit.risk_analytics.user_blocks` as UB
inner join `global_remit.risk_analytics.transactions` as T
on T.tx_id = UB.tx_id 
where UB.status = 'FRAUD'
  AND send_currency = 'USD' AND receive_currency = 'TZS';

-- Total fraud in CAD-TZS:
select ub.u_id, ub.tx_id, UB.status
from `global_remit.risk_analytics.user_blocks` as UB
inner join `global_remit.risk_analytics.transactions` as T
on T.tx_id = UB.tx_id 
where UB.status = 'FRAUD'
  AND send_currency = 'CAD' AND receive_currency = 'TZS';

-- Total fraud in EUR-TZS:
select ub.u_id, ub.tx_id, UB.status
from `global_remit.risk_analytics.user_blocks` as UB
inner join `global_remit.risk_analytics.transactions` as T
on T.tx_id = UB.tx_id 
where UB.status = 'FRAUD'
  AND send_currency = 'EUR' AND receive_currency = 'TZS';

-- Total fraud in GBP-TZS:
select ub.u_id, ub.tx_id, UB.status
from `global_remit.risk_analytics.user_blocks` as UB
inner join `global_remit.risk_analytics.transactions` as T
on T.tx_id = UB.tx_id 
where UB.status = 'FRAUD'
  AND send_currency = 'GBP' AND receive_currency = 'TZS';


-- QUESTION 2: Which corridors experience increased levels of chargebacks?

-- Total chargebacks in GBP-TZS:
select C.u_id, C.tx_id, C.amount
from `global_remit.risk_analytics.chargebacks` as C
inner join `global_remit.risk_analytics.transactions` as T
on T.tx_id = C.tx_id
AND send_currency = 'GBP' AND receive_currency = 'TZS';

-- Total chargebacks in USD-TZS:
select C.u_id, C.tx_id, C.amount
from `global_remit.risk_analytics.chargebacks` as C
inner join `global_remit.risk_analytics.transactions` as T
on T.tx_id = C.tx_id
AND send_currency = 'USD' AND receive_currency = 'TZS';

-- Total chargebacks in CAD-TZS:
select C.u_id, C.tx_id, C.amount
from `global_remit.risk_analytics.chargebacks` as C
inner join `global_remit.risk_analytics.transactions` as T
on T.tx_id = C.tx_id
AND send_currency = 'CAD' AND receive_currency = 'TZS';

-- Total chargebacks in EUR-TZS:
select C.u_id, C.tx_id, C.amount
from `global_remit.risk_analytics.chargebacks` as C
inner join `global_remit.risk_analytics.transactions` as T
on T.tx_id = C.tx_id
AND send_currency = 'EUR' AND receive_currency = 'TZS';

-- QUESTION 3: How do these rates compare to the general population?


-- Total number successful for USD-COP:
select u.u_id, T.tx_id
from `global_remit.risk_analytics.users` as U
inner join `global_remit.risk_analytics.transactions` as T
on T.u_id = U.u_id 
where send_currency = 'USD' AND receive_currency = 'COP'
  AND T.status = 'SUCCESS';


-- SECTION 2: PRODUCTION ROLLUPS & SYSTEM RECOVERY LOOPS

SELECT 
    T.send_currency,
    T.receive_currency,
    COUNT(DISTINCT T.u_id) AS total_active_users,
    COUNT(DISTINCT CASE WHEN UB.status = 'FRAUD' THEN UB.u_id END) AS total_fraud_blocked_users,
    ROUND(COUNT(DISTINCT CASE WHEN UB.status = 'FRAUD' THEN UB.u_id END) * 100.0 / COUNT(DISTINCT T.u_id), 2) AS user_block_percentage
FROM `global_remit.risk_analytics.transactions` AS T
LEFT JOIN `global_remit.risk_analytics.user_blocks` AS UB 
    ON T.tx_id = UB.tx_id
GROUP BY T.send_currency, T.receive_currency
ORDER BY user_block_percentage DESC;

-- QUESTION 4: What is the "worst" performing blocking flag?

SELECT 
    UB.flag_name,
    COUNT(T.tx_id) AS total_number_of_transactions,
    COUNT(DISTINCT T.u_id) AS total_number_of_users,
    COUNT(DISTINCT CASE WHEN UB.status = 'FRAUD' THEN T.u_id END) AS total_number_of_users_flagged_as_fraudulent,
    COUNT(DISTINCT C.u_id) AS total_number_of_users_associated_with_flag_that_had_chargebacks,
    COUNT(DISTINCT CASE WHEN UB.status = 'FRAUD' AND C.tx_id IS NOT NULL THEN T.u_id END) AS unique_users_with_chargebacks_plus_fraud_status
FROM `global_remit.risk_analytics.transactions` AS T
INNER JOIN `global_remit.risk_analytics.user_blocks` AS UB 
    ON T.tx_id = UB.tx_id
LEFT JOIN `global_remit.risk_analytics.chargebacks` AS C 
    ON T.tx_id = C.tx_id
GROUP BY UB.flag_name
ORDER BY total_number_of_transactions DESC;
