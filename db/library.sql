DROP
  SCHEMA IF EXISTS books;

CREATE SCHEMA books;

USE books;

CREATE TABLE
  authors (
    author_id INTEGER PRIMARY KEY NOT NULL auto_increment,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    common_name VARCHAR(255) NOT NULL
  );

CREATE TABLE
  books (
    book_id INTEGER PRIMARY KEY NOT NULL auto_increment,
    title VARCHAR(255) NOT NULL,
    publish_year INTEGER,
    isbn VARCHAR(255),
    notes VARCHAR(1024)
  );

CREATE TABLE
  books_authors (
    book_author_id INTEGER PRIMARY KEY NOT NULL auto_increment,
    book_id INTEGER NOT NULL,
    author_id INTEGER NOT NULL,
    FOREIGN key (book_id) REFERENCES books (book_id),
    FOREIGN key (author_id) REFERENCES authors (author_id)
  );

CREATE TABLE
  book_series (
    book_series_id INTEGER PRIMARY KEY NOT NULL auto_increment,
    series_name VARCHAR(1024),
    current_book_id INTEGER NOT NULL,
    next_book_id INTEGER,
    FOREIGN key (current_book_id) REFERENCES books (book_id),
    FOREIGN key (next_book_id) REFERENCES books (book_id)
  );

CREATE TABLE
  patrons (
    patron_id INTEGER PRIMARY KEY NOT NULL auto_increment,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    date_of_birth DATE NOT NULL,
    email VARCHAR(255),
    phone_number VARCHAR(30),
    city VARCHAR(255),
    province VARCHAR(100),
    postal_code VARCHAR(10)
  );

CREATE TABLE
  inventory (
    inventory_id INTEGER PRIMARY KEY NOT NULL auto_increment,
    book_id INTEGER NOT NULL,
    inventory INTEGER NOT NULL,
    FOREIGN key (book_id) REFERENCES books (book_id)
  );

CREATE TABLE
  circulation (
    circulation_id INTEGER PRIMARY KEY NOT NULL auto_increment,
    book_id INTEGER NOT NULL,
    patron_id INTEGER NOT NULL,
    checkout_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE,
    FOREIGN key (book_id) REFERENCES books (book_id),
    FOREIGN key (patron_id) REFERENCES patrons (patron_id)
  );

DROP USER IF EXISTS 'lcs_access';

CREATE USER lcs_access IDENTIFIED BY 'lcsaccess07';

GRANT SELECT, INSERT, UPDATE, DELETE ON books.* TO lcs_access;

INSERT INTO
  authors
VALUES
  (1, 'Gabriel', 'Garcia Márquez', 'Gabriel Garcia Márquez'),
  (2, 'Herman', 'Melville', 'Herman Melville'),
  (3, 'John', 'Steinbeck', 'John Steinbeck'),
  (4, 'Francis', 'Fitzgerald', 'F. Scott Fitzgerald'),
  (5, 'Robert', 'Parker', 'Robert B. Parker'),
  (6, 'Isabel', 'Allende', 'Isabel Allende'),
  (7, 'Nora', 'Ephron', 'Nora Ephron'),
  (8, 'Joanne', 'Rowling', 'J. K. Rowling'),
  (9, 'John', 'Tolkien', 'J. R. R. Tolkien'),
  (10, 'Arch', 'Whitehead', 'Colson Whitehead');

-- book_id, title, publish_year, isbn, notes
INSERT INTO
  books (book_id, title, publish_year, isbn)
VALUES
  (1, 'One Hundred Years of Solitude', 1967, '9780060883287'),
  (2, 'Love in the Time of Cholera', 1985, '9780060883287'),
  (3, 'The General in His Labyrinth', 1989, '9781400034703'),
  (4, 'Moby-Dick; or, the Whale', 1851, '9780143105954'),
  (5, 'The Grapes of Wrath', 1939, '9780143039433'),
  (6, 'Travels with Charley: In Search of America', 1962, '9780140053203'),
  (7, 'The Great Gatsby', 1925, '9798745274824'),
  (8, 'The Godwulf Manuscript', 1973, '9780440129615'),
  (9, 'Mortal Stakes', 1975, '9780440157588'),
  (10, 'A Savage Place', 1981, '9780440180951'),
  (11, 'The Widening Gyre', 1983, '9780440195351'),
  (12, 'The House of the Spirits', 1982, '9781501117015'),
  (13, 'Zorro', 2005, '9780007201983'),
  (14, 'Heartburn', 1983, '9781844085170'),
  (15, 'I Remember Nothing: And Other Reflections', 2010, '9780307742803'),
  (16, 'Harry Potter and the Philosopher''s Stone', 1997, '9781408855898'),
  (17, 'Harry Potter and the Chamber of Secrets', 1998, '9781338299151'),
  (18, 'Harry Potter and the Prisoner of Azkaban', 1999, '9781526606167'),
  (19, 'The Hobbit', 1937, '9780547928227'),
  (20, 'The Fellowship of the Ring', 1954, '9780358380238'),
  (21, 'The Two Towers', 1954, '9780547928203'),
  (22, 'The Return of the King', 1955, '9780547928197'),
  (23, 'Zone One', 2011, '9780307455178'),
  (24, 'The Underground Railroad', 2016, '9780345804327'),
  (25, 'The Nickel Boys', 2019, '9780345804341');

