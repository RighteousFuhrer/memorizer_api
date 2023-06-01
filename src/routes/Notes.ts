import { PrismaClient } from "@prisma/client";
import express from "express";
import { NoteService } from "../services/NoteService";
import { NoteDto } from "../models/Note";

const noteRouter = (dbConnection: PrismaClient) => {
  const router = express.Router();
  const noteService = new NoteService(dbConnection);

  router.post("/", async (req, res) => {
    const noteDto: NoteDto = req.body;
    try {
      const note = await noteService.create(noteDto);

      res.status(200).send(note);
    } catch (err) {
      res.status(400).send({ message: err });
    }
  });

  router.get("/:id", async (req, res) => {
    const { id } = req.params;
    console.log(id);
    try {
      const note = await noteService.getAllByTopicId(Number(id));

      res.status(200).send(note);
    } catch (err) {
      res.status(400).send({ message: err });
    }
  });

  router.put("/:id", async (req, res) => {
    const { id, noteDto } = req.body;
    try {
      const note = await noteService.update(id, noteDto);

      res.status(200).send(note);
    } catch (err) {
      res.status(400).send({ message: err });
    }
  });

  return router;
};

export default noteRouter;
