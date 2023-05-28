/*
  Warnings:

  - You are about to drop the column `noteType` on the `note` table. All the data in the column will be lost.
  - You are about to drop the column `questionType` on the `question` table. All the data in the column will be lost.
  - Added the required column `type` to the `Note` table without a default value. This is not possible if the table is not empty.
  - Added the required column `type` to the `Question` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `note` DROP COLUMN `noteType`,
    ADD COLUMN `type` ENUM('kanji', 'word', 'paragraph') NOT NULL;

-- AlterTable
ALTER TABLE `question` DROP COLUMN `questionType`,
    ADD COLUMN `type` ENUM('choice', 'text') NOT NULL;
