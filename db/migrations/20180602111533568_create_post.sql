-- +micrate Up
CREATE TABLE posts (
  id BIGSERIAL PRIMARY KEY,
  title VARCHAR,
  body TEXT,
  preview TEXT,
  likes INT,
  category INT,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);


-- +micrate Down
DROP TABLE IF EXISTS posts;
