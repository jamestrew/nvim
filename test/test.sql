-- CREATE TABLE IF NOT EXISTS hello (
--   id serial PRIMARY KEY,
--   foo VARCHAR(50) NOT NULL,
--   bar INT,
--   created TIMESTAMP without time zone NOT NULL DEFAULT (current_timestamp AT TIME ZONE 'UTC')
-- )
--
-- INSERT INTO hello (foo, bar)
-- VALUES
--   ('hello', 123),
--   ('goodbye', 69420);

SELECT * FROM hello;

-- let g:db = "postgresql://postgres:@localhost/postgres"
