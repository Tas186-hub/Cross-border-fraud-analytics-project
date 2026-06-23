
 SQL Code for Cross-Border Fraud Project

This is the SQL script I wrote to dig into fraud trends and check how our blocking rules were actually performing across different international corridors. 

The queries here helped me look at user block rates, track down where chargebacks were spiking, and find out which system flags were actually catching fraud vs. just creating noise for real users. 

*Note: I changed the original database and table names to generic ones (`global_remit`) to keep company data private.
 What's in this file:
Section 1 (Investigative Queries:)  The step-by-step queries I ran to pull raw data for specific corridors like USD-COP, USD-BDT, and USD-TZS.
Section 2 (Optimized Summaries): The grouped rollups I used to pull total numbers and percentages for the final metrics tables.

Context & Objectives
This forensic investigation was initiated to address a massive spike in cross-border transaction chargebacks and analyze the efficiency of our automated risk logic. The goals were to isolate high-risk remittance pipelines, map localized fraud patterns, and identify redundant system flags causing high false-positive friction for legitimate users. To preserve company data privacy, all platform tables and databases have been anonymized under a generic global_remit schema.

Corridor Block Rates & Baseline Risk Analysis
The aim of this phase was to find the percentage of users blocked in each corridor. The calculation was approached by finding the total number of users blocked from all corridors, and the total users in each corridor, using this formula:

Percentage = total blocks in each corridor / total users in each corridor * 100

The corridors analyzed are:

GBP-TZS, USD-TZS, CAD-TZS, EUR-TZS

GBP-BDT, USD-BDT, CAD-BDT, EUR-BDT

GBP-COP, USD-COP, CAD-COP, EUR-COP

My Analysis:
From the data, it can be observed that users were mostly blocked in USD and CAD sending corridors. It can also be observed that only 6.88% of users sending to USD-COP are blocked with 19.4% of all users having chargebacks. Additionally, just 0.34% of users sending to USD-TZS are blocked, while 25% of all users have chargebacks. Finally, 0.69% of users sending to USD-BDT are blocked, with 13.88% of all USD-BDT users experiencing chargebacks.

COP Corridor

USD to COP: 6.88% user blocks | 45.4% corridor chargebacks | 19.4% users with chargebacks | 13.27% transactions with chargebacks

CAD to COP: 0% user blocks | 0% corridor chargebacks | 0% users with chargebacks | 0% transactions with chargebacks

EUR to COP: 0% user blocks | 0% corridor chargebacks | 0% users with chargebacks | 0% transactions with chargebacks

GBP to COP: 0% user blocks | 0% corridor chargebacks | 0% users with chargebacks | 0% transactions with chargebacks

TZS Corridor

USD to TZS: 0.34% user blocks | 35.46% corridor chargebacks | 25% users with chargebacks | 0.2% transactions with chargebacks

CAD to TZS: 0% user blocks | 0.24% corridor chargebacks | 1.38% users with chargebacks | 0% transactions with chargebacks

EUR to TZS: 0% user blocks | 0% corridor chargebacks | 0% users with chargebacks | 0% transactions with chargebacks

GBP to TZS: 0.05% user blocks | 0% corridor chargebacks | 0% users with chargebacks | 0% transactions with chargebacks

BDT Corridor

USD to BDT: 0.69% user blocks | 15.65% corridor chargebacks | 13.88% users with chargebacks | 0.43% transactions with chargebacks

CAD to BDT: 2.41% user blocks | 3.18% corridor chargebacks | 1.38% users with chargebacks | 3.85% transactions with chargebacks

EUR to BDT: 0.55% user blocks | 0% corridor chargebacks | 0% users with chargebacks | 0% transactions with chargebacks

GBP to BDT: 1.02% user blocks | 0% corridor chargebacks | 0% users with chargebacks | 0% transactions with chargebacks

Currencies Experiencing Increased Chargebacks Suspected of Fraud
The aim here was to find corridors that have high levels of fraud and chargebacks respectively. To answer this efficiently, chargebacks must have a 'fraud' status and correspond to a specific corridor.

The percentage was calculated using this formula:
Total chargebacks associated with fraud in each corridor / total chargebacks associated with fraud * 100

My Analysis:
From the numbers, it can be observed that chargebacks are very high in the US sending currency. It can also be observed that there are more chargebacks in USD-COP at 45.4% followed closely by USD-TZS at 35.36%. However, USD-TZS had an astonishing 50.5% of its chargebacks associated with fraud. This was followed closely by USD-COP at 28.43%.

Moreover, 58% of all users in USD-TZS were associated with fraud and had chargebacks, followed by USD-BDT and USD-COP where 29% and 12.9% of all users were associated with fraud and had chargebacks.

How These Rates Compare to the General Population
Using the same tables above, it can be seen that the only other relevant currency that had chargebacks associated with fraud is CAD. Interestingly, there are no fraud chargebacks in COP unlike in the previous analysis. This time however, CAD-BDT is leading with 3.18% in chargebacks with just 1.38% in users having chargebacks. Notably however, none of these users are associated with fraud, and hence the chargebacks are not said to have occurred as a result of fraud activity. For sending currencies EUR and GBP, there are no fraud chargebacks (no data) associated with any of the three receiving currencies and 0% of users sending from those corridors had chargebacks.