INSERT INTO
  book_series (series_name, current_book_id, next_book_id)
VALUES
  ('The Lord Of the Rings', 19, 20),
  ('The Lord Of the Rings', 20, 21),
  ('The Lord Of the Rings', 21, 22),
  ('The Lord Of the Rings', 22, NULL),
  ('Harry Potter', 16, 17),
  ('Harry Potter', 17, 18),
  ('Harry Potter', 18, NULL),
  ('Spenser', 8, 9),
  ('Spenser', 9, 10),
  ('Spenser', 10, 11),
  ('Spenser', 11, NULL);

INSERT INTO
  books_authors (book_id, author_id)
VALUES
  (1, 1),
  (2, 1),
  (3, 1),
  (4, 2),
  (5, 3),
  (6, 3),
  (7, 4),
  (8, 5),
  (9, 5),
  (10, 5),
  (11, 5),
  (12, 6),
  (13, 6),
  (14, 7),
  (15, 7),
  (16, 8),
  (17, 8),
  (18, 8),
  (19, 9),
  (20, 9),
  (21, 9),
  (22, 9),
  (23, 10),
  (24, 10),
  (25, 10);

INSERT INTO
  inventory
VALUES
  (1, 1, 4),
  (2, 2, 3),
  (3, 3, 9),
  (4, 4, 8),
  (5, 5, 9),
  (6, 6, 2),
  (7, 7, 5),
  (8, 8, 6),
  (9, 9, 4),
  (10, 10, 6),
  (11, 11, 9),
  (12, 12, 8),
  (13, 13, 5),
  (14, 14, 4),
  (15, 15, 5),
  (16, 16, 4),
  (17, 17, 6),
  (18, 18, 7),
  (19, 19, 6),
  (20, 20, 1),
  (21, 21, 9),
  (22, 22, 5),
  (23, 23, 7),
  (24, 24, 9),
  (25, 25, 3);

-- patron_id, first_name, last_name, date_of_birth, email, phone_number, city, province, postal_code
INSERT INTO
  patrons
