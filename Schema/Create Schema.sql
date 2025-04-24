CREATE TABLE ShelfLocation (
    ShelfLocationID INT PRIMARY KEY IDENTITY(1,1),
    HallName VARCHAR(100) NOT NULL,
    ShelfNumber INT NOT NULL
);

CREATE TABLE Books (
    BookID INT PRIMARY KEY IDENTITY(1,1),
    Title VARCHAR(MAX) NOT NULL,
    ISBN VARCHAR(20) NOT NULL UNIQUE,
    PublishedDate DATE,
    CurrentStatus VARCHAR(20) NOT NULL DEFAULT 'Available',
    ShelfLocationID INT NOT NULL,
    FOREIGN KEY (ShelfLocationID) REFERENCES ShelfLocation(ShelfLocationID)
);

CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL
);

CREATE TABLE Books_Authors (
    BooksAuthorsID INT PRIMARY KEY IDENTITY(1,1),
    BookID INT NOT NULL,
    AuthorID INT NOT NULL,
    Role VARCHAR(50),
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
);

CREATE TABLE Genres (
    GenreID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Books_Genres (
    BooksGenresID INT PRIMARY KEY IDENTITY(1,1),
    BookID INT NOT NULL,
    GenreID INT NOT NULL,
    PrimaryGenre BIT DEFAULT 0,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (GenreID) REFERENCES Genres(GenreID)
);

CREATE TABLE Borrowers (
    BorrowerID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Email VARCHAR(255) NOT NULL UNIQUE,
    DateOfBirth DATE,
    MembershipDate DATE NOT NULL
);

CREATE TABLE Loans (
    LoanID INT PRIMARY KEY IDENTITY(1,1),
    BookID INT NOT NULL,
    BorrowerID INT NOT NULL,
    DateBorrowed DATE NOT NULL,
    DueDate DATE NOT NULL,
    DateReturned DATE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (BorrowerID) REFERENCES Borrowers(BorrowerID)
);