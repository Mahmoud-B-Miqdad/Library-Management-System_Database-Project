-- I have not created indexes on the primary key columns, 
--as SQL Server automatically creates clustered indexes for these columns. 
--This ensures optimal performance for queries involving primary keys without the need for manual indexing.


-- Create an index on the foreign key columns used in the JOIN
CREATE INDEX idx_loans_bookid ON Loans(BookID);
CREATE INDEX idx_loans_borrowerid ON Loans(BorrowerID);
CREATE INDEX idx_books_authors_authorid ON Books_Authors(AuthorID);
CREATE INDEX idx_books_authors_bookid ON Books_Authors(BookID);
CREATE INDEX idx_books_genres_bookid ON Books_Genres(BookID);
CREATE INDEX idx_books_genres_genreid ON Books_Genres(GenreID);
CREATE INDEX idx_books_shelflocationid ON Books(ShelfLocationID);

-- Create an index on the columns used for filtering, 
--ensuring that indexes on datetime-type columns are included.
CREATE INDEX idx_books_currentstatus ON Books(CurrentStatus);
CREATE INDEX idx_books_genres_primarygenre ON Books_Genres(PrimaryGenre);
CREATE INDEX idx_books_authors_role ON Books_Authors(Role);
CREATE INDEX idx_loans_dateborrowed ON Loans(DateBorrowed);
CREATE INDEX idx_loans_duedate ON Loans(DueDate);
CREATE INDEX idx_Loans_datereturned ON Loans (DateReturned);
CREATE INDEX idx_borrowers_dateofbirth ON Borrowers (DateOfBirth);
CREATE INDEX idx_borrowers_membershipdate ON Borrowers (MembershipDate);


-- Create an index on the columns that contain unique values.
CREATE UNIQUE INDEX idx_borrowers_email ON Borrowers(Email);
CREATE UNIQUE INDEX idx_books_ISBN ON Books (ISBN);
