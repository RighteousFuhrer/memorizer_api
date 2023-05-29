-- CreateTable
CREATE TABLE `OptionSelected` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `answerId` INTEGER NOT NULL,
    `optionId` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `OptionSelected` ADD CONSTRAINT `OptionSelected_answerId_fkey` FOREIGN KEY (`answerId`) REFERENCES `AnswerSelect`(`answerId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `OptionSelected` ADD CONSTRAINT `OptionSelected_optionId_fkey` FOREIGN KEY (`optionId`) REFERENCES `Option`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
