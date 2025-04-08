CREATE PROCEDURE sp_GetOverdueBooksPerBorrower
AS
BEGIN
    SET NOCOUNT ON;

    CREATE TABLE #OverdueBorrowers (
        BorrowerID INT PRIMARY KEY
    );

    INSERT INTO #OverdueBorrowers (BorrowerID)
    SELECT DISTINCT BorrowerID
    FROM Loans
    WHERE DateReturned IS NULL AND DueDate < GETDATE();

    SELECT 
        b.BorrowerID,
        b.FirstName,
        b.LastName,
		bk.BookID,
        bk.Title AS BookTitle,
        l.DateBorrowed,
        l.DueDate
    FROM #OverdueBorrowers ob
    JOIN Borrowers b ON b.BorrowerID = ob.BorrowerID
    JOIN Loans l ON l.BorrowerID = ob.BorrowerID
    JOIN Books bk ON bk.BookID = l.BookID
    WHERE l.DateReturned IS NULL AND l.DueDate < GETDATE()
    ORDER BY b.BorrowerID, l.DueDate;

    DROP TABLE #OverdueBorrowers;
END;

--Try The PROCEDURE
SET STATISTICS TIME ON;
EXEC sp_GetOverdueBooksPerBorrower;
SET STATISTICS TIME OFF;
