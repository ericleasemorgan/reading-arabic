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

CREATE TABLE titles2entries (
	tid INT,
	bid INT,
	eid INT
);

CREATE TABLE tokens (
	did    INT,
	tid    INT,
	token  TEXT,
	lemma  TEXT,
	pos    TEXT,
	gloss  TEXT
);