VALUES
  (
    1,
    'Mujtaba',
    'Fiolek',
    '1997-11-26',
    'Mujtaba_Fiolek@messages.org',
    '(575) 487-6568',
    'Ferriday',
    'LA',
    '71334'
  ),
  (
    2,
    'Baltej',
    'Baker',
    '1996-03-17',
    'Baltej_Baker@libero.it',
    '(308) 688-2058',
    'Austin',
    'TX',
    '73344'
  ),
  (
    3,
    'Christopher',
    'Smith',
    '2000-02-13',
    'Christopher_Smith@hotmail.com',
    '(848) 646-2354',
    'Kilgore',
    'TX',
    '75663'
  ),
  (
    4,
    'Thomas',
    'Filinaite',
    '1998-02-05',
    'Thomas_Filinaite@yahoo.com',
    '(309) 930-8293',
    'Hillman',
    'MN',
    '56338'
  ),
  (
    5,
    'Joseph',
    'Casey',
    '1999-04-25',
    'Joseph_Casey@alibaba.cn',
    '(783) 809-8230',
    'San Jose',
    'CA',
    '95191'
  ),
  (
    6,
    'Chidinma',
    'Nathan',
    '1998-02-18',
    'Chidinma_Nathan@yahoo.com',
    '(247) 922-3094',
    'Twin Falls',
    'ID',
    '83301'
  ),
  (
    7,
    'Andre',
    'Patel',
    '1994-11-19',
    'Andre_Patel@yahoo.com',
    '(207) 639-4885',
    'Lorane',
    'OR',
    '97451'
  ),
  (
    8,
    'Andre',
    'Lora',
    '1997-12-22',
    'Andre_Lora@gmail.com',
    '(425) 361-2024',
    'Point Pleasant',
    'PA',
    '18950'
  ),
  (
    9,
    'Charlie',
    'O''Reilly ',
    '1999-02-03 ',
    'Charlie_O_Reilly@bt.co.uk',
    '(214) 333-9931',
    'Glencoe',
    'OH',
    '43928'
  ),
  (
    10,
    'Anthony',
    'Ogualiri',
    '1998-09-20',
    'Anthony_Ogualiri@rogers.ca',
    '(789) 977-5356',
    'Slidell',
    'LA',
    '70459'
  ),
  (
    11,
    'Idris',
    'Wallace',
    '1997-04-11',
    'Idris_Wallace@messages.org',
    '(427) 270-6676',
    'Rebuck',
    'PA',
    '17867'
  ),
  (
    12,
    'Mujtaba',
    'Iaconis',
    '2000-04-27',
    'Mujtaba_Iaconis@comcast.net',
    '(310) 309-7966',
    'Spartanburg',
    'SC',
    '29319'
  ),
  (
    13,
    'Joel',
    'Saffiullah',
    '1996-08-13',
    'Joel_Saffiullah@hotmail.com',
    '(531) 409-6420',
    'Memphis',
    'TN',
    '38177'
  ),
  (
    14,
    'Idris',
    'Mick',
    '1997-03-26',
    'Idris_Mick@comcast.net',
    '(837) 651-2216',
    'Eugene',
    'OR',
    '97401'
  ),
  (
    15,
    'Michael',
    'Abou-Francis',
    '2000-05-02',
    'Michael_Abou-Francis@comcast.net',
    '(649) 545-1173',
    'Karlsruhe',
    'ND',
    '58744'
  ),
  (
    16,
    'Daniel',
    'Antohi',
    '1997-06-19',
    'Daniel_Antohi@aol.com',
    '(678) 848-2087',
    'Miami',
    'FL',
    '33173'
  ),
  (
    17,
    'Tim',
    'Nasser',
    '1999-07-01',
    'Tim_Nasser@email.net',
    '(889) 678-9263',
    'Atlanta',
    'GA',
    '30388'
  ),
  (
    18,
    'Adam',
    'Kotlinski',
    '1995-03-27',
    'Adam_Kotlinski@rogers.ca',
    '(313) 600-8863',
    'Oregon',
    'OH',
    '43618'
  ),
  (
    19,
    'Michael',
    'Sardary',
    '1994-10-30',
    'Michael_Sardary@outlook.com',
    '(523) 712-9386',
    'Aurora',
    'CO',
    '80047'
  ),
  (
    20,
    'Fatima',
    'Wishart',
    '1995-06-03',
    'Fatima_Wishart@rogers.ca',
    '(309) 540-8397',
    'Florissant',
    'MO',
    '63033'
  ),
  (
    21,
    'Baltej',
    'Howe',
    '2000-03-13',
    'Baltej_Howe@email.net',
    '(276) 934-6604',
    'Los Angeles',
    'CA',
    '90065'
  ),
  (
    22,
    'Maria',
    'Yohannes',
    '1995-10-23',
    'Maria_Yohannes@yandex.ru',
    '(787) 208-7018',
    'Hendrix',
    'OK',
    '74741'
  ),
  (
    23,
    'Daniel',
    'Gritter',
    '1996-05-24',
    'Daniel_Gritter@bt.co.uk',
    '(400) 892-2200',
    'Linn',
    'KS',
    '66953'
  ),
  (
    24,
    'Mujtaba',
    'Portillo',
    '1994-09-16',
    'Mujtaba_Portillo@yahoo.com',
    '(671) 368-5561',
    'Cedar Key',
    'FL',
    '32625'
  ),
  (
    25,
    'Hector',
    'Whig',
    '1998-05-05',
    'Hector_Whig@email.net',
    '(352) 277-2684',
    'Marne',
    'IA',
    '51552'
  ),
  (
    26,
    'Peter',
    'Keezer',
    '1996-01-10',
    'Peter_Keezer@bt.co.uk',
    '(236) 873-9742',
    'Nolan',
    'TX',
    '79537'
  ),
  (
    27,
    'Seena Rose',
    'Travers',
    '1997-11-17',
    'Seena Rose_Travers@email.net',
    '(286) 303-4184',
    'Roanoke',
    'VA',
    '24042'
  ),
  (
    28,
    'Callum',
    'Castillo',
    '1996-07-03',
    'Callum_Castillo@comcast.net',
    '(832) 257-9603',
    'Cabin John',
    'MD',
    '20818'
  ),
  (
    29,
    'Andre',
    'Yang',
    '1996-09-27',
    'Andre_Yang@gmail.com',
    '(543) 422-9911',
    'Dallas',
    'WV',
    '26036'
  ),
  (
    30,
    'Vasile',
    'Villanueva',
    '1994-11-16',
    'Vasile_Villanueva@hotmail.com',
    '(616) 504-4842',
    'Southwestern Manitoba',
    'Manitoba',
    'R0M 2L9'
  ),
  (
    31,
    'Andre',
    'Ogle',
    '2000-05-01',
    'Andre_Ogle@yahoo.com',
    '(985) 666-8976',
    'Cap-aux-meules',
    'Quebec',
    'G0B 4Q5'
  ),
  (
    32,
    'Charlie',
    'Ejiofor',
    '1995-09-24',
    'Charlie_Ejiofor@alibaba.cn',
    '(638) 621-4308',
    'Abitibi-Témiscamingue-Est',
    'Quebec',
    'J0Y 604'
  ),
  (
    33,
    'Maria',
    'Whiteman',
    '1998-08-04',
    'Maria_Whiteman@messages.org',
    '(977) 996-9550',
    'Valleyfield',
    'Quebec',
    'J7X 8M3'
  ),
  (
    34,
    'Dylan',
    'McDonagh',
    '1996-08-11',
    'Dylan_McDonagh@libero.it',
    '(635) 335-9541',
    'East Kootenays',
    'British Columbia',
    'V0B 0B5'
  ),
  (
    35,
    'Michal',
    'Mazzarese',
    '1997-12-12',
    'Michal_Mazzarese@yandex.ru',
    '(511) 998-3482',
    'Becancour',
    'Quebec',
    'G9H 0R0'
  ),
  (
    36,
    'Joseph',
    'Qureshi',
    '1996-02-01',
    'Joseph_Qureshi@libero.it',
    '(536) 472-3127',
    'Pickering Central',
    'Ontario',
    'L1X 9T8'
  ),
  (
    37,
    'Kevin',
    'Vitriago',
    '2000-04-15',
    'Kevin_Vitriago@yahoo.com',
    '(700) 933-5533',
    'Pembroke Central And Northern Subdivisions',
    'Ontario',
    'K8A 1U6'
  ),
  (
    38,
    'Katrina',
    'Manghan',
    '1997-06-08',
    'Katrina_Manghan@libero.it',
    '07781 143892',
    'Edinburgh',
    NULL,
    'EH1 3PX'
  ),
  (
    39,
    'Phillip',
    'Fahrenkopf',
    '1995-12-15',
    'Phillip_Fahrenkopf@aol.com',
    '07624 748001',
    'Edinburgh',
    NULL,
    'EH9 1TZ'
  ),
  (
    40,
    'Demi',
    'Thomas',
    '1995-11-21',
    'Demi_Thomas@rogers.ca',
    '07843 913897',
    'Cardiff',
    NULL,
    'CF24 3HB'
  ),
  (
    41,
    'Fardin',
    'Chia',
    '1995-07-15',
    'Fardin_Chia@yahoo.com',
    '07422 569231',
    'Swansea',
    NULL,
    'SA1 6JQ'
  ),
  (
    42,
    'Michal',
    'Paxton',
    '1998-03-04',
    'Michal_Paxton@comcast.net',
    '07624 095243',
    'London',
    NULL,
    'SW2 1EW'
  ),
  (
    43,
    'Matthew',
    'Zarba',
    '1999-02-23',
    'Matthew_Zarba@comcast.net',
    '07624 469156',
    'London',
    NULL,
    'HA9 0WS'
  ),
  (
    44,
    'Ieva ',
    'Mathew',
    '1996-07-04',
    'Ieva _Mathew@rogers.ca',
    '07624 257626',
    'London',
    NULL,
    'SE10 0QS'
  ),
  (
    45,
    'Seena Rose',
    'Ringes',
    '1998-01-22',
    'Seena Rose_Ringes@comcast.net',
    '07624 993492',
    'London',
    NULL,
    'IG11 7QF'
  ),
  (
    46,
    'Michal',
    'Kibria',
    '1995-05-15',
    'Michal_Kibria@messages.org',
    '07624 285834',
    'London',
    NULL,
    'WC2E 7BB'
  ),
  (
    47,
    'Vasile',
    'Sawicki',
    '1995-07-15',
    'Vasile_Sawicki@messages.org',
    '07828 017897',
    'Tynemouth',
    NULL,
    'NE30 4BY'
  ),
  (
    48,
    'Maria',
    'Ijaz',
    '1999-01-12',
    'Maria_Ijaz@yandex.ru',
    '07624 580397',
    'Newcastle upon Tyne',
    NULL,
    'NE1 4ST'
  );

