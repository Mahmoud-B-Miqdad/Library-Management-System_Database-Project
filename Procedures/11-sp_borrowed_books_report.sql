CREATE PROCEDURE sp_BorrowedBooksReport
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
		b.BookID,
        b.Title AS BookTitle,
        br.FirstName + ' ' + br.LastName AS BorrowerName,
        l.DateBorrowed
    FROM Loans l
    INNER JOIN Books b ON l.BookID = b.BookID
    INNER JOIN Borrowers br ON l.BorrowerID = br.BorrowerID
    WHERE l.DateBorrowed BETWEEN @StartDate AND @EndDate
    ORDER BY l.DateBorrowed;
END;

-- Try The PROCEDURE
EXEC sp_BorrowedBooksReport @StartDate = '2025-01-01', @EndDate = '2025-1-31';
