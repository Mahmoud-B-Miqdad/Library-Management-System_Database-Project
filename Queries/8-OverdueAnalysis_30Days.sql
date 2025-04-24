SELECT 
    b.Title AS BookTitle,
    l.LoanID,
    l.DateBorrowed,
    l.DueDate,
    DATEDIFF(DAY, l.DueDate, GETDATE()) AS OverdueDays,
    br.FirstName AS BorrowerFirstName,
    br.LastName AS BorrowerLastName,
    br.Email AS BorrowerEmail
FROM Loans l
JOIN Books b ON l.BookID = b.BookID
JOIN Borrowers br ON l.BorrowerID = br.BorrowerID
WHERE l.DateReturned IS NULL 
    AND DATEDIFF(DAY, l.DueDate, GETDATE()) > 30
ORDER BY OverdueDays DESC;
