/*
  Warnings:

  - The values [Draw] on the enum `QuestionImage_answerType` will be removed. If these variants are still used in the database, this will fail.
  - You are about to drop the `options` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `questionoption` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `options` DROP FOREIGN KEY `Options_questionId_fkey`;

-- DropForeignKey
ALTER TABLE `questionoption` DROP FOREIGN KEY `QuestionOption_questionId_fkey`;

-- AlterTable
ALTER TABLE `question` MODIFY `type` ENUM('choice', 'text', 'image') NOT NULL;

-- AlterTable
ALTER TABLE `questiontext` MODIFY `answerType` ENUM('Text', 'Code') NOT NULL DEFAULT 'Text';

-- DropTable
DROP TABLE `options`;

-- DropTable
DROP TABLE `questionoption`;

-- CreateTable
CREATE TABLE `QuestionSelect` (
    `questionId` INTEGER NOT NULL,

    PRIMARY KEY (`questionId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Option` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `text` VARCHAR(191) NOT NULL,
    `correct` BOOLEAN NOT NULL DEFAULT false,
    `questionId` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `QuestionImage` (
    `questionId` INTEGER NOT NULL,
    `image` VARCHAR(191) NOT NULL,
    `answerType` ENUM('Text', 'Code') NOT NULL DEFAULT 'Text',

    PRIMARY KEY (`questionId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `QuestionSelect` ADD CONSTRAINT `QuestionSelect_questionId_fkey` FOREIGN KEY (`questionId`) REFERENCES `Question`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Option` ADD CONSTRAINT `Option_questionId_fkey` FOREIGN KEY (`questionId`) REFERENCES `QuestionSelect`(`questionId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `QuestionImage` ADD CONSTRAINT `QuestionImage_questionId_fkey` FOREIGN KEY (`questionId`) REFERENCES `Question`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
