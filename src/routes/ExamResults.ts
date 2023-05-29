import { ExamResult, PrismaClient } from "@prisma/client";
import express from "express";
import { ExamService } from "../services/ExamService";
import { resultFilter } from "../interfaces/SerachFilters";
import { AnswerDto } from "../models/Answer";
import { AnswerService } from "../services/AnswerService";

const examResultRouter = (dbConnection: PrismaClient) => {
  const router = express.Router();
  const answerService = new AnswerService(dbConnection);
  const examService = new ExamService(dbConnection, answerService);

  router.post("/", async (req, res) => {
    const { answers, presetId } = req.body;
    try {
      const results = await examService.generateResult(answers, 0, presetId);

      res.status(200).send(results);
    } catch (error) {
      res.status(400).send({ message: error });
    }
  });

  router.get("/", async (req, res) => {
    const params = req.query;
    //result filter
    console.log(params);
    const filter: resultFilter = {
      order: "asc",
      sort: "date",
      presets: [],
    };

    try {
      const results = await examService.getAllFiltered(filter);

      res.status(200).send(results);
    } catch (error) {
      res.status(400).send({ message: error });
    }
  });

  router.get("/:id", async (req, res) => {
    const params = req.params;

    try {
      const result = await examService.getById(Number(params.id));

      res.status(200).send(result);
    } catch (error) {
      res.status(400).send({ message: error });
    }
  });

  router.delete("/:id", async (req, res) => {
    const params = req.params;

    try {
      const result = await examService.delete(Number(params.id));

      res.status(200).send(result);
    } catch (error) {
      res.status(400).send({ message: error });
    }
  });

  return router;
};

export default examResultRouter;
