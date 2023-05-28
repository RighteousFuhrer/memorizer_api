import { PrismaClient } from "@prisma/client";
import express from "express";

const examPresetRouter = (dbConnection: PrismaClient) => {
  const router = express.Router();

  router.get("/", async (req, res) => {
    const presets = await dbConnection.examPreset.findMany();
    res.send(presets);
  });

  router.post("/", async (req, res) => {
    const body = await req.body;

    try {
      const preset = await dbConnection.examPreset.create({
        data: {
          name: body.name,
          topics: {
            connect: body.topics.map((topic: any) => {
              return { id: topic };
            }),
          },
        },
      });
      res.status(200).send(preset);
    } catch (err) {
      res.status(400).send({ message: err });
    }
  });

  return router;
};

export default examPresetRouter;
