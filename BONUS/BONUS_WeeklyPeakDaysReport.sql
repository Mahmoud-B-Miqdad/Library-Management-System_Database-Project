WITH LoanDays AS (
    SELECT 
        DATENAME(WEEKDAY, l.DateBorrowed) AS WeekDay,
        COUNT(*) AS LoanCount
    FROM Loans l
    GROUP BY DATENAME(WEEKDAY, l.DateBorrowed)
)

SELECT TOP 3
    WeekDay,
    LoanCount,
    CAST(LoanCount AS FLOAT) / (SELECT COUNT(*) FROM Loans) * 100 AS Percentage
FROM LoanDays
ORDER BY Percentage DESC
