WITH AgeGroupedBorrowers AS (
    SELECT 
        b.BorrowerID,
        b.FirstName,
        b.LastName,
        b.Email,
        b.DateOfBirth,
        CASE
            WHEN DATEDIFF(YEAR, b.DateOfBirth, GETDATE()) BETWEEN 0 AND 10 THEN '0-10'
            WHEN DATEDIFF(YEAR, b.DateOfBirth, GETDATE()) BETWEEN 11 AND 20 THEN '11-20'
            WHEN DATEDIFF(YEAR, b.DateOfBirth, GETDATE()) BETWEEN 21 AND 30 THEN '21-30'
            WHEN DATEDIFF(YEAR, b.DateOfBirth, GETDATE()) BETWEEN 31 AND 40 THEN '31-40'
            WHEN DATEDIFF(YEAR, b.DateOfBirth, GETDATE()) BETWEEN 41 AND 50 THEN '41-50'
            WHEN DATEDIFF(YEAR, b.DateOfBirth, GETDATE()) BETWEEN 51 AND 60 THEN '51-60'
            ELSE '60+'
        END AS AgeGroup
    FROM Borrowers b
)
SELECT 
    ag.AgeGroup,
    g.Name AS GenreName,
    COUNT(l.LoanID) AS BorrowCount
FROM Loans l
JOIN Books b ON l.BookID = b.BookID
JOIN Books_Genres bg ON b.BookID = bg.BookID
JOIN Genres g ON bg.GenreID = g.GenreID
JOIN AgeGroupedBorrowers ag ON l.BorrowerID = ag.BorrowerID
GROUP BY ag.AgeGroup, g.Name
HAVING COUNT(l.LoanID) > 1 
ORDER BY ag.AgeGroup, BorrowCount DESC;
