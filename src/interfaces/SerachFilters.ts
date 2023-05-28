import { ExamPreset, Subject } from "@prisma/client";

export interface resultFilter {
  order: "asc" | "desc";
  sort: string;
  presets: ExamPreset[];
}

export interface topicFilter {
    order: "asc" | "desc";
    sort: string;
    subjects: Subject[];
  }
  
