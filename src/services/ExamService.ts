import { PrismaClient, Answer, Correctness } from "@prisma/client";
import { AnswerDto } from "../models/Answer";
import { faker } from "@faker-js/faker";
import { resultFilter } from "../interfaces/SerachFilters";
import { AnswerService } from "./AnswerService";

export class ExamService {
  prismaClient: PrismaClient;
  answerService: AnswerService;

  constructor(prismaClient: PrismaClient, aService: AnswerService) {
    this.prismaClient = prismaClient;
    this.answerService = aService;
  }

  async generateResult(
    answers: AnswerDto[],
    mode: number,
    examPresetId: number
  ) {
    try {
      const resultId = faker.number.int({ min: 100000, max: 999999 });

      await this.prismaClient.examResult.create({
        data: {
          id: resultId,
          examPresetId,
        },
      });

      const newAnswers = await this.answerService.createMany(answers, resultId);

      return newAnswers;
    } catch (error) {
      throw new Error(error as any);
    }
  }

  async getAll() {
    try {
      const results = await this.prismaClient.examResult.findMany();

      return results;
    } catch (error) {
      throw error;
    }
  }

  async getAllFiltered(filter: resultFilter) {
    try {
      const results = await this.prismaClient.examResult.findMany({
        where: {
          examPresetId: {
            in: filter.presets.map((f) => f.id),
          },
        },
        orderBy: {
          [filter.sort]: filter.order,
        },
      });

      return results;
    } catch (error) {
      throw error;
    }
  }

  async getById(id: number) {
    try {
      const result = await this.prismaClient.examResult.findFirst({
        where: { id },
      });

      return result;
    } catch (error) {
      throw error;
    }
  }

  async delete(id: number) {
    try {
      const result = await this.prismaClient.examResult.delete({
        where: { id },
      });

      return result;
    } catch (error) {
      throw error;
    }
  }
}
