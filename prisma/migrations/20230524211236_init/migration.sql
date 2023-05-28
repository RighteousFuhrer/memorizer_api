/*
  Warnings:

  - A unique constraint covering the columns `[name]` on the table `ExamPreset` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX `ExamPreset_name_key` ON `ExamPreset`(`name`);
