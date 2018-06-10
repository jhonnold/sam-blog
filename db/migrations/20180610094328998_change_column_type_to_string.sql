-- +micrate Up
-- SQL in section 'Up' is executed when this migration is applied
ALTER TABLE "posts" ALTER COLUMN "category" TYPE TEXT;

-- +micrate Down
-- SQL section 'Down' is executed when this migration is rolled back
ALTER TABLE "posts" ALTER COLUMN "category" TYPE INT;
