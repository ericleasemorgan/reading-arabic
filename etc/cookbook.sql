-- cookbook.sql - a set of SQL commands to provide an overview of a database's content

-- usage: cat ./etc/cookbook.sql | sqlite3 ./etc/tokens.db | less

-- Eric Lease Morgan <emorgan@nd.edu>
-- (c) University of Notre Dame; distributed under a GNU Public License

-- January 20, 2021 - first full cut; Joe Biden's presidential inauguration day


-- configure
.mode tabs

select 'database structure';
.schema
select '';

select 'number of records (words/tokens)';
select count( did ) from tokens;
select '';

select 'count & tabulation of types of tokens';
select count( pos ) as c, pos from tokens group by pos order by c desc;
select '';

select 'top ten most frequently used nouns, their lemmas, and translation (glossary value)';
select count( token) as c, token, lemma, gloss from tokens where pos is 'noun' group by token order by c desc limit 10;
select '';

select 'top ten most frequent glossary items in entries about egypt';
select count(gloss) as c, token, gloss from tokens where did like "egypt%" group by gloss order by c desc limit 10;
select '';

select 'top ten most frequent proper nouns in entries about egypt; use something like this to identify places';
select count(lemma) as c, lemma, gloss from tokens where did like "egypt%" and pos is "noun_prop" group by token order by c desc limit 10;
select '';
