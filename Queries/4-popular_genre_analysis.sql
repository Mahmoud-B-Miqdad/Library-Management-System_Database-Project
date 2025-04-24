DECLARE @TargetMonth INT = 3;

WITH GenrePopularity AS (
    SELECT 
        g.Name AS GenreName,
        COUNT(l.LoanID) AS LoanCount,
        RANK() OVER (ORDER BY COUNT(l.LoanID) DESC) AS PopularityRank
    FROM Loans l
    JOIN Books b ON l.BookID = b.BookID
    JOIN Books_Genres bg ON b.BookID = bg.BookID
    JOIN Genres g ON bg.GenreID = g.GenreID
    WHERE MONTH(l.DateBorrowed) = @TargetMonth
    GROUP BY g.Name
)

SELECT 
    GenreName,
    LoanCount,
    PopularityRank
FROM GenrePopularity
WHERE PopularityRank = 1
ORDER BY LoanCount DESC;
