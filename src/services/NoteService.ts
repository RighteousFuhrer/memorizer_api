import { PrismaClient } from "@prisma/client";
import { KanjiDto, NoteDto, ParagraphDto, WordDto } from "../models/Note";

export class NoteService {
  prismaClient: PrismaClient;
  constructor(prismaClient: PrismaClient) {
    this.prismaClient = prismaClient;
  }
  async create(note: NoteDto) {
    if (note.kanji) {
      const res = await this.createKanji(note.topicId, note.kanji);
      return res;
    } else if (note.word) {
      const res = await this.createWord(note.topicId, note.word);
      return res;
    } else if (note.paragraph) {
      const res = await this.createParagraph(note.topicId, note.paragraph);
      return res;
    }
    return null;
  }

  async createKanji(topicId: number, kanji: KanjiDto) {
    try {
      const res = await this.prismaClient.note.create({
        data: {
          type: "kanji",
          topicId: topicId,
          kanji: {
            create: {
              symbol: kanji.symbol,
              link: kanji.link,
              examples: {
                createMany: {
                  data: kanji.examples.map((example) => {
                    return {
                      example,
                    };
                  }),
                },
              },
              translations: {
                createMany: {
                  data: kanji.translations.map((translation) => {
                    return {
                      translation,
                    };
                  }),
                },
              },
              forms: {
                createMany: {
                  data: kanji.forms.map((form) => {
                    return {
                      form,
                    };
                  }),
                },
              },
            },
          },
        },
      });
      return res;
    } catch (error) {
      throw new Error(error as any);
    }
  }

  async createWord(topicId: number, word: WordDto) {
    try {
      const res = await this.prismaClient.note.create({
        data: {
          type: "word",
          topicId: topicId,
          word: {
            create: {
              hirogana: word.hirogana,
              katakana: word.katakana,
              romanji: word.romanji,
              kanji: word.kanji,
              translation: {
                createMany: {
                  data: word.translations.map((translation) => {
                    return {
                      translation,
                    };
                  }),
                },
              },
            },
          },
        },
      });
      return res;
    } catch (error) {
      throw new Error(error as any);
    }
  }

  async createParagraph(topicId: number, paragraph: ParagraphDto) {
    try {
      const res = await this.prismaClient.note.create({
        data: {
          type: "paragraph",
          topicId: topicId,
          paragraph: {
            create: {
              link: paragraph.link,
              text: paragraph.text,
              title: paragraph.title,
            },
          },
        },
      });
      return res;
    } catch (error) {
      throw new Error(error as any);
    }
  }
  async getAllByTopicId(topicId: number) {
    try {
      const notes = await this.prismaClient.note.findMany({
        where: { topicId },
      });
      return notes;
    } catch (error) {
      throw new Error(error as any);
    }
  }
  async update(id: number, note: NoteDto) {
    try {
      if (note.kanji) {
        const res = await this.updateKanji(note.topicId, note.kanji);
        return res;
      } else if (note.word) {
        const res = await this.updateWord(note.topicId, note.word);
        return res;
      } else if (note.paragraph) {
        const res = await this.updateParagraph(note.topicId, note.paragraph);
        return res;
      }
      return null;
    } catch (error) {
      throw new Error(error as any);
    }
  }
  async updateKanji(id: number, kanji: KanjiDto) {
    try {
      const newKanji = await this.prismaClient.note.update({
        where: {
          id,
        },
        data: {
          kanji: {
            delete: true,
            create: {
              symbol: kanji.symbol,
              link: kanji.link,
              examples: {
                createMany: {
                  data: kanji.examples.map((example) => {
                    return {
                      example,
                    };
                  }),
                },
              },
              forms: {
                createMany: {
                  data: kanji.forms.map((form) => {
                    return {
                      form,
                    };
                  }),
                },
              },
              translations: {
                createMany: {
                  data: kanji.translations.map((translation) => {
                    return {
                      translation,
                    };
                  }),
                },
              },
            },
          },
        },
      });

      return newKanji;
    } catch (error) {
      throw new Error(error as any);
    }
  }
  async updateWord(id: number, word: WordDto) {
    try {
      const newWord = await this.prismaClient.note.update({
        where: {
          id,
        },
        data: {
          word: {
            delete: true,
            create: {
              hirogana: word.hirogana,
              katakana: word.katakana,
              romanji: word.romanji,
              kanji: word.kanji,
              translation: {
                createMany: {
                  data: word.translations.map((translation) => {
                    return {
                      translation,
                    };
                  }),
                },
              },
            },
          },
        },
      });

      return newWord;
    } catch (error) {
      throw new Error(error as any);
    }
  }
  async updateParagraph(id: number, paragraph: ParagraphDto) {
    try {
      const newWord = await this.prismaClient.note.update({
        where: {
          id,
        },
        data: {
          paragraph: {
            delete: true,
            create: {
              link: paragraph.link,
              text: paragraph.text,
              title: paragraph.title,
            },
          },
        },
      });

      return newWord;
    } catch (error) {
      throw new Error(error as any);
    }
  }
  async delete(id: number) {
    try {
      const res = await this.prismaClient.note.delete({ where: { id } });
      return res;
    } catch (error) {
      throw new Error(error as any);
    }
  }
}
