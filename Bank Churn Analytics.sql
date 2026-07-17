USE Bank_Churn_Analytics;
GO

-- 1. Overall churn rate
SELECT 
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS Customers_Churned,
    CAST(SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS Churn_Rate_Pct
FROM Churn_Modelling;

-- 2. Churn by Geography
SELECT 
    Geography,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS Customers_Churned,
    CAST(SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS Churn_Rate_Pct
FROM Churn_Modelling
GROUP BY Geography
ORDER BY Churn_Rate_Pct DESC;

-- 3. Churn by Gender
SELECT 
    Gender,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS Customers_Churned,
    CAST(SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS Churn_Rate_Pct
FROM Churn_Modelling
GROUP BY Gender;

-- 4. Churn by Age Group
SELECT 
    CASE 
        WHEN Age < 30 THEN '18-29'
        WHEN Age BETWEEN 30 AND 39 THEN '30-39'
        WHEN Age BETWEEN 40 AND 49 THEN '40-49'
        WHEN Age BETWEEN 50 AND 59 THEN '50-59'
        ELSE '60+'
    END AS Age_Group,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS Customers_Churned,
    CAST(SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS Churn_Rate_Pct
FROM Churn_Modelling
GROUP BY 
    CASE 
        WHEN Age < 30 THEN '18-29'
        WHEN Age BETWEEN 30 AND 39 THEN '30-39'
        WHEN Age BETWEEN 40 AND 49 THEN '40-49'
        WHEN Age BETWEEN 50 AND 59 THEN '50-59'
        ELSE '60+'
    END
ORDER BY Age_Group;

-- 5. Churn by Number of Products
SELECT 
    NumOfProducts,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS Customers_Churned,
    CAST(SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS Churn_Rate_Pct
FROM Churn_Modelling
GROUP BY NumOfProducts
ORDER BY NumOfProducts;

-- 6. Churn by Active Member status
SELECT 
    IsActiveMember,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS Customers_Churned,
    CAST(SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS Churn_Rate_Pct
FROM Churn_Modelling
GROUP BY IsActiveMember;

-- 7. Churn by Credit Card ownership
SELECT 
    HasCrCard,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS Customers_Churned,
    CAST(SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS Churn_Rate_Pct
FROM Churn_Modelling
GROUP BY HasCrCard;

-- 8. Average Balance: churned vs retained
SELECT 
    Exited,
    COUNT(*) AS Customer_Count,
    AVG(Balance) AS Avg_Balance,
    AVG(CreditScore) AS Avg_Credit_Score,
    AVG(EstimatedSalary) AS Avg_Estimated_Salary
FROM Churn_Modelling
GROUP BY Exited;

-- 9. Churn by Credit Score band
SELECT 
    CASE 
        WHEN CreditScore < 500 THEN 'Poor (<500)'
        WHEN CreditScore BETWEEN 500 AND 649 THEN 'Fair (500-649)'
        WHEN CreditScore BETWEEN 650 AND 749 THEN 'Good (650-749)'
        ELSE 'Excellent (750+)'
    END AS Credit_Score_Band,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS Customers_Churned,
    CAST(SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS Churn_Rate_Pct
FROM Churn_Modelling
GROUP BY 
    CASE 
        WHEN CreditScore < 500 THEN 'Poor (<500)'
        WHEN CreditScore BETWEEN 500 AND 649 THEN 'Fair (500-649)'
        WHEN CreditScore BETWEEN 650 AND 749 THEN 'Good (650-749)'
        ELSE 'Excellent (750+)'
    END
ORDER BY Churn_Rate_Pct DESC;

-- 10. Churn by Tenure
SELECT 
    Tenure,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS Customers_Churned,
    CAST(SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS Churn_Rate_Pct
FROM Churn_Modelling
GROUP BY Tenure
ORDER BY Tenure;

-- 11. Top 5 highest-risk segments
SELECT TOP 5
    Geography,
    Gender,
    IsActiveMember,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS Customers_Churned,
    CAST(SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS Churn_Rate_Pct
FROM Churn_Modelling
GROUP BY Geography, Gender, IsActiveMember
HAVING COUNT(*) >= 30
ORDER BY Churn_Rate_Pct DESC;