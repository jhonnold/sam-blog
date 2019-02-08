-- +micrate Up
-- SQL in section 'Up' is executed when this migration is applied
ALTER TABLE "posts" ALTER COLUMN "likes" SET DEFAULT 0;
ALTER TABLE "posts" ALTER COLUMN "category" SET DEFAULT 0;

-- +micrate Down
-- SQL section 'Down' is executed when this migration is rolled back
ALTER TABLE "posts" ALTER COLUMN "likes" SET DEFAULT NULL;
ALTER TABLE "posts" ALTER COLUMN "category" SET DEFAULT NULL;