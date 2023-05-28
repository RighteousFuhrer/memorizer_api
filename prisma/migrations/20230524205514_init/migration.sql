/*
  Warnings:

  - You are about to drop the column `examResulId` on the `exampreset` table. All the data in the column will be lost.
  - Added the required column `name` to the `ExamPreset` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `exampreset` DROP COLUMN `examResulId`,
    ADD COLUMN `name` VARCHAR(191) NOT NULL;
