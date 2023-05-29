import { Correctness, PrismaClient } from "@prisma/client";
import { AnswerDto } from "../models/Answer";

export class AnswerService {
  prismaClient: PrismaClient;
  constructor(prismaClient: PrismaClient) {
    this.prismaClient = prismaClient;
  }
  async createText(
    questionId: number,
    correct: Correctness,
    text: string,
    resultId: number
  ) {
    try {
      await this.prismaClient.answer.create({
        data: {
          correct,
          examResultId: resultId,
          questionId,
          text: {
            create: {
              text,
            },
          },
        },
      });
    } catch (error) {
      throw new Error(error as any);
    }
  }

  async createSelect(
    questionId: number,
    correct: Correctness,
    selected: { id: number }[],
    resultId: number
  ) {
    try {
      await this.prismaClient.answer.create({
        data: {
          correct,
          examResultId: resultId,
          questionId,
          selected: {
            create: {
              options: {
                createMany: {
                  data: selected.map((s) => {
                    return { optionId: s.id };
                  }),
                },
              },
            },
          },
        },
      });
    } catch (error) {
      throw new Error(error as any);
    }
  }
  async createImage(
    questionId: number,
    correct: Correctness,
    image: string,
    resultId: number
  ) {
    try {
      await this.prismaClient.answer.create({
        data: {
          correct,
          examResultId: resultId,
          questionId,
          image: {
            create: {
              image: Buffer.from(image),
            },
          },
        },
      });
    } catch (error) {
      throw new Error(error as any);
    }
  }

  async createMany(answers: AnswerDto[], resultId: number) {
    try {
      answers.forEach(async (answer) => {
        if (answer.image) {
          await this.createImage(
            answer.questionId,
            answer.correct,
            answer.image,
            resultId
          );
        } else if (answer.text) {
          await this.createText(
            answer.questionId,
            answer.correct,
            answer.text,
            resultId
          );
        } else if (answer.selected) {
          await this.createSelect(
            answer.questionId,
            answer.correct,
            answer.selected,
            resultId
          );
        }
      });
      const answersCreated = await this.prismaClient.answer.findMany({
        where: {
          examResultId: resultId,
        },
      });
      return answersCreated;
    } catch (error) {
      throw new Error(error as any);
    }
  }
}
