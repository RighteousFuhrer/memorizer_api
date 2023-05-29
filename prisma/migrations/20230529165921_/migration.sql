/*
  Warnings:

  - You are about to drop the `optionselected` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `optionselected` DROP FOREIGN KEY `OptionSelected_answerId_fkey`;

-- DropForeignKey
ALTER TABLE `optionselected` DROP FOREIGN KEY `OptionSelected_optionId_fkey`;

-- DropTable
DROP TABLE `optionselected`;
