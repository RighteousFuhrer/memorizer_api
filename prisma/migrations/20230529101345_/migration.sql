/*
  Warnings:

  - You are about to drop the column `answerType` on the `questionimage` table. All the data in the column will be lost.
  - You are about to drop the column `answer` on the `questiontext` table. All the data in the column will be lost.
  - Added the required column `text` to the `QuestionText` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `questionimage` DROP COLUMN `answerType`,
    MODIFY `image` LONGBLOB NOT NULL;

-- AlterTable
ALTER TABLE `questiontext` DROP COLUMN `answer`,
    ADD COLUMN `text` VARCHAR(191) NOT NULL;
