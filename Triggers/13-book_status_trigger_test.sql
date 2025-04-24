CREATE TABLE AuditLog (
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    BookID INT NOT NULL,
    StatusChange NVARCHAR(100),
    ChangeDate DATETIME DEFAULT GETDATE()
);

CREATE TRIGGER trg_LogBookStatusChange
ON Books
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO AuditLog (BookID, StatusChange, ChangeDate)
    SELECT
        i.BookID,
        CONCAT(d.CurrentStatus, ' to ', i.CurrentStatus),
        GETDATE()
    FROM
        inserted i
    INNER JOIN
        deleted d ON i.BookID = d.BookID
    WHERE
        (d.CurrentStatus = 'Available' AND i.CurrentStatus = 'Borrowed')
        OR
        (d.CurrentStatus = 'Borrowed' AND i.CurrentStatus = 'Available');
END;

-- Try The TRIGGER
SELECT BookID, Title, CurrentStatus FROM Books WHERE BookID = 10;
-------------
UPDATE Books
SET CurrentStatus = 'Available'
WHERE BookID = 10;
-------------
SELECT * FROM AuditLog;
