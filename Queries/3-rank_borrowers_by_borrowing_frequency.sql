WITH BorrowerFrequency AS (
    SELECT 
        BorrowerID,
        COUNT(*) AS BorrowedBooks
    FROM Loans
    --WHERE DateReturned IS NOT NULL  
    GROUP BY BorrowerID
)

SELECT 
    b.BorrowerID,
    b.FirstName,
    b.LastName,
    b.Email,
    bf.BorrowedBooks,
    RANK() OVER (ORDER BY bf.BorrowedBooks DESC) AS BorrowerRank
FROM Borrowers b
JOIN BorrowerFrequency bf ON b.BorrowerID = bf.BorrowerID
ORDER BY BorrowerRank;