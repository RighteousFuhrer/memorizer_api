import { PrismaClient, Question } from "@prisma/client";
import express from "express";
import { QuestionService } from "../services/QuestionService";

const questionRouter = (dbConnection: PrismaClient) => {
  const router = express.Router();
  const questionService = new QuestionService(dbConnection);

  router.post("/", async (req, res) => {
    const data = req.body;
    try {
      let questions: Question;
      if (data.options) {
        questions = await questionService.createSelect(
          data.question,
          data.topicId,
          data.options
        );
      } else if (data.image) {
        questions = await questionService.createImage(
          data.question,
          data.topicId,
          data.image,
        );
      } else {
        questions = await questionService.createText(
          data.question,
          data.topicId,
          data.text
        );
      }

      res.status(200).send(questions);
    } catch (err) {
      res.status(400).send({ message: err });
    }
  });

  return router;
};

export default questionRouter;
