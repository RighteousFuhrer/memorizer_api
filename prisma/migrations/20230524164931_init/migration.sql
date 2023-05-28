/*
  Warnings:

  - Added the required column `questionType` to the `Question` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `question` ADD COLUMN `questionType` ENUM('choice', 'text') NOT NULL;
