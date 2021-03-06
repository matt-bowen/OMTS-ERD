drop database OMTS;

create database OMTS;

CREATE TABLE Complex
(
	name		VARCHAR(15)	NOT NULL,
	street_num	INTEGER,
	street_name	VARCHAR(15),
	city		VARCHAR(15),
	prov		VARCHAR(15),
	postal		VARCHAR(7),
	phone_num	INTEGER,
	PRIMARY KEY(name)
);

CREATE TABLE Theater
(
	th_num		INTEGER		NOT NULL,
	complex_name	VARCHAR(15)	NOT NULL,
	max_seats	INTEGER		NOT NULL,
	screen_size	VARCHAR(6),
	PRIMARY KEY(th_num, complex_name),
	FOREIGN KEY(complex_name) REFERENCES Complex(name)
);

CREATE TABLE Company
(	
	name		VARCHAR(15)	NOT NULL,
	street_num	INTEGER,
	street_name	VARCHAR(15),
	city		VARCHAR(15),
	prov		VARCHAR(15),
	postal		VARCHAR(7),
	phone_num	INTEGER,
	contact		VARCHAR(30),
	PRIMARY KEY(name)
);

CREATE TABLE Movie
(
	title		VARCHAR(30)	NOT NULL,
	run_time	INTEGER,
	rating		VARCHAR(4),
	director	VARCHAR(30),
	actors		VARCHAR(100),
	synopsis	VARCHAR(200),
	supplier	VARCHAR(15),
	prod_company	VARCHAR(15)	NOT NULL,
	PRIMARY KEY(title),
	FOREIGN KEY(prod_company) REFERENCES Company(name)
);

CREATE TABLE Start_Dates
(
	complex_name	VARCHAR(15)	NOT NULL,
	movie_title	VARCHAR(30)	NOT NULL,
	date		DATE		NOT NULL,
	PRIMARY KEY(complex_name, movie_title),
	FOREIGN KEY(complex_name) REFERENCES Complex(name),
	FOREIGN KEY(movie_title) REFERENCES Movie(title)
);

CREATE TABLE End_Dates
(
	complex_name	VARCHAR(15)	NOT NULL,
	movie_title	VARCHAR(30)	NOT NULL,
	date		DATE		NOT NULL,
	PRIMARY KEY(complex_name, movie_title),
	FOREIGN KEY(complex_name) REFERENCES Complex(name),
	FOREIGN KEY(movie_title) REFERENCES Movie(title)
);

CREATE TABLE Customer
(
	acct_num	INTEGER		NOT NULL,
	password	VARCHAR(30)	NOT NULL,
	f_name		VARCHAR(15),
	l_name		VARCHAR(15),
	street_num	INTEGER,
	street_name	VARCHAR(15),
	city		VARCHAR(15),
	prov		VARCHAR(15),
	postal		VARCHAR(7),
	phone_num	INTEGER,
	email		VARCHAR(25),
	cc_num		VARCHAR(25)	NOT NULL,
	cc_exp		DATE		NOT NULL,
	PRIMARY KEY(acct_num)
);

CREATE TABLE Reviews
(
	movie_title	VARCHAR(30)	NOT NULL,
	cust_num	INTEGER		NOT NULL,
	review		VARCHAR(300)	NOT NULL,
	PRIMARY KEY(movie_title, cust_num, review),
	FOREIGN KEY(movie_title) REFERENCES Movie(title),
	FOREIGN KEY(cust_num) REFERENCES Customer(acct_num)
);

CREATE TABLE Showing
(
	start_time	TIME		NOT NULL,
	complex		VARCHAR(15) 	NOT NULL,
	th_num		INTEGER		NOT NULL,
	movie_title	VARCHAR(30)	NOT NULL,
	total_seats_res	INTEGER		NOT NULL,
	PRIMARY KEY(start_time, complex, th_num, movie_title),
	FOREIGN KEY(complex) REFERENCES Complex(name),
	FOREIGN KEY(th_num) REFERENCES Theater(th_num),
	FOREIGN KEY(movie_title) REFERENCES Movie(title)
);

CREATE TABLE Reservation
(
	cust_num	INTEGER		NOT NULL,
	seats		INTEGER		NOT NULL,
	start_time	TIME		NOT NULL,
	movie_title	VARCHAR(30)	NOT NULL,
	th_num		INTEGER		NOT NULL,
	complex		VARCHAR(15)	NOT NULL,
	PRIMARY KEY(cust_num, seats, movie_title),
	FOREIGN KEY(cust_num) REFERENCES Customer(acct_num),
	FOREIGN KEY(start_time) REFERENCES Showing(start_time),
	FOREIGN KEY(movie_title) REFERENCES Movie(title),
	FOREIGN KEY(th_num) REFERENCES Theater(th_num),
	FOREIGN KEY(complex) REFERENCES Complex(name)
);

