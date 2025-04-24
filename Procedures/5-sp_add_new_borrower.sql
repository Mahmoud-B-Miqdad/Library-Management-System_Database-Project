CREATE PROCEDURE sp_AddNewBorrower 
    @FirstName NVARCHAR(100), 
    @LastName NVARCHAR(100), 
    @Email NVARCHAR(255), 
    @DateOfBirth datetime, 
    @MembershipDate datetime
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Borrowers WHERE Email = @Email)
    BEGIN
        PRINT 'Error: Email already exists.'
    END
    ELSE
    BEGIN
        INSERT INTO Borrowers (FirstName, LastName, Email, DateOfBirth, MembershipDate)
        VALUES (@FirstName, @LastName, @Email, @DateOfBirth, @MembershipDate)

        SELECT SCOPE_IDENTITY() AS BorrowerID;
    END
END


	--Output// 1001
EXEC sp_AddNewBorrower 
    @FirstName = 'Mahmoud', 
    @LastName = 'Miqdad', 
    @Email = 'mahmoud.b.miqdad@gmail.com', 
    @DateOfBirth = '2003-04-1', 
    @MembershipDate = '2025-04-05';

	delete from Borrowers where BorrowerID = 1001;

	--Output// Error: Email already exists.
	EXEC sp_AddNewBorrower 
    @FirstName = 'John', 
    @LastName = 'Doe', 
    @Email = 'sbryer0@sina.com.cn', 
    @DateOfBirth = '1990-05-15', 
    @MembershipDate = '2022-10-15';

