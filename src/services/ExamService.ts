import { PrismaClient, Answer, Correctness } from "@prisma/client";
import { AnswerDto } from "../models/Answer";
import { faker } from "@faker-js/faker";
import { resultFilter } from "../interfaces/SerachFilters";

export class ExamService {
  userDatabase: PrismaClient;

  constructor(userDatabase: PrismaClient) {
    this.userDatabase = userDatabase;
  }

  async generateResult(
    answers: AnswerDto[],
    mode: number,
    examPresetId: number
  ) {
    try {
      const resultId = faker.number.int({ min: 100000, max: 999999 });

      const newAnswers = answers.map((answer) => {
        return {
          correct: answer.correct,
          questionId: answer.questionId,
          examResulId: resultId,
          value: answer.value,
        };
      });

      await this.userDatabase.examResult.create({
        data: {
          id: resultId,
          examPresetId,
          mark:
            newAnswers.reduce((acc, answer) => {
              if (answer.correct === Correctness.correct) {
                return acc + 1;
              } else if (answer.correct === Correctness.partially) {
                return acc + 0.5;
              }
              return acc;
            }, 0) / newAnswers.length,
          answers: {
            createMany: {
              data: newAnswers,
            },
          },
        },
      });

      return resultId;
    } catch (error) {
      throw error;
    }
  }

  async getAll() {
    try {
      const results = await this.userDatabase.examResult.findMany();

      return results;
    } catch (error) {
      throw error;
    }
  }

  async getAllFiltered(filter: resultFilter) {
    try {
      const results = await this.userDatabase.examResult.findMany({
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
      const result = await this.userDatabase.examResult.findFirst({
        where: { id },
      });

      return result;
    } catch (error) {
      throw error;
    }
  }

  async delete(id: number) {
    try {
      const result = await this.userDatabase.examResult.delete({
        where: { id },
      });

      return result;
    } catch (error) {
      throw error;
    }
  }
}
