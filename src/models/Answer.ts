import { Correctness } from "@prisma/client";

export interface AnswerDto {
    questionId: number,
    value : string,
    correct: Correctness
}