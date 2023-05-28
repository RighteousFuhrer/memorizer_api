import { Prisma, PrismaClient } from "@prisma/client";
import express from "express";

const topicRouter = (dbConnection: PrismaClient) => {
  const router = express.Router();

  router.get("/:id", async (req, res) => {
    const params = await req.params;
    try {
      const topics = await dbConnection.topic.findMany({
        where: {
          id: Number(params.id),
        },
      });
      res.status(200).send(topics);
    } catch (err) {
      res.status(400).send({ message: err });
    }
  });

  router.get("/", async (req, res) => {
    const params = await req.query;
    try {
      const topics = await dbConnection.topic.findMany({
        where: {
          subject: {
            title: {
              in: <string[]>params.subjects,
            },
          },
        },
        orderBy: {
          [(<string>params.orderBy ?? "id").toString()]: params.order || "asc",
        },
      });
      res.status(200).send(topics);
    } catch (err) {
      res.status(400).send({ message: err });
    }
  });

  router.post("/", async (req, res) => {
    const body = await req.body;
    console.log(body);
    try {
      const topic = await dbConnection.topic.create({
        data: {
          subject: {
            connect: {
              id: body.subjectId,
            },
          },
          title: body.title,
          description: body.description,
        },
      });
      res.status(200).send(topic);
    } catch (err) {
      res.status(400).send({ message: err });
    }
  });

  return router;
};

export default topicRouter;
