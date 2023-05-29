/*
  Warnings:

  - You are about to drop the column `examResulId` on the `answer` table. All the data in the column will be lost.
  - Added the required column `examResultId` to the `Answer` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `answer` DROP FOREIGN KEY `Answer_examResulId_fkey`;

-- AlterTable
ALTER TABLE `answer` DROP COLUMN `examResulId`,
    ADD COLUMN `examResultId` INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE `Answer` ADD CONSTRAINT `Answer_examResultId_fkey` FOREIGN KEY (`examResultId`) REFERENCES `ExamResult`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
