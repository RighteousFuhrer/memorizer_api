import { Request, Response, Express } from "express";
import { initTRPC } from "@trpc/server";
import bodyParser from "body-parser";
const app: Express = require("express")();
const cors = require("cors");
const t = initTRPC.create();
const detenv = require("dotenv").config();

import prisma from "./lib/dbConnection";
import topicRouter from "./routes/Topics";
import noteRouter from "./routes/Notes";
import questionRouter from "./routes/Question";
import subjectRouter from "./routes/Subjects";
import examResultRouter from "./routes/ExamResults";
import examPresetRouter from "./routes/ExamPresets";
import answerRouter from "./routes/Answers";

app.use(bodyParser.json());
app.use(cors());

app.use("/topics", topicRouter(prisma));
app.use("/notes", noteRouter(prisma));
app.use("/questions", questionRouter(prisma));
app.use("/subjects", subjectRouter(prisma));
app.use("/results", examResultRouter(prisma));
app.use("/presets", examPresetRouter(prisma));
app.use("/answers", answerRouter(prisma));

const port = process.env.PORT || 8080;

app.listen(port, () => console.error(`app listening on port ${port}`));
