-- CreateTable
CREATE TABLE `ExamPreset` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `examResulId` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Answer` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `correct` BOOLEAN NOT NULL DEFAULT false,
    `questionId` INTEGER NOT NULL,
    `examResulId` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ExamResult` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `mark` DOUBLE NOT NULL,
    `examPresetId` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `_ExamPresetToTopic` (
    `A` INTEGER NOT NULL,
    `B` INTEGER NOT NULL,

    UNIQUE INDEX `_ExamPresetToTopic_AB_unique`(`A`, `B`),
    INDEX `_ExamPresetToTopic_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Answer` ADD CONSTRAINT `Answer_questionId_fkey` FOREIGN KEY (`questionId`) REFERENCES `Question`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Answer` ADD CONSTRAINT `Answer_examResulId_fkey` FOREIGN KEY (`examResulId`) REFERENCES `ExamResult`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ExamResult` ADD CONSTRAINT `ExamResult_examPresetId_fkey` FOREIGN KEY (`examPresetId`) REFERENCES `ExamPreset`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_ExamPresetToTopic` ADD CONSTRAINT `_ExamPresetToTopic_A_fkey` FOREIGN KEY (`A`) REFERENCES `ExamPreset`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_ExamPresetToTopic` ADD CONSTRAINT `_ExamPresetToTopic_B_fkey` FOREIGN KEY (`B`) REFERENCES `Topic`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
