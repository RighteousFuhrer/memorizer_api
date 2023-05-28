-- CreateTable
CREATE TABLE `Kanji` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `link` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `KanjiTranslation` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `translation` VARCHAR(191) NOT NULL,
    `kanjiId` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `KanjiForm` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `form` VARCHAR(191) NOT NULL,
    `kanjiId` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `KanjiExample` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `example` VARCHAR(191) NOT NULL,
    `kanjiId` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `KanjiTranslation` ADD CONSTRAINT `KanjiTranslation_kanjiId_fkey` FOREIGN KEY (`kanjiId`) REFERENCES `Kanji`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `KanjiForm` ADD CONSTRAINT `KanjiForm_kanjiId_fkey` FOREIGN KEY (`kanjiId`) REFERENCES `Kanji`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `KanjiExample` ADD CONSTRAINT `KanjiExample_kanjiId_fkey` FOREIGN KEY (`kanjiId`) REFERENCES `Kanji`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
