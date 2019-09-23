CREATE TABLE books (
	bid    INTEGER PRIMARY KEY,
	root   TEXT,
	title  TEXT
);

CREATE TABLE titles (
	tid    INT,
	bid    INT,
	title  TEXT
);

CREATE TABLE entries (
	eid    INT,
	bid    INT,
	entry  TEXT
);