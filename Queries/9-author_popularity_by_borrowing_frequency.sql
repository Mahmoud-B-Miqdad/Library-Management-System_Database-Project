WITH AuthorPopularity AS (
    SELECT 
        a.AuthorID,
        a.FirstName + ' ' + a.LastName AS AuthorName,
        COUNT(l.LoanID) AS BorrowCount
    FROM Authors a
    JOIN Books_Authors ba ON a.AuthorID = ba.AuthorID
    JOIN Books b ON ba.BookID = b.BookID
    JOIN Loans l ON b.BookID = l.BookID
    WHERE ba.Role IN ('Author', 'Co-Author')  
    GROUP BY a.AuthorID, a.FirstName, a.LastName
)
SELECT 
    AuthorName,
    BorrowCount
FROM AuthorPopularity
ORDER BY BorrowCount DESC;
