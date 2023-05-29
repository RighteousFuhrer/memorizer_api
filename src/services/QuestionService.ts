import { PrismaClient } from "@prisma/client";
import { Option } from "../models/Question";

export class QuestionService {
  prismaClient: PrismaClient;
  constructor(prismaClient: PrismaClient) {
    this.prismaClient = prismaClient;
  }

  async getAllByTopic(topicId: number) {
    try {
      const questions = await this.prismaClient.question.findMany({
        where: { topicId },
      });

      return questions;
    } catch (error) {
      throw new Error(error as any);
    }
  }
  async getAllByPreset(presetId: number) {
    try {
      const res = await this.prismaClient.examPreset.findFirst({
        where: { id: presetId },
        select: {
          topics: true,
        },
      });

      const questions = await this.prismaClient.question.findMany({
        where: {
          topicId: {
            in: res?.topics.map((t) => t.id),
          },
        },
      });

      return questions;
    } catch (error) {
      throw new Error(error as any);
    }
  }
  async createSelect(question: string, topicId: number, options: Option[]) {
    try {
      const questions = await this.prismaClient.question.create({
        data: {
          question,
          topicId,
          type: "select",
          questionOption: {
            create: {
              options: {
                createMany: {
                  data: options.map((option) => {
                    return {
                      correct: option.correct,
                      text: option.text,
                    };
                  }),
                },
              },
            },
          },
        },
      });
      return questions;
    } catch (error) {
      throw new Error(error as any);
    }
  }

  async createImage(questionText: string, topicId: number, imageBlob: string) {
    try {
      const question = await this.prismaClient.question.create({
        data: {
          question: questionText,
          topicId,
          type: "image",
          questionImage: {
            create: {
              image: Buffer.from(imageBlob),
            },
          },
        },
      });
      return question;
    } catch (error) {
      throw new Error(error as any);
    }
  }
  async createText(question: string, topicId: number, text: string) {
    try {
      const res = await this.prismaClient.question.create({
        data: {
          question,
          topicId,
          type: "text",
          questionText: {
            create: {
              text,
            },
          },
        },
      });
      return res;
    } catch (error) {
      throw new Error(error as any);
    }
  }

  async updateSelect(id: number, options: Option[]) {
    try {
      const res = await this.prismaClient.question.update({
        where: { id },
        data: {
          questionOption: {
            delete : true,
            create: {
              options: {
                createMany: {
                  data: options.map((option) => {
                    return {
                      correct: option.correct,
                      text: option.text,
                    };
                  }),
                },
              },
            },
          },
        },
      });
      return res;
    } catch (error: any) {
      throw error;
    }
  }

  async updateImage(id: number, imageBlob: string) {
    try {
      const res = await this.prismaClient.question.update({
        where: { id },
        data: {
          questionImage: {
            update: {
              image: Buffer.from(imageBlob),
            },
          },
        },
      });
      return res;
    } catch (error: any) {
      throw error;
    }
  }

  async updateText(id: number, text: string) {
    try {
      const res = await this.prismaClient.question.update({
        where: { id },
        data: {
          questionText: {
            update: {
              text,
            },
          },
        },
      });
      return res;
    } catch (error: any) {
      throw error;
    }
  }

  async delete(id: number) {
    try {
      const res = await this.prismaClient.question.delete({
        where: { id },
      });
      return res;
    } catch (error: any) {
      throw error;
    }
  }
}
