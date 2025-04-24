WITH ActiveBorrowers AS (
    SELECT 
        BorrowerID,
        COUNT(BookID) AS BorrowedBooks
    FROM Loans
    WHERE DateReturned IS NULL  
    GROUP BY BorrowerID
    HAVING COUNT(BookID) >= 2 
)
SELECT 
    B.BorrowerID,
    B.FirstName,
    B.LastName,
    B.Email,
    AB.BorrowedBooks
FROM Borrowers B
JOIN ActiveBorrowers AB ON B.BorrowerID = AB.BorrowerID
ORDER BY AB.BorrowedBooks DESC;
