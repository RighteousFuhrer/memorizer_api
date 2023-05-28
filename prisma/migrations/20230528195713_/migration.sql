/*
  Warnings:

  - You are about to drop the `qoption` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `qtext` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `options` DROP FOREIGN KEY `Options_questionId_fkey`;

-- DropForeignKey
ALTER TABLE `qoption` DROP FOREIGN KEY `QOption_questionId_fkey`;

-- DropForeignKey
ALTER TABLE `qtext` DROP FOREIGN KEY `QText_questionId_fkey`;

-- AlterTable
ALTER TABLE `kanji` ALTER COLUMN `symbol` DROP DEFAULT;

-- AlterTable
ALTER TABLE `kanjiexample` ALTER COLUMN `example` DROP DEFAULT;

-- AlterTable
ALTER TABLE `kanjiform` ALTER COLUMN `form` DROP DEFAULT;

-- AlterTable
ALTER TABLE `kanjitranslation` ALTER COLUMN `translation` DROP DEFAULT;

-- AlterTable
ALTER TABLE `options` ALTER COLUMN `text` DROP DEFAULT;

-- AlterTable
ALTER TABLE `paragraph` ALTER COLUMN `title` DROP DEFAULT,
    ALTER COLUMN `text` DROP DEFAULT,
    ALTER COLUMN `link` DROP DEFAULT;

-- AlterTable
ALTER TABLE `question` ALTER COLUMN `question` DROP DEFAULT;

-- AlterTable
ALTER TABLE `subject` ALTER COLUMN `title` DROP DEFAULT;

-- AlterTable
ALTER TABLE `topic` ALTER COLUMN `title` DROP DEFAULT;

-- AlterTable
ALTER TABLE `word` ALTER COLUMN `katakana` DROP DEFAULT,
    ALTER COLUMN `hirogana` DROP DEFAULT,
    ALTER COLUMN `romanji` DROP DEFAULT;

-- AlterTable
ALTER TABLE `wordtranslation` ALTER COLUMN `translation` DROP DEFAULT;

-- DropTable
DROP TABLE `qoption`;

-- DropTable
DROP TABLE `qtext`;

-- CreateTable
CREATE TABLE `QuestionOption` (
    `questionId` INTEGER NOT NULL,

    PRIMARY KEY (`questionId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `QuestionText` (
    `questionId` INTEGER NOT NULL,
    `answer` VARCHAR(191) NOT NULL,
    `answerType` ENUM('Text', 'Draw', 'Code') NOT NULL DEFAULT 'Text',

    PRIMARY KEY (`questionId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `QuestionOption` ADD CONSTRAINT `QuestionOption_questionId_fkey` FOREIGN KEY (`questionId`) REFERENCES `Question`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Options` ADD CONSTRAINT `Options_questionId_fkey` FOREIGN KEY (`questionId`) REFERENCES `QuestionOption`(`questionId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `QuestionText` ADD CONSTRAINT `QuestionText_questionId_fkey` FOREIGN KEY (`questionId`) REFERENCES `Question`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
