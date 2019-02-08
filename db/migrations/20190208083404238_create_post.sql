-- +micrate Up
CREATE TABLE posts (
  id BIGSERIAL PRIMARY KEY,
  title VARCHAR,
  preview VARCHAR,
  body VARCHAR,
  likes INT,
  category INT,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);


-- +micrate Down
DROP TABLE IF EXISTS posts;
