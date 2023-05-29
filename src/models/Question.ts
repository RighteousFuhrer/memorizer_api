import { QestionType } from "@prisma/client";

export interface Question {
  question: string;
  topicId: number;
}

export interface Option {
  text: string;
  correct: boolean;
}

export interface QuestionSelectDto extends Question {
  options: Option[];
}

export interface QuestionImageDto extends Question {
  imageBlob: String;
}

export interface QuestionTextDto extends Question {
  text: String;
}
