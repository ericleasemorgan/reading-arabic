-- cookbook

-- configure
.mode tabs

-- glossary items
select 'most frequent glossary items in entries about egypt; (requires additional parsing)';
select count(gloss) as c, token, gloss from tokens where ( did > 530 and did < 594 )  group by gloss order by c desc limit 100;
select '';

-- proper nouns
select 'most frequent proper nouns in entries about egypt';
select count(lemma) as c, lemma, gloss from tokens where (pos is 'noun_prop' and did > 530 and did < 594 )  group by token order by c desc limit 100;
select '';
