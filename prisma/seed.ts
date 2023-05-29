import { ExamPreset, Prisma, PrismaClient, Topic } from "@prisma/client";

import prisma from "../src/lib/dbConnection";
import { faker } from "@faker-js/faker";

async function main() {
  const subjects = await prisma.subject.createMany({
    data: [
      {
        id: 1,
        title: "Japanese",
      },
      {
        id: 2,
        title: "Backend",
      },
      {
        id: 3,
        title: "Frontend",
      },
    ],
  });

  const topics_res = await prisma.topic.createMany({
    data: [...new Array(faker.number.int({ min: 5, max: 14 }))].map((e) => {
      return {
        description: faker.string.alpha({ length: 16 }),
        subjectId: faker.number.int({ min: 1, max: 3 }),
        title: faker.word.noun(),
      };
    }),
  });
  let presets: ExamPreset[] = [];
  [...new Array(faker.number.int({ min: 5, max: 10 }))].forEach(async (e) => {
    presets.push(
      await prisma.examPreset.create({
        data: {
          name: faker.string.alpha({ length: 10 }),
          topics: {
            connect: [...new Array(10)].map((e) => {
              return {
                id: faker.number.int({ min: 1, max: topics_res.count - 1 }),
              };
            }),
          },
        },
      })
    );
  });
  const topics = await prisma.topic.findMany();

  topics.forEach(async (topic) => {
    [...new Array(faker.number.int({ min: 6, max: 20 }))].forEach(async (e) => {
      const type = faker.number.int({ max: 3, min: 1 });
      switch (type) {
        case 1:
          await prisma.question.create({
            data: {
              question: faker.string.alpha({ length: { min: 10, max: 25 } }),
              type: "select",
              topicId: topic.id,
              questionOption: {
                create: {
                  options: {
                    createMany: {
                      data: [
                        ...new Array(faker.number.int({ min: 2, max: 5 })),
                      ].map((e2) => {
                        return {
                          text: faker.lorem.paragraph(1),
                          correct: faker.number.int({ max: 1 }) ? true : false,
                        };
                      }),
                    },
                  },
                },
              },
            },
          });
          break;
        case 2:
          await prisma.question.create({
            data: {
              question: faker.string.alpha({ length: { min: 10, max: 25 } }),
              type: "image",
              topicId: topic.id,
              questionImage: {
                create: {
                  image: Buffer.from(
                    faker.image.url({ width: 400, height: 400 })
                  ),
                },
              },
            },
          });
          break;
        case 3:
          await prisma.question.create({
            data: {
              question: faker.string.alpha({ length: { min: 10, max: 25 } }),
              type: "text",
              topicId: topic.id,
              questionText: {
                create: {
                  text: faker.lorem.paragraph(1),
                },
              },
            },
          });
          break;
        default:
          break;
      }
    });
  });

  
}

main()
  .then(async () => {
    await prisma.$disconnect();
  })
  .catch(async (e) => {
    console.error(e);
    await prisma.$disconnect();
    process.exit(1);
  });
