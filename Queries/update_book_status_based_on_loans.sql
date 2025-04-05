UPDATE Books
SET CurrentStatus = 'Borrowed'
WHERE BookID IN (
    SELECT BookID
    FROM Loans
    WHERE DateReturned IS NULL
);

UPDATE Books
SET CurrentStatus = 'Available'
WHERE BookID IN (
    SELECT BookID
    FROM Loans
    WHERE DateReturned IS NOT NULL
);