INSERT INTO Complex VALUES
("Odeon", 626, "Gardiners Rd.", "Kingston", "Ontario", "K7K1R6", 6136340152),
("Screening Room", 120, "Princess St.", "Kingston", "Ontario", "K7K1R6", 6135426080),
("Landmark", 120, "Dalton Ave.", "Kingston", "Ontario", "K7K1R6", 6135477887)
;

INSERT INTO Theater VALUES
(1, "Odeon", 50, "Small"),
(2, "Odeon", 70, "Medium"),
(3, "Odeon", 90, "Large"),
(1, "Screening Room", 20, "Small"),
(2, "Screening Room", 50, "Large"),
(1, "Landmark", 50, "Small"),
(2, "Landmark", 50, "Small"),
(3, "Landmark", 100, "Large"),
(4, "Landmark", 100, "Large")
;

INSERT INTO Company VALUES
("Warner Bros", 1, "Hollywood Ave.", "Kingston", "Ontario", "K7K1R6", 1234567890, "Mr. Contact"),
("Marvel Studios", NULL, NULL, NULL, NULL, NULL, NULL, NULL),
("Indian Paintbrush", NULL, NULL, NULL, NULL, NULL, NULL, NULL),
("TSG Entertainment", NULL, NULL, NULL, NULL, NULL, NULL, NULL),
("Blumhouse Productions", NULL, NULL, NULL, NULL, NULL, NULL, NULL),
("Syncopy Inc", NULL, NULL, NULL, NULL, NULL, NULL, NULL)
;

INSERT INTO Movie VALUES
("Black Panther", 120, "PG13", "Ryan Coogler", "Chadwick Boseman, Michael B. Jordan, Lupita Nyong'o, Letitia Wright", "Masked hero saves the day", "Disney Studios", "Marvel Studios"),
("Isle of Dogs", 101, "PG", "Wes Anderson", "Bryan Cranston, Edward Norton, Bill Murray, Jeff Goldblum", "Dogs save child", "Fox Searchlight", "Indian Paintbrush"),
("Shape of Water", 123, "PG13", "Guillermo del Toro", "Sally Hawkins, Michael Shannon, Octavia Spencer, Richard Jenkins", "Deaf woman finds love in an unlikely place", "Fox Searchlight", "TSG Entertainment"),
("Get Out", 103, "R", "Jordan Peele", "Daniel Kaluuya, Allison Williams, Bradley Whitford", "Man finds himself in a sticky situation with his girlfriend's parents", "Universal Pictures", "Blumhouse Productions"),
("Dunkirk", 106, "R", "Christopher Nolan", "Fionn Whitehead, Tom Hardy, Cillian Murphy, Kenneth Branagh, Harry Styles", "The battle of dunkirk", "Warner Bros", "Syncopy Inc")
;

INSERT INTO Start_Dates VALUES
("Odeon", "Black Panther", "2018-02-14"),
("Odeon", "Dunkirk", "2018-01-01"),
("Landmark", "Black Panther", "2018-02-20"),
("Landmark", "Get Out", "2018-02-14"),
("Screening Room", "Black Panther", "2018-02-21"),
("Screening Room", "Isle of Dogs", "2018-04-28"),
("Screening Room", "Shape of Water", "2018-01-15")
;

INSERT INTO End_Dates VALUES
("Odeon", "Black Panther", "2018-04-14"),
("Odeon", "Dunkirk", "2018-04-01"),
("Landmark", "Black Panther", "2018-05-01"),
("Landmark", "Get Out", "2018-04-01"),
("Screening Room", "Black Panther", "2018-04-01"),
("Screening Room", "Isle of Dogs", "2018-06-10"),
("Screening Room", "Shape of Water", "2018-04-15")
;

INSERT INTO Customer VALUES
(1001, "admin", "ad", "min", NULL, NULL, NULL, NULL, NULL, 0987654321, "admin@omts.com", 0, "2020-01-01"),
(1002, "matt", "Matt", "Bowen", 1, "yeet", "yeetville", "yeetario", "1A1A1A", 123456, "matt@email.com", 987654, "2021-01-03")
;

INSERT INTO Reviews VALUES
("Black Panther", 1001, "10/10 would watch again")
;

INSERT INTO Showing VALUES
("9:00", "Odeon", 1, "Black Panther", 0),
("7:30", "Odeon", 2, "Dunkirk", 0),
("10:00", "Odeon", 2, "Dunkirk", 0),
("7:30", "Landmark", 1, "Black Panther", 0),
("10:00", "Landmark", 2, "Get Out", 0),
("8:00", "Screening Room", 2, "Black Panther", 0),
("8:30", "Screening Room", 1, "Isle of Dogs", 0),
("10:00", "Screening Room", 1, "Isle of Dogs", 0),
("10:30", "Screening Room", 2, "Shape of Water", 0)
;





























	
