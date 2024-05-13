# Service station DB 
### schema demo (from my lab in PZ NULP)

![service_station](https://github.com/IraIvanishak/practice-squirrel/assets/110106748/e1b770f1-c24d-4117-b76d-9b4fd9b170d5)



### tasks for business analysis (for future migration to fact tables in data warehouse)

- Payback analysis of the details. Metric: **the percentage of the cost of details in the final check from the total amount of the repair.**
- Analysis of the deviation of the actual time of the repair from the specified time. Metric: **the ratio of the deviation time to the specified time**

Basic table - service_inventory

- Analysis of costs per supplier. Metric: **the total cost of supply from a particular supplier over a period of time**
- Analysis of the frequency of purchasing a specific details. Metric: **the number of a particular type of details ordered over a period of time**

Base table - supply_details