In conclusion, there is an increased level of chargebacks associated with fraud in USD and CAD sending currencies in all receiving currencies (COP, TZS, BDT).

CHARGEBACK AND FRAUD IN EACH CORRIDOR

USD-COP: 28.43% total chargebacks associated with fraud | 12.9% users associated with fraud and had chargebacks | 45.4% percentage of chargebacks in corridor | 19.4% percentage of users that had chargebacks

USD-TZS: 50.5% total chargebacks associated with fraud | 58% users associated with fraud and had chargebacks | 35.36% percentage of chargebacks in corridor | 25% percentage of users that had chargebacks

USD-BDT: 21.06% total chargebacks associated with fraud | 29% users associated with fraud and had chargebacks | 15.65% percentage of chargebacks in corridor | 13.88% percentage of users that had chargebacks

CAD-BDT: 0% total chargebacks associated with fraud | 0% users associated with fraud and had chargebacks | 3.18% percentage of chargebacks in corridor | 1.38% percentage of users that had chargebacks

(Note: All other corridors for CAD, EUR, and GBP to COP/TZS/BDT resulted in 0% across all metrics).

Identifying the “Worst” Performing Blocking Flag
The aim of this question is to find flags that are redundant, and not really useful in measuring fraud and chargeback rates. Such flags tend to lead to very huge and unnecessary flag volumes/blocks and are very ineffective in measuring rates of fraud.

My Analysis:
From the table, the LIMITED_DEVICE_INFO flag led to 5,676 flagged transactions. Only 2,430 users were associated with the 5,676 transactions, implying some users had multiple transactions with the same flag. Out of the 2,430 users, only 49 users were flagged as fraud. However, only 17 users recognized by the flag had chargebacks but no fraud status. And only three users were flagged by the flag, had chargebacks and were considered as fraud.

To determine the effectiveness of the flag, it was measured using these conditions: user’s transaction was flagged for Limited device info, user was in a ‘fraud’ status, user had a chargeback, and finally the user was marked as a confirmed fraudster. Only one single user met all of these conditions together. Therefore, while the flag triggered 5,676 times, it only led to one efficient, true fraud block. It has a true-positive conversion rate of just 0.04%, making it the worst-performing, most redundant flag in the ruleset.

Notable Patterns of Confirmed Fraudsters and Chargeback Recipients
Analysis I:
From the chargeback recipient data, it can be observed that a total of 52 recipients had chargebacks, and out of those, only 16 were associated/marked as fraudulent and also led to chargebacks. It can also be observed that only 29 transactions were marked as fraudulent and had also led to chargebacks.

Summary Line: 29 transactions associated with fraud and had chargebacks | 16 recipients associated with fraud and had chargebacks | 52 total recipients who had chargebacks

Analysis II:
To investigate deeper, chargeback recipients in each corridor were analyzed. Most chargeback recipients are associated with USD, with only one recipient in CAD having a chargeback recipient. Specifically, a total of 16 recipients had chargebacks with 7 marked as confirmed fraudsters (cf) in the USD-COP lane. This is followed by USD-TZS with 22 chargeback recipients, with 9 marked as scam victims (sv) and only 2 marked as confirmed fraudsters. USD-BDT had 11 chargeback recipients with 3 marked as sv and none marked as cf.

USD-COP Recipients: 16 total chargeback recipients | 7 associated with a cf | 0 associated with a sv

USD-TZS Recipients: 22 total chargeback recipients | 2 associated with a cf | 9 associated with a sv

USD-BDT Recipients: 11 total chargeback recipients | 0 associated with a cf | 3 associated with a sv

CAD-TZS / CAD-BDT: 2 recipients (TZS) and 1 recipient (BDT) had chargebacks, but 0 were associated with a cf or sv.

Analysis III: Flags Associated with Chargeback Recipients
For this analysis, only USD-COP, USD-TZS, and USD-BDT were analyzed since it is not worthwhile to investigate other corridors (0 chargebacks).

USD-COP Main Flags: MANY_PMS (16), LIMITED_DEVICE_INFO (11), LARGE_EARLY_TRANSFERS (14), EMAIL_CREATED_SAME_DAY (16)

USD-TZS Main Flags: POSSIBLE_SCAM_VICTIM (6), NEW_CARD_NEW_RECIP_PREV_RISKY_ERROR (2), LIMITED_DEVICE_INFO (2)

USD-BDT Main Flags: SCAM_VICTIM (2), BLOCKED_RECIP (1), LIMITED_DEVICE_INFO (1)

Analysis IV & V: Confirmed Fraudster Breakdown & Triggers
Only 8 users overall had chargebacks and were marked as cf. Out of the 8, 6 were marked as cf in USD-COP and 2 were marked as cf in USD-TZS.

