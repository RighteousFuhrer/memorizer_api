export interface KanjiDto {
  symbol: string;
  link: string;
  translations: string[];
  forms: string[];
  examples: string[];
}

export interface WordDto {
  katakana: string;
  hirogana: string;
  translations: string[];
  kanji?: string;
  romanji: string;
}
export interface ParagraphDto {
  title: string;
  link: string;
  text: string;
}

export interface NoteDto {
  topicId: number;
  kanji?: KanjiDto;
  word?: WordDto;
  paragraph?: ParagraphDto;
}
