/*
  Warnings:

  - You are about to drop the column `value` on the `answer` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `answer` DROP COLUMN `value`;

-- CreateTable
CREATE TABLE `AnswerText` (
    `answerId` INTEGER NOT NULL,
    `text` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`answerId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `AnswerImage` (
    `answerId` INTEGER NOT NULL,
    `image` LONGBLOB NOT NULL,

    PRIMARY KEY (`answerId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `AnswerSelect` (
    `answerId` INTEGER NOT NULL,

    PRIMARY KEY (`answerId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `OptionSelected` (
    `answerId` INTEGER NOT NULL,
    `optionId` INTEGER NOT NULL,

    PRIMARY KEY (`answerId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `AnswerText` ADD CONSTRAINT `AnswerText_answerId_fkey` FOREIGN KEY (`answerId`) REFERENCES `Answer`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `AnswerImage` ADD CONSTRAINT `AnswerImage_answerId_fkey` FOREIGN KEY (`answerId`) REFERENCES `Answer`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `AnswerSelect` ADD CONSTRAINT `AnswerSelect_answerId_fkey` FOREIGN KEY (`answerId`) REFERENCES `Answer`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `OptionSelected` ADD CONSTRAINT `OptionSelected_answerId_fkey` FOREIGN KEY (`answerId`) REFERENCES `AnswerSelect`(`answerId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `OptionSelected` ADD CONSTRAINT `OptionSelected_optionId_fkey` FOREIGN KEY (`optionId`) REFERENCES `Option`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
