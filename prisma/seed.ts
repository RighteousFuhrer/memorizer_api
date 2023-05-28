import { ExamPreset, Prisma, PrismaClient } from "@prisma/client";

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

  const topics = await prisma.topic.createMany({
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
                id: faker.number.int({ min: 1, max: topics.count - 1 }),
              };
            }),
          },
        },
      })
    );
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
