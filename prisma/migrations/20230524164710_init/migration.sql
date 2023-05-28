-- AlterTable
ALTER TABLE `kanji` MODIFY `symbol` VARCHAR(191) NOT NULL DEFAULT '<empty symbol>';

-- AlterTable
ALTER TABLE `kanjiexample` MODIFY `example` VARCHAR(191) NOT NULL DEFAULT '<empty example>';

-- AlterTable
ALTER TABLE `kanjiform` MODIFY `form` VARCHAR(191) NOT NULL DEFAULT '<empty form>';

-- AlterTable
ALTER TABLE `kanjitranslation` MODIFY `translation` VARCHAR(191) NOT NULL DEFAULT '<empty translation>';

-- AlterTable
ALTER TABLE `note` MODIFY `title` VARCHAR(191) NOT NULL DEFAULT '<empty title>',
    MODIFY `text` VARCHAR(191) NOT NULL DEFAULT '<empty text>',
    MODIFY `link` VARCHAR(191) NOT NULL DEFAULT '<empty link>';

-- AlterTable
ALTER TABLE `subject` MODIFY `title` VARCHAR(191) NOT NULL DEFAULT '<empty title>';

-- AlterTable
ALTER TABLE `topic` MODIFY `title` VARCHAR(191) NOT NULL DEFAULT '<empty title>',
    MODIFY `description` VARCHAR(191) NOT NULL DEFAULT '<empty description>';

-- AlterTable
ALTER TABLE `word` MODIFY `katakana` VARCHAR(191) NOT NULL DEFAULT '<empty katakana>',
    MODIFY `hirogana` VARCHAR(191) NOT NULL DEFAULT '<empty hirogana>',
    MODIFY `romanji` VARCHAR(191) NOT NULL DEFAULT '<empty romanji>';

-- AlterTable
ALTER TABLE `wordtranslation` MODIFY `translation` VARCHAR(191) NOT NULL DEFAULT '<empty translation>';

-- CreateTable
CREATE TABLE `Question` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `question` VARCHAR(191) NOT NULL DEFAULT '<empty question>',
    `active` BOOLEAN NOT NULL DEFAULT true,
    `topicId` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `QOption` (
    `questionId` INTEGER NOT NULL,

    PRIMARY KEY (`questionId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Options` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `text` VARCHAR(191) NOT NULL DEFAULT '<empty option>',
    `correct` BOOLEAN NOT NULL DEFAULT false,
    `questionId` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `QText` (
    `questionId` INTEGER NOT NULL,
    `answer` VARCHAR(191) NOT NULL DEFAULT '<empty answer>',
    `answerType` ENUM('Text', 'Draw', 'Code') NOT NULL DEFAULT 'Text',

    PRIMARY KEY (`questionId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Question` ADD CONSTRAINT `Question_topicId_fkey` FOREIGN KEY (`topicId`) REFERENCES `Topic`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `QOption` ADD CONSTRAINT `QOption_questionId_fkey` FOREIGN KEY (`questionId`) REFERENCES `Question`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Options` ADD CONSTRAINT `Options_questionId_fkey` FOREIGN KEY (`questionId`) REFERENCES `QOption`(`questionId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `QText` ADD CONSTRAINT `QText_questionId_fkey` FOREIGN KEY (`questionId`) REFERENCES `Question`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
