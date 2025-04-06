CREATE FUNCTION fn_CalculateOverdueFees (@LoanID INT)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @OverdueDays INT;
    DECLARE @Fee DECIMAL(10, 2);

    SELECT @OverdueDays = DATEDIFF(DAY, DueDate, DateReturned)
    FROM Loans
    WHERE LoanID = @LoanID;

    IF @OverdueDays <= 30
    BEGIN
        SET @Fee = @OverdueDays * 1.00;
    END
    ELSE
    BEGIN
        SET @Fee = 30 * 1.00 + (@OverdueDays - 30) * 2.00;
    END

    RETURN @Fee;
END

--Try The Function

SELECT 
    l.LoanID,
    l.DateBorrowed,
    l.DueDate,
    l.DateReturned,
    dbo.fn_CalculateOverdueFees(l.LoanID) AS OverdueFee
FROM Loans l
WHERE l.LoanID = 9;