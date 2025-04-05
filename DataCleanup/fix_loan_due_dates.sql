UPDATE Loans
SET DueDate = DATEADD(DAY, 7, DateBorrowed)
WHERE DueDate < DateBorrowed;

UPDATE Loans
SET DueDate = DATEADD(DAY, -1, DateReturned)
WHERE DateReturned IS NOT NULL AND DueDate > DateReturned;
