-- DropForeignKey
ALTER TABLE `kanjiexample` DROP FOREIGN KEY `KanjiExample_kanjiId_fkey`;

-- DropForeignKey
ALTER TABLE `kanjiform` DROP FOREIGN KEY `KanjiForm_kanjiId_fkey`;

-- DropForeignKey
ALTER TABLE `kanjitranslation` DROP FOREIGN KEY `KanjiTranslation_kanjiId_fkey`;

-- CreateTable
CREATE TABLE `Word` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `katakana` VARCHAR(191) NOT NULL,
    `hirogana` VARCHAR(191) NOT NULL,
    `romanji` VARCHAR(191) NOT NULL,
    `kanji` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `WordTranslation` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `translation` VARCHAR(191) NOT NULL,
    `wordId` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `KanjiTranslation` ADD CONSTRAINT `KanjiTranslation_kanjiId_fkey` FOREIGN KEY (`kanjiId`) REFERENCES `Kanji`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `KanjiForm` ADD CONSTRAINT `KanjiForm_kanjiId_fkey` FOREIGN KEY (`kanjiId`) REFERENCES `Kanji`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `KanjiExample` ADD CONSTRAINT `KanjiExample_kanjiId_fkey` FOREIGN KEY (`kanjiId`) REFERENCES `Kanji`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `WordTranslation` ADD CONSTRAINT `WordTranslation_wordId_fkey` FOREIGN KEY (`wordId`) REFERENCES `Word`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
