/*
  Warnings:

  - You are about to alter the column `correct` on the `answer` table. The data in that column could be lost. The data in that column will be cast from `TinyInt` to `Enum(EnumId(3))`.

*/
-- AlterTable
ALTER TABLE `answer` MODIFY `correct` ENUM('correct', 'false', 'partially') NOT NULL DEFAULT 'false';

-- AlterTable
ALTER TABLE `examresult` ADD COLUMN `date` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    MODIFY `mark` DOUBLE NOT NULL DEFAULT 0.0;