USD-COP Confirmed Fraudster Flags: MANY_PMS (6 users), LARGE_EARLY_TRANSFERS (5 users), EMAIL_CREATED_SAME_DAY (6 users), LIMITED_DEVICE_INFO (4 users)

USD-TZS Confirmed Fraudster Flags: POSSIBLE_SCAM_VICTIM (1 user), RAPID_TX_NEW_CARD (1 user), SPLIT_LARGE_EARLY_TRANSACTION (1 user), No flag (1 user)

Promo Abuse Metrics:

GBP-BDT: 29 fraudulent users | 0 chargebacks

USD-COP: 3 fraudulent users | 0 chargebacks

USD-BDT: 1 fraudulent user | 0 chargebacks

Investigational Priorities & Recommendations
It can be observed that most chargeback recipients and confirmed fraudsters are dominant in the USD sending currency. USD-COP, USD-TZS, and USD-BDT are the corridors worth investigating as they are the only corridors with chargebacks. Patterns for each sending corridor are different:

USD-COP (Stolen Card Rings)
13.2% of all transactions sent in this corridor led to chargebacks, making up about 45% of all chargebacks in this dataset. Interestingly, only 12.9% of all chargeback users were marked as fraudulent. Out of all 14 chargeback users, only 6 were marked as confirmed fraudsters. 8 of all 14 chargeback users had charge failed sending patterns.

The fraud disposition associated with users in this corridor is “UNAUTHORIZED_CHARGE_NEW_USER,” which implies that many of the cards were stolen. This looks like an organized fraud ring profile: fresh accounts using disposable, same-day email domains, trying multiple payment card binds (MANY_PMS), dealing with card chargefails, and rushing to push large transfers (LARGE_EARLY_TRANSFERS) to cash out the maximum amount before the cards get flagged.

System Upgrades: Implement a mandatory ID + Selfie verification gate for accounts matching the multi-flag footprint (newly created email + multiple cards attempted). Set strict velocity limits on how many unique card IDs can be bound to one device within a 48-hour window.

For Representatives: If an account hits a combination of MANY_PMS and a brand new email, treat it as high risk. Check the device history to ensure it isn't shared across closed profiles. Look closely at the recipient; if a brand new account attempts a maximum limit transfer to a recipient with zero prior network history, that is a massive red flag. When calling, require a full, un-cropped screenshot of the transfer funding screen and inspect the system timestamps to ensure they aren't edited.

USD-TZS (Social Engineering & Scams)
Fraud in this corridor has mainly been associated with scam victims. Only 0.2% of all transactions sent in this corridor led to chargebacks, making up about 35.46% of all chargebacks. Interestingly, 58% of all chargeback users were marked as fraudulent and 50.5% of all chargebacks in this corridor are associated with fraud. Only 18 users in this corridor had chargebacks; 8 of them were marked as scam victims and only 2 marked as confirmed fraudsters. The most common flag was the ‘POSSIBLE_SCAM_VICTIM’ flag, and dispositions are ‘SCAM_VICTIM’ and ‘SCAM_VICTIM_UNCONFIRMED’.

Since scammers explicitly coach these victims on what to say, traditional technical indicators are often bypassed, leaving accounts with zero active system flags. The average scam transfer payout size hovers tightly around $250.

System Upgrades: Drop the automated manual review trigger threshold down to $250 for new recipients in this specific lane. Introduce localized, clear in-app warning screens before funds are released to actively disrupt the scammer's phone script.

For Representatives: Focus entirely on establishing a verified, real-world relationship between the sender and the receiver. If the sender cannot explain their connection to the recipient, seems highly anxious, or is being coached on another line, halt the transaction. Pay close attention to age indicators, verifying if the user's voice sounds vulnerable or matches an elder-abuse risk profile.

USD-BDT / GBP-BDT / CAD-BDT (Promo Abuse & Operational Disputes)
Fraud in these corridors has primarily been associated with scam victims and promo code abuse. 29 users used a promo code and were flagged as fraudulent in the GBP-BDT corridor, with only 1 in the USD-BDT corridor. Interestingly, none of the users linked to promo abuse had chargebacks, indicating a policy abuse problem rather than financial credit card fraud.

System Upgrades: Tighten promotional eligibility parameters by anchoring promo code use to a strict one-user, one-recipient limit to completely eliminate multi-accounting loops.

Data Enhancement Wishlist & Conclusion
If I could gather more data, I would add the following to enhance the investigation:

Flags and their Parameters: To better understand how the flag works and what threshold it operates on.

Overall financial losses resulting from these patterns.

Card and Device metadata.

Shared recipient fields (such as a primary phone number key) to see what other users are associated with a particular recipient profile.

Billing and Address data.

Conclusion:
The exercise was really enlightening and challenging. It allowed me to put into perspective how data is being analyzed by other departments and allowed me to appreciate a lot of the analytical work done behind the scenes. It has broadened my understanding about how choices are made and the raw data used to back up those decisions. It was exciting running different queries and watching the metrics cleanly match up.