INSERT INTO
  circulation (book_id, patron_id, checkout_date, due_date, return_date)
VALUES
  (22, 46, '2013-03-14', '2013-04-04', '2013-03-28'),
  (13, 44, '2013-09-05', '2013-09-26', '2013-09-11'),
  (6, 20, '2018-07-08', '2018-07-29', '2018-07-15'),
  (7, 37, '2016-07-06', '2016-07-27', '2016-07-15'),
  (13, 33, '2013-06-05', '2013-06-26', '2013-06-09'),
  (8, 2, '2011-06-25', '2011-07-16', '2011-07-01'),
  (23, 44, '2018-10-09', '2018-10-30', '2018-11-17'),
  (10, 25, '2011-11-09', '2011-11-30', '2011-11-18'),
  (23, 48, '2010-08-23', '2010-09-13', '2010-09-25'),
  (20, 20, '2011-04-26', '2011-05-17', '2011-04-28'),
  (6, 30, '2013-12-24', '2014-01-14', '2014-01-07'),
  (9, 44, '2021-02-20', '2021-03-13', '2021-03-31'),
  (24, 8, '2017-08-05', '2017-08-26', '2017-08-30'),
  (20, 7, '2011-11-11', '2011-12-02', '2011-11-25'),
  (1, 34, '2010-08-18', '2010-09-08', '2010-08-20'),
  (11, 37, '2010-11-13', '2010-12-04', '2010-11-26'),
  (10, 36, '2021-04-22', '2021-05-13', '2021-04-24'),
  (13, 41, '2018-11-06', '2018-11-27', '2018-11-13'),
  (2, 40, '2013-03-02', '2013-03-23', '2013-03-20'),
  (23, 13, '2014-08-29', '2014-09-19', '2014-09-17'),
  (20, 31, '2016-02-15', '2016-03-07', '2016-02-29'),
  (15, 37, '2019-01-27', '2019-02-17', '2019-02-08'),
  (11, 13, '2017-06-08', '2017-06-29', '2017-06-19'),
  (25, 26, '2019-11-21', '2019-12-12', '2019-11-22'),
  (13, 22, '2011-07-08', '2011-07-29', '2011-07-23'),
  (10, 33, '2021-09-14', '2021-10-05', '2021-09-18'),
  (5, 20, '2013-04-05', '2013-04-26', '2013-04-11'),
  (19, 35, '2011-06-10', '2011-07-01', '2011-07-16'),
  (5, 37, '2011-12-15', '2012-01-05', '2011-12-30'),
  (16, 21, '2010-05-17', '2010-06-07', '2010-05-29'),
  (1, 30, '2011-04-30', '2011-05-21', '2011-05-09'),
  (2, 34, '2016-11-12', '2016-12-03', '2016-11-16'),
  (20, 6, '2013-08-07', '2013-08-28', '2013-08-17'),
  (7, 1, '2018-10-20', '2018-11-10', '2018-10-30'),
  (9, 10, '2012-05-07', '2012-05-28', '2012-05-09'),
  (13, 9, '2017-07-17', '2017-08-07', '2017-07-26'),
  (15, 37, '2019-10-28', '2019-11-18', '2019-11-09'),
  (2, 46, '2020-01-04', '2020-01-25', '2020-01-22'),
  (9, 29, '2012-08-07', '2012-08-28', '2012-08-17'),
  (21, 16, '2012-01-04', '2012-01-25', '2012-01-08'),
  (23, 7, '2018-08-07', '2018-08-28', '2018-08-13'),
  (14, 12, '2017-09-01', '2017-09-22', '2017-09-02'),
  (18, 22, '2018-05-12', '2018-06-02', '2018-06-06'),
  (6, 8, '2011-06-03', '2011-06-24', '2011-06-14'),
  (4, 7, '2013-06-16', '2013-07-07', '2013-06-21'),
  (22, 19, '2013-01-01', '2013-01-22', '2013-01-13'),
  (22, 22, '2020-11-09', '2020-11-30', '2020-12-16'),
  (24, 31, '2011-10-19', '2011-11-09', '2011-11-26'),
  (12, 29, '2018-07-06', '2018-07-27', '2018-07-13'),
  (11, 23, '2017-02-26', '2017-03-19', '2017-03-05'),
  (16, 30, '2015-01-29', '2015-02-19', '2015-02-12'),
  (21, 36, '2013-06-10', '2013-07-01', '2013-07-08'),
  (1, 28, '2013-05-27', '2013-06-17', '2013-06-08'),
  (5, 4, '2010-05-31', '2010-06-21', '2010-06-24'),
  (18, 29, '2014-02-08', '2014-03-01', '2014-03-11'),
  (6, 32, '2021-03-30', '2021-04-20', '2021-05-09'),
  (19, 18, '2012-09-18', '2012-10-09', '2012-10-19'),
  (5, 32, '2012-04-10', '2012-05-01', '2012-04-28'),
  (3, 9, '2020-10-11', '2020-11-01', '2020-10-15'),
  (23, 45, '2020-02-08', '2020-02-29', '2020-02-15'),
  (18, 34, '2019-11-13', '2019-12-04', '2019-11-28'),
  (19, 7, '2015-04-30', '2015-05-21', '2015-05-03'),
  (3, 22, '2017-03-13', '2017-04-03', '2017-03-24'),
  (22, 26, '2010-07-30', '2010-08-20', '2010-09-10'),
  (20, 16, '2015-05-09', '2015-05-30', '2015-05-12'),
  (7, 43, '2015-05-07', '2015-05-28', '2015-05-23'),
  (12, 5, '2016-04-22', '2016-05-13', '2016-05-11'),
  (11, 11, '2010-01-06', '2010-01-27', '2010-01-18'),
  (24, 23, '2010-11-25', '2010-12-16', '2010-12-14'),
  (22, 6, '2012-03-31', '2012-04-21', '2012-04-17'),
  (11, 24, '2014-12-26', '2015-01-16', '2015-01-12'),
  (2, 6, '2021-09-21', '2021-10-12', '2021-10-09'),
  (19, 6, '2019-10-03', '2019-10-24', '2019-10-11'),
  (1, 32, '2018-02-22', '2018-03-15', '2018-02-27'),
  (2, 7, '2012-06-14', '2012-07-05', '2012-06-25'),
  (5, 27, '2011-11-25', '2011-12-16', '2011-12-12'),
  (5, 18, '2017-01-31', '2017-02-21', '2017-02-12'),
  (9, 42, '2019-03-13', '2019-04-03', '2019-04-16'),
  (1, 47, '2010-05-09', '2010-05-30', '2010-05-19'),
  (18, 29, '2013-06-16', '2013-07-07', '2013-06-23'),
  (7, 13, '2010-07-04', '2010-07-25', '2010-07-17'),
  (16, 32, '2011-12-01', '2011-12-22', '2012-01-08'),
  (24, 21, '2018-02-22', '2018-03-15', '2018-03-01'),
  (14, 46, '2015-08-16', '2015-09-06', '2015-08-30'),
  (23, 30, '2011-10-06', '2011-10-27', '2011-10-19'),
  (1, 44, '2021-08-31', '2021-09-21', '2021-09-04'),
  (5, 11, '2013-06-30', '2013-07-21', '2013-07-13'),
  (5, 45, '2012-03-02', '2012-03-23', '2012-03-24'),
  (10, 48, '2017-11-06', '2017-11-27', '2017-11-14'),
  (17, 43, '2017-05-12', '2017-06-02', '2017-05-19'),
  (25, 13, '2017-05-27', '2017-06-17', '2017-05-30'),
  (22, 38, '2012-08-04', '2012-08-25', '2012-08-14'),
  (19, 15, '2021-04-02', '2021-04-23', '2021-04-16'),
  (14, 44, '2019-12-03', '2019-12-24', '2019-12-18'),
  (6, 45, '2013-03-02', '2013-03-23', '2013-03-14'),
  (8, 33, '2011-09-16', '2011-10-07', '2011-09-19'),
  (10, 2, '2017-07-15', '2017-08-05', '2017-08-03'),
  (16, 5, '2011-03-09', '2011-03-30', '2011-03-28'),
  (19, 6, '2019-03-03', '2019-03-24', '2019-03-04'),
  (2, 10, '2021-01-01', '2021-01-22', '2021-01-16'),
  (16, 32, '2013-01-11', '2013-02-01', '2013-02-20'),
  (1, 11, '2018-08-06', '2018-08-27', '2018-08-07'),
  (8, 46, '2021-05-28', '2021-06-18', '2021-06-13'),
  (2, 42, '2018-03-21', '2018-04-11', '2018-03-22'),
  (19, 46, '2014-06-28', '2014-07-19', '2014-07-06'),
  (24, 43, '2013-07-30', '2013-08-20', '2013-08-14'),
  (19, 31, '2021-04-17', '2021-05-08', '2021-04-19'),
  (3, 32, '2011-10-26', '2011-11-16', '2011-11-11'),
  (14, 36, '2012-07-11', '2012-08-01', '2012-07-12'),
  (9, 18, '2019-06-01', '2019-06-22', '2019-06-16'),
  (16, 9, '2010-08-07', '2010-08-28', '2010-08-24'),
  (2, 36, '2010-07-26', '2010-08-16', '2010-08-10'),
  (21, 35, '2021-05-03', '2021-05-24', '2021-05-22'),
  (11, 27, '2011-06-27', '2011-07-18', '2011-07-11'),
  (16, 32, '2016-06-04', '2016-06-25', '2016-07-05'),
  (2, 21, '2015-09-16', '2015-10-07', '2015-09-30'),
  (25, 43, '2018-01-20', '2018-02-10', '2018-01-24'),
  (10, 48, '2021-10-18', '2021-11-08', '2021-10-24'),
  (23, 7, '2014-04-14', '2014-05-05', '2014-04-16'),
  (24, 44, '2011-06-15', '2011-07-06', '2011-06-29'),
  (17, 29, '2013-03-27', '2013-04-17', '2013-04-08'),
  (1, 38, '2018-08-24', '2018-09-14', '2018-09-10'),
  (10, 26, '2015-07-12', '2015-08-02', '2015-07-29'),
  (9, 33, '2021-04-03', '2021-04-24', '2021-05-15'),
  (22, 39, '2021-12-09', '2021-12-30', '2021-12-24'),
  (10, 12, '2015-07-23', '2015-08-13', '2015-08-02'),
  (22, 40, '2012-03-13', '2012-04-03', '2012-03-30'),
  (11, 12, '2013-02-06', '2013-02-27', '2013-03-13'),
  (10, 20, '2017-05-21', '2017-06-11', '2017-06-06'),
  (25, 6, '2010-01-18', '2010-02-08', '2010-02-02'),
  (3, 47, '2013-08-26', '2013-09-16', '2013-09-25'),
  (11, 18, '2020-11-27', '2020-12-18', '2020-12-08'),
  (3, 20, '2018-06-22', '2018-07-13', '2018-06-23'),
  (4, 27, '2020-12-18', '2021-01-08', '2021-01-06'),
  (10, 38, '2017-04-17', '2017-05-08', '2017-05-01'),
  (5, 31, '2020-03-02', '2020-03-23', '2020-03-06'),
  (23, 22, '2010-06-02', '2010-06-23', '2010-06-10'),
  (11, 44, '2018-11-27', '2018-12-18', '2018-12-11'),
  (25, 18, '2018-04-28', '2018-05-19', '2018-05-15'),
  (5, 7, '2012-04-06', '2012-04-27', '2012-04-10'),
  (24, 14, '2013-11-15', '2013-12-06', '2013-12-17'),
  (9, 32, '2011-07-23', '2011-08-13', '2011-08-01'),
  (7, 15, '2020-10-12', '2020-11-02', '2020-11-06'),
  (12, 42, '2016-08-18', '2016-09-08', '2016-09-03'),
  (7, 5, '2016-11-12', '2016-12-03', '2016-12-08'),
  (1, 7, '2013-07-27', '2013-08-17', '2013-08-07'),
  (15, 42, '2015-10-05', '2015-10-26', '2015-11-08'),
  (16, 12, '2015-11-07', '2015-11-28', '2015-12-15'),
  (7, 38, '2021-07-31', '2021-08-21', '2021-08-29'),
  (5, 9, '2014-01-28', '2014-02-18', '2014-02-09'),
  (21, 29, '2018-05-17', '2018-06-07', '2018-05-22'),
  (22, 18, '2021-11-04', '2021-11-25', '2021-11-12'),
  (21, 7, '2010-05-17', '2010-06-07', '2010-05-25'),
  (17, 36, '2016-09-18', '2016-10-09', '2016-09-26'),
  (1, 9, '2017-06-21', '2017-07-12', '2017-06-28'),
  (23, 44, '2011-12-12', '2012-01-02', '2011-12-14'),
  (16, 32, '2018-07-09', '2018-07-30', '2018-07-14'),
  (22, 5, '2012-06-17', '2012-07-08', '2012-07-28'),
  (11, 26, '2011-07-30', '2011-08-20', '2011-08-16'),
  (6, 6, '2010-11-26', '2010-12-17', '2010-12-12'),
  (14, 15, '2018-11-24', '2018-12-15', '2018-11-28'),
  (6, 30, '2013-02-27', '2013-03-20', '2013-03-02'),
  (21, 12, '2021-08-06', '2021-08-27', '2021-09-11'),
  (12, 40, '2012-10-14', '2012-11-04', '2012-10-23'),
  (14, 39, '2014-01-19', '2014-02-09', '2014-01-27'),
  (12, 39, '2013-08-05', '2013-08-26', '2013-08-19'),
  (21, 46, '2014-03-02', '2014-03-23', '2014-03-21'),
  (9, 30, '2014-04-09', '2014-04-30', '2014-04-20'),
  (21, 16, '2012-12-25', '2013-01-15', '2012-12-30'),
  (5, 23, '2021-08-06', '2021-08-27', '2021-08-21'),
  (8, 22, '2017-04-14', '2017-05-05', '2017-05-19'),
  (20, 37, '2012-10-09', '2012-10-30', '2012-10-21'),
  (2, 38, '2019-08-15', '2019-09-05', '2019-08-26'),
  (10, 29, '2019-08-18', '2019-09-08', '2019-08-30'),
  (11, 13, '2012-01-27', '2012-02-17', '2012-02-14'),
  (14, 33, '2013-01-28', '2013-02-18', '2013-02-07'),
  (17, 9, '2019-05-26', '2019-06-16', '2019-06-10'),
  (21, 48, '2016-08-30', '2016-09-20', '2016-09-03'),
  (25, 17, '2011-08-16', '2011-09-06', '2011-08-21'),
  (7, 44, '2011-08-23', '2011-09-13', '2011-09-07'),
  (12, 39, '2021-01-24', '2021-02-14', '2021-01-25'),
  (11, 15, '2019-06-24', '2019-07-15', '2019-06-28'),
  (22, 28, '2012-11-18', '2012-12-09', '2012-11-25'),
  (10, 8, '2014-06-25', '2014-07-16', '2014-06-29'),
  (7, 8, '2018-07-30', '2018-08-20', '2018-08-01'),
  (18, 29, '2014-04-12', '2014-05-03', '2014-05-08'),
  (10, 20, '2011-01-25', '2011-02-15', '2011-02-10'),
  (13, 46, '2013-04-16', '2013-05-07', '2013-04-25'),
  (11, 32, '2017-05-22', '2017-06-12', '2017-06-04'),
  (3, 11, '2016-04-22', '2016-05-13', '2016-05-07'),
  (13, 31, '2018-12-24', '2019-01-14', '2018-12-31'),
  (13, 7, '2014-02-23', '2014-03-16', '2014-03-03'),
  (17, 47, '2019-07-14', '2019-08-04', '2019-07-29'),
  (4, 4, '2015-01-22', '2015-02-12', '2015-02-07'),
  (6, 42, '2019-06-20', '2019-07-11', '2019-07-08'),
  (19, 15, '2010-09-10', '2010-10-01', '2010-09-23'),
  (10, 40, '2013-03-27', '2013-04-17', '2013-04-04'),
  (20, 10, '2019-07-15', '2019-08-05', '2019-08-16'),
  (15, 24, '2010-09-15', '2010-10-06', '2010-09-25'),
  (19, 31, '2012-10-03', '2012-10-24', '2012-10-15'),
  (20, 34, '2022-10-11', '2022-11-01', NULL),
  (11, 36, '2022-10-13', '2022-11-03', NULL),
  (25, 2, '2022-10-22', '2022-11-12', NULL),
  (6, 30, '2022-10-15', '2022-11-05', NULL),
  (24, 29, '2022-10-19', '2022-11-09', NULL),
  (6, 21, '2022-10-23', '2022-11-13', NULL),
  (10, 25, '2022-10-13', '2022-11-03', NULL),
  (3, 17, '2022-10-08', '2022-10-29', NULL),
  (16, 14, '2022-09-25', '2022-11-01', NULL),
  (21, 48, '2022-10-21', '2022-11-11', NULL),
  (16, 2, '2022-10-09', '2022-10-30', NULL),
  (4, 18, '2022-10-10', '2022-11-14', NULL),
  (19, 5, '2022-10-08', '2022-10-29', NULL),
  (3, 10, '2022-10-19', '2022-11-09', NULL),
  (12, 36, '2022-10-12', '2022-11-12', NULL),
  (22, 19, '2022-10-15', '2022-11-05', NULL),
  (15, 26, '2022-10-23', '2022-11-13', NULL),
  (4, 11, '2022-10-16', '2022-11-06', NULL),
  (25, 46, '2022-10-22', '2022-11-12', NULL),
  (23, 26, '2022-10-20', '2022-11-10', NULL),
  (12, 15, '2022-10-12', '2022-11-02', NULL),
  (18, 2, '2022-09-30', '2022-11-11', NULL),
  (19, 1, '2022-10-16', '2022-11-06', NULL),
  (15, 23, '2022-10-20', '2022-11-10', NULL),
  (13, 44, '2022-10-15', '2022-11-05', NULL),
  (24, 17, '2022-10-07', '2022-10-28', NULL),
  (8, 35, '2022-09-13', '2022-11-01', NULL),
  (7, 26, '2022-10-06', '2022-10-27', NULL),
  (15, 29, '2022-10-22', '2022-11-12', NULL),
  (22, 42, '2022-10-15', '2022-11-05', NULL),
  (25, 48, '2022-10-13', '2022-11-03', NULL),
  (21, 31, '2022-10-11', '2022-11-01', NULL),
  (12, 11, '2022-09-21', '2022-10-30', NULL),
  (9, 29, '2022-09-16', '2022-10-29', NULL),
  (16, 22, '2022-10-12', '2022-11-02', NULL),
  (21, 5, '2022-10-23', '2022-11-13', NULL),
  (15, 43, '2022-10-15', '2022-11-05', NULL),
  (13, 43, '2022-09-25', '2022-10-28', NULL),
  (11, 7, '2022-10-25', '2022-11-15', NULL),
  (9, 22, '2022-10-18', '2022-11-08', NULL),
  (15, 27, '2022-10-02', '2022-11-01', NULL),
  (10, 23, '2022-10-19', '2022-11-09', NULL),
  (1, 47, '2022-10-12', '2022-11-02', NULL),
  (9, 19, '2022-10-23', '2022-11-13', NULL),
  (22, 5, '2022-10-17', '2022-11-07', NULL),
  (2, 17, '2022-10-11', '2022-11-01', NULL),
  (14, 22, '2022-10-13', '2022-11-03', NULL),
  (2, 34, '2022-09-30', '2022-10-27', NULL),
  (24, 16, '2022-09-27', '2022-11-14', NULL),
  (16, 16, '2022-09-26', '2022-11-03', NULL)