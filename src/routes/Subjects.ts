import { PrismaClient } from "@prisma/client";
import express from "express";

const subjectRouter = (dbConnection: PrismaClient) => {
  const router = express.Router();

  router.get("/", async (req, res) => {
    const subjects = await dbConnection.subject.findMany();
    res.send(subjects);
  });
  
  router.post("/", async (req, res) => {
    try {
      const subjects = await dbConnection.subject.create({
        data: {
          title: await req.body.title,
        },
      });
      res.status(200).send(subjects);
    } catch (err) {
      res.status(400).send({ message: err });
    }
  });

  return router;
};

export default subjectRouter;
