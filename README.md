
 SQL Code for Cross-Border Fraud Project

This is the SQL script I wrote to dig into fraud trends and check how our blocking rules were actually performing across different international corridors. 

The queries here helped me look at user block rates, track down where chargebacks were spiking, and find out which system flags were actually catching fraud vs. just creating noise for real users. 

*Note: I changed the original database and table names to generic ones (`global_remit`) to keep company data private.
 What's in this file:
Section 1 (Investigative Queries:)  The step-by-step queries I ran to pull raw data for specific corridors like USD-COP, USD-BDT, and USD-TZS.
Section 2 (Optimized Summaries): The grouped rollups I used to pull total numbers and percentages for the final metrics tables.
