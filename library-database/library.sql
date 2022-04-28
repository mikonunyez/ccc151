-- initialize database
CREATE TABLE IF NOT EXISTS book( --stores information on each book
	id SERIAL PRIMARY KEY,
	name VARCHAR(50) UNIQUE NOT NULL,
	publication_date DATE NOT NULL,
	genre VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS author( --stores information on all authors
	id SERIAL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS book_author( --links a book to an author and vice-versa. allows many-many relatinship
	book_id SERIAL,
	author_id SERIAL,
	CONSTRAINT fk_book FOREIGN KEY (book_id) REFERENCES book(id),
	CONSTRAINT fk_author FOREIGN KEY (author_id) REFERENCES author(id)
);

CREATE TABLE IF NOT EXISTS librarian( --stores information about the library librarians
	id SERIAL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS borrower( --stores information on borrowers
	id SERIAL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL
);

--borrowing_transaction() handles the borrowing transaction process
--stores information about each transaction. 
--only allows 2 books to be borrowed at the same time. 
--books can be returned at separate times
CREATE TABLE IF NOT EXISTS borrowing_transaction( 
	borrower_id SERIAL NOT NULL,
	book1_id SERIAL NOT NULL,
	book2_id SERIAL,
	librarian_id SERIAL NOT NULL,
	book1_borrowed_date DATE NOT NULL,
	book1_returned_date DATE,
	book2_borrowed_date DATE,
	book2_returned_date DATE,
	PRIMARY KEY (borrower_id, book1_id, book2_id, librarian_id),
	CONSTRAINT fk_borrower FOREIGN KEY(borrower_id) REFERENCES borrower(id),
	CONSTRAINT fk_book1 FOREIGN KEY(book1_id) REFERENCES book(id),
	CONSTRAINT fk_book2 FOREIGN KEY(book2_id) REFERENCES book(id),
	CONSTRAINT fk_librarian FOREIGN KEY(librarian_id) REFERENCES librarian(id)
);


--
-- code below inserts data into the database
--


-- authors
INSERT INTO author(first_name, last_name)
VALUES('Joseph','Menn');

INSERT INTO author(first_name, last_name)
VALUES('Joanne','Rowling');

INSERT INTO author(first_name, last_name)
VALUES('Stephen','King');

INSERT INTO author(first_name, last_name)
VALUES('George','Martin');

INSERT INTO author(first_name, last_name)
VALUES('Erika','Mitchell');


-- books
INSERT INTO book(name, publication_date, genre)
VALUES(
	'Cult of the Dead Cow',
	'2019-06-04',
	'Biography'
);

INSERT INTO book(name, publication_date, genre)
VALUES(
	'It',
	'1986-09-15',
	'Horror'
);

INSERT INTO book(name, publication_date, genre)
VALUES(
	'A Game of Thrones',
	'1996-08-01',
	'Epic Fantasy'
);

INSERT INTO book(name, publication_date, genre)
VALUES(
	'Fifty Shades of Grey',
	'2012-04-17',
	'Erotic Romance Novel'
);

INSERT INTO book(name, publication_date, genre)
VALUES(
	'Harry Potter and the Sorcerer''s Stone',
	'1997-06-27',
	'High Fantasy'
);


-- book/author relationship
INSERT INTO book_author(book_id, author_id)
VALUES ('1','1');

INSERT INTO book_author(book_id, author_id)
VALUES ('2','3');

INSERT INTO book_author(book_id, author_id)
VALUES ('3','4');

INSERT INTO book_author(book_id, author_id)
VALUES ('4','5');

INSERT INTO book_author(book_id, author_id)
VALUES ('5','2');

-- borrower
INSERT INTO borrower(first_name, last_name)
VALUES('Kent','Cabahug');

INSERT INTO borrower(first_name, last_name)
VALUES('John','Smith');

INSERT INTO borrower(first_name, last_name)
VALUES('Edward','Snowden');

INSERT INTO borrower(first_name, last_name)
VALUES('Charrles','Leclerc');

INSERT INTO borrower(first_name, last_name)
VALUES('Lewis','Hamilton');

-- librarian
INSERT INTO librarian(first_name, last_name)
VALUES('Andrea','Dovizioso');

INSERT INTO librarian(first_name, last_name)
VALUES('Brad','Binder');

INSERT INTO librarian(first_name, last_name)
VALUES('Takaaki','Nakagami');

INSERT INTO librarian(first_name, last_name)
VALUES('Jack','Miller');

INSERT INTO librarian(first_name, last_name)
VALUES('Joan','Mir');

-- borrowing_trarnsaction
INSERT INTO borrowing_transaction(
	borrower_id, 
	book1_id, 
	book2_id, 
	librarian_id, 
	book1_borrowed_date, 
	book1_returned_date,
	book2_borrowed_date
)
VALUES(
	1, 4, 2, 1, '2020-01-01','2021-01-01','2022-05-09'
);

INSERT INTO borrowing_transaction(
	borrower_id, 
	book1_id, 
	librarian_id, 
	book1_borrowed_date
)
VALUES(
	2, 4, 1, '2022-03-02'
);

INSERT INTO borrowing_transaction(
	borrower_id, 
	book1_id, 
	book2_id,
	librarian_id, 
	book1_borrowed_date, 
	book1_returned_date,
	book2_borrowed_date,
	book2_returned_date
)
VALUES(
	3, 1, 5, 3, '2021-11-12', '2021-11-22', '2021-11-12', '2021-11-22'
);

INSERT INTO borrowing_transaction(
	borrower_id, 
	book1_id,
	book2_id,
	librarian_id, 
	book1_borrowed_date,
	book2_borrowed_date
)
VALUES(
	4, 3, 4, 4, '2022-01-15', '2022-03-05'
);

INSERT INTO borrowing_transaction(
	borrower_id, 
	book1_id, 
	librarian_id, 
	book1_borrowed_date, 
	book1_returned_date
)
VALUES(
	5, 2, 5, '2022-01-15', '2022-01-25'
);