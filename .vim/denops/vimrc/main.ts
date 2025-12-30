import type { Entrypoint, Denops } from "@denops/std";
import { assert, is } from "@core/unknownutil";

import { format } from "date-fns";

export const main: Entrypoint = (denops: Denops) => {
  denops.dispatcher = {
    decodeURIComponent(s: unknown) {
      assert(s, is.String);
      return globalThis.decodeURIComponent(s);
    },
    encodeURIComponent(s: unknown) {
      assert(s, is.String);
      return globalThis.encodeURIComponent(s);
    },
    dateIso8601() {
      return format(new Date(), "yyyyMMdd'T'HHmmssXX");
    },
    dateFormat(s: unknown) {
      assert(s, is.String);
      return format(new Date(), s);
    },
  };
};
