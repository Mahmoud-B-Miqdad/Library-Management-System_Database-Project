DECLARE @BorrowerID INT = 99;

SELECT 
	B.BookID,
    B.Title AS BookTitle,
	B.CurrentStatus,
    L.DateBorrowed,
    L.DueDate,
    L.DateReturned,
    CASE 
        WHEN L.DateReturned IS NULL THEN 'Not Returned'
        ELSE 'Returned'
    END AS ReturnStatus
FROM Loans L
JOIN Books B ON L.BookID = B.BookID
WHERE L.BorrowerID = @BorrowerID;