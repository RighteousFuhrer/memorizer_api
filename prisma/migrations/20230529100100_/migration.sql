/*
  Warnings:

  - The values [choice] on the enum `Question_type` will be removed. If these variants are still used in the database, this will fail.

*/
-- AlterTable
ALTER TABLE `question` MODIFY `type` ENUM('select', 'text', 'image') NOT NULL;
