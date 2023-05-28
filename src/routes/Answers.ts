import { Prisma, PrismaClient } from "@prisma/client";
import express from "express";

const answerRouter = (dbConnection: PrismaClient) => {
  const router = express.Router();

  router.get("/:id", async (req, res) => {
    const params = await req.params;

    try {
      const answers = await dbConnection.answer.findMany({
        where: { id: Number(params.id) },
      });
      res.status(200).send(answers);
    } catch (error) {
      if (error instanceof Prisma.PrismaClientUnknownRequestError) {
        res.status(400).send({ message: error.message });
      } else if (error instanceof Prisma.PrismaClientKnownRequestError) {
        res.status(400).send({ code: error.code, message: error.message });
      }
      res.status(400).send({ message: "Unknown error" });
    }
  });

  router.get("/", async (req, res) => {
    try {
      const answers = await dbConnection.answer.findMany();

      res.status(200).send(answers);
    } catch (error) {
      res.status(400).send({ message: error });
    }
  });

  return router;
};

export default answerRouter;
