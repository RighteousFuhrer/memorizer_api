-- DropForeignKey
ALTER TABLE `answer` DROP FOREIGN KEY `Answer_examResultId_fkey`;

-- AddForeignKey
ALTER TABLE `Answer` ADD CONSTRAINT `Answer_examResultId_fkey` FOREIGN KEY (`examResultId`) REFERENCES `ExamResult`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
