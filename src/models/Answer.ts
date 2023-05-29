import { Correctness } from "@prisma/client";

export interface AnswerDto {
  questionId: number;
  correct: Correctness;
  text?: string;
  image?: string;
  selected?: { id: number }[];
}
