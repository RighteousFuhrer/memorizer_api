/*
  Warnings:

  - The primary key for the `kanji` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `kanji` table. All the data in the column will be lost.
  - You are about to drop the column `topicId` on the `kanji` table. All the data in the column will be lost.
  - You are about to drop the column `kanjiId` on the `kanjiexample` table. All the data in the column will be lost.
  - You are about to drop the column `kanjiId` on the `kanjiform` table. All the data in the column will be lost.
  - You are about to drop the column `kanjiId` on the `kanjitranslation` table. All the data in the column will be lost.
  - You are about to drop the column `link` on the `note` table. All the data in the column will be lost.
  - You are about to drop the column `text` on the `note` table. All the data in the column will be lost.
  - You are about to drop the column `title` on the `note` table. All the data in the column will be lost.
  - The primary key for the `word` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `word` table. All the data in the column will be lost.
  - You are about to drop the column `topicId` on the `word` table. All the data in the column will be lost.
  - You are about to drop the column `wordId` on the `wordtranslation` table. All the data in the column will be lost.
  - Added the required column `noteId` to the `Kanji` table without a default value. This is not possible if the table is not empty.
  - Added the required column `noteId` to the `KanjiExample` table without a default value. This is not possible if the table is not empty.
  - Added the required column `noteId` to the `KanjiForm` table without a default value. This is not possible if the table is not empty.
  - Added the required column `noteId` to the `KanjiTranslation` table without a default value. This is not possible if the table is not empty.
  - Added the required column `noteType` to the `Note` table without a default value. This is not possible if the table is not empty.
  - Added the required column `noteId` to the `Word` table without a default value. This is not possible if the table is not empty.
  - Added the required column `noteId` to the `WordTranslation` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `kanji` DROP FOREIGN KEY `Kanji_topicId_fkey`;

-- DropForeignKey
ALTER TABLE `kanjiexample` DROP FOREIGN KEY `KanjiExample_kanjiId_fkey`;

-- DropForeignKey
ALTER TABLE `kanjiform` DROP FOREIGN KEY `KanjiForm_kanjiId_fkey`;

-- DropForeignKey
ALTER TABLE `kanjitranslation` DROP FOREIGN KEY `KanjiTranslation_kanjiId_fkey`;

-- DropForeignKey
ALTER TABLE `word` DROP FOREIGN KEY `Word_topicId_fkey`;

-- DropForeignKey
ALTER TABLE `wordtranslation` DROP FOREIGN KEY `WordTranslation_wordId_fkey`;

-- AlterTable
ALTER TABLE `kanji` DROP PRIMARY KEY,
    DROP COLUMN `id`,
    DROP COLUMN `topicId`,
    ADD COLUMN `noteId` INTEGER NOT NULL,
    ADD PRIMARY KEY (`noteId`);

-- AlterTable
ALTER TABLE `kanjiexample` DROP COLUMN `kanjiId`,
    ADD COLUMN `noteId` INTEGER NOT NULL;

-- AlterTable
ALTER TABLE `kanjiform` DROP COLUMN `kanjiId`,
    ADD COLUMN `noteId` INTEGER NOT NULL;

-- AlterTable
ALTER TABLE `kanjitranslation` DROP COLUMN `kanjiId`,
    ADD COLUMN `noteId` INTEGER NOT NULL;

-- AlterTable
ALTER TABLE `note` DROP COLUMN `link`,
    DROP COLUMN `text`,
    DROP COLUMN `title`,
    ADD COLUMN `noteType` ENUM('kanji', 'word', 'paragraph') NOT NULL;

-- AlterTable
ALTER TABLE `word` DROP PRIMARY KEY,
    DROP COLUMN `id`,
    DROP COLUMN `topicId`,
    ADD COLUMN `noteId` INTEGER NOT NULL,
    ADD PRIMARY KEY (`noteId`);

-- AlterTable
ALTER TABLE `wordtranslation` DROP COLUMN `wordId`,
    ADD COLUMN `noteId` INTEGER NOT NULL;

-- CreateTable
CREATE TABLE `Paragraph` (
    `noteId` INTEGER NOT NULL,
    `title` VARCHAR(191) NOT NULL DEFAULT '<empty title>',
    `text` VARCHAR(191) NOT NULL DEFAULT '<empty text>',
    `link` VARCHAR(191) NOT NULL DEFAULT '<empty link>',

    PRIMARY KEY (`noteId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Kanji` ADD CONSTRAINT `Kanji_noteId_fkey` FOREIGN KEY (`noteId`) REFERENCES `Note`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `KanjiTranslation` ADD CONSTRAINT `KanjiTranslation_noteId_fkey` FOREIGN KEY (`noteId`) REFERENCES `Kanji`(`noteId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `KanjiForm` ADD CONSTRAINT `KanjiForm_noteId_fkey` FOREIGN KEY (`noteId`) REFERENCES `Kanji`(`noteId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `KanjiExample` ADD CONSTRAINT `KanjiExample_noteId_fkey` FOREIGN KEY (`noteId`) REFERENCES `Kanji`(`noteId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Word` ADD CONSTRAINT `Word_noteId_fkey` FOREIGN KEY (`noteId`) REFERENCES `Note`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `WordTranslation` ADD CONSTRAINT `WordTranslation_noteId_fkey` FOREIGN KEY (`noteId`) REFERENCES `Word`(`noteId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Paragraph` ADD CONSTRAINT `Paragraph_noteId_fkey` FOREIGN KEY (`noteId`) REFERENCES `Note`